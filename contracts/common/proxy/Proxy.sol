// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

import "./ProxyStorage.sol";
import "./initialization/IInitializable.sol";
import "../interfaces/IERC165.sol";

contract Proxy is ProxyStorage {
    error EmptySetupAddress();
    error UnknownMethod();

    constructor(address setup) {
        if (setup == address(0x00)) revert Proxy.EmptySetupAddress();
        _initializerAddress = msg.sender;

        _methods[IInitializable.initialize.selector] = setup;
        _methods[IERC165.supportsInterface.selector] = setup;
    }

    receive() external payable virtual {}


    fallback() external payable {
        address impl = _methods[msg.sig];
        if (impl == address(0x00)) revert UnknownMethod();

        assembly {
            let p := mload(0x40)
            calldatacopy(p, 0x00, calldatasize())
            let result := delegatecall(gas(), impl, p, calldatasize(), 0x00, 0x00)
            let size := returndatasize()
            returndatacopy(p, 0x00, size)

            switch result
            case 0x00 {
                revert(p, size)
            }
            default {
                return(p, size)
            }
        }
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./InventoryStorage.sol";
import "./interfaces/IInventoryProxyInitizable.sol";
import "../common/interfaces/IERC165.sol";

contract InventoryProxy is InventoryStorage {

    error EmptySetupAddress();
    error UnknownMethod();

    constructor(address setup) {
        if (setup == address(0x00)) revert EmptySetupAddress();

        _methods[IInventoryProxyInitizable.initialize.selector] = setup;
        _methods[IERC165.supportsInterface.selector] = setup;
    }

    receive() external payable {}


    fallback() external payable {
        address _impl = _methods[msg.sig];
        if (_impl == address(0x00)) revert UnknownMethod();

        assembly {
            let p := mload(0x40)
            calldatacopy(p, 0x00, calldatasize())
            let result := delegatecall(gas(), _impl, p, calldatasize(), 0x00, 0x00)
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

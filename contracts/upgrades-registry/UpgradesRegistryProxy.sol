// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./UpgradesRegistryStorage.sol";
import "./interfaces/IUpgradesRegistryInitializable.sol";
import "../common/interfaces/IERC165.sol";

contract UpgradesRegistryProxy is UpgradesRegistryStorage {

    error EmptySetupAddress();
    error UnknownMethod();

    constructor(address setup) {
        if (setup == address(0x00)) revert EmptySetupAddress();

        _methods[IUpgradesRegistryInitializable.initialize.selector] = setup;
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

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./UpgradesRegistryStorage.sol";
import "./interfaces/IUpgradesRegistryInitializable.sol";
import "../common/interfaces/IERC165.sol";
import "../common/proxy/Proxy.sol";

contract UpgradesRegistryProxy is UpgradesRegistryStorage {
    constructor(address setup) {
        if (setup == address(0x00)) revert Proxy.EmptySetupAddress();
        _initializerAddress = msg.sender;

        _methods[IUpgradesRegistryInitializable.initialize.selector] = setup;
        _methods[IERC165.supportsInterface.selector] = setup;
    }

    receive() external payable {}


    fallback() external payable {
        Proxy._fallback(_methods[msg.sig]);
    }
}

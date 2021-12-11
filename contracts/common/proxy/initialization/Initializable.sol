// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

import "./InitializableErrors.sol";
import "./IInitializable.sol";
import "../ProxyStorage.sol";

contract Initializable is IInitializable, ProxyStorage {
    modifier isInitializer(address initializer) {
        if (msg.sender != initializer) revert InitializableErrors.NotInitializer();
        _;
    }

    function initialize(bytes memory) public override virtual isInitializer(_initializerAddress) {
        delete _initializerAddress;
        delete _methods[msg.sig];
    }
}

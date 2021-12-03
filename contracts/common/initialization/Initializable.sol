// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./InitializableErrors.sol";

contract Initializable {
    modifier isInitializer(address initializer) {
        if (msg.sender != initializer) revert InitializableErrors.NotInitializer();
        _;
    }
}

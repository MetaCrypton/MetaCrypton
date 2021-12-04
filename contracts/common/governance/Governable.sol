// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./GovernableErrors.sol";
import "./GovernableStorage.sol";

contract Governable is GovernableStorage {
    modifier isGovernance() {
        if (msg.sender != _governance) revert GovernableErrors.NotGovernance();
        _;
    }
}

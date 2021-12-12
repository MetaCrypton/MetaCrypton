// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./GovernableErrors.sol";
import "./GovernableStorage.sol";

contract Governable is GovernableStorage {
    modifier isGovernance() {
        if (msg.sender != _governance) revert GovernableErrors.NotGovernance();
        _;
    }
}

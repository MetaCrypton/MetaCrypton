// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../common/governance/interfaces/IGovernance.sol";

contract Governance is IGovernance {
    function requestPermission(address sender, address target) external view override {}
}

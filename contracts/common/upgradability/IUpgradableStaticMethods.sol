// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

interface IUpgradableStaticMethods {
    function getCurrentUpgrades_() external view returns (uint256[] memory upgradesIndexes);

    function getMaxPossibleUpgradeIndex_() external view returns (uint256 index);
}

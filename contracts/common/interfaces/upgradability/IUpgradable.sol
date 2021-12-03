// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

interface IUpgradable {
    function upgrade(uint256 upgradeIndex) external;

    function getCurrentUpgrades() external view returns (uint256[] memory upgradesIndexes);

    function getMaxPossibleUpgradeIndex() external view returns (uint256 index);
}

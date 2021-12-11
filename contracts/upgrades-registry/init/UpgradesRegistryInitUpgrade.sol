// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

import "./UpgradesRegistryInitCommon.sol";
import "../interfaces/IUpgradesRegistry.sol";
import "../../common/upgradability/IUpgrade.sol";
import "../../common/proxy/initialization/InitializableErrors.sol";

contract UpgradesRegistryInitUpgrade is
    IUpgrade,
    UpgradesRegistryInitCommon
{
    function supportsInterface(bytes4 interfaceId) external view override returns (bool) {
        return _methods[interfaceId] != address(0x00)
            || interfaceId == type(IERC165).interfaceId
            || interfaceId == type(IUpgradable).interfaceId
            || interfaceId == type(IUpgrade).interfaceId
            || interfaceId == type(IUpgradesRegistry).interfaceId;
    }

    function getProxyId() external pure override returns (bytes32) {
        return PROXY_ID;
    }

    function applyUpgrade() external pure override {
        revert InitializableErrors.NoApplyUpgradeOnInit();
    }
}

// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../../InventoryStorage.sol";
import "../../interfaces/IInventory.sol";
import "../../../common/proxy/initialization/InitializableErrors.sol";
import "../../../common/upgradability/IUpgrade.sol";
import "../../../common/upgradability/IUpgradable.sol";


contract InventoryInitUpgrade is
    IUpgrade,
    InventoryStorage
{
    function supportsInterface(bytes4 interfaceId) external view override returns (bool) {
        return _methods[interfaceId] != address(0x00)
            || interfaceId == type(IERC165).interfaceId
            || interfaceId == type(IUpgradable).interfaceId
            || interfaceId == type(IUpgrade).interfaceId
            || interfaceId == type(IInventory).interfaceId;
    }

    function getProxyId() external pure override returns (bytes32) {
        return PROXY_ID;
    }

    function applyUpgrade() external pure override {
        revert InitializableErrors.NoApplyUpgradeOnInit();
    }
}
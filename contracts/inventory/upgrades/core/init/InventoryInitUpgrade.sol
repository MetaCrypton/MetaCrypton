// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../../../InventoryStorage.sol";
import "../../../interfaces/IInventory.sol";
import "../../../../common/proxy/initialization/InitializableErrors.sol";
import "../../../../common/upgradability/IUpgrade.sol";
import "../../../../common/upgradability/IUpgradeStaticMethods.sol";
import "../../../../common/upgradability/IUpgradable.sol";

contract InventoryInitUpgrade is IUpgrade, IUpgradeStaticMethods, InventoryStorage {
    function supportsInterface_(bytes4 interfaceId) external view override returns (bool) {
        return supportsInterface(interfaceId);
    }

    function getProxyId_() external pure override returns (bytes32) {
        return getProxyId();
    }

    function applyUpgrade() external pure override {
        revert InitializableErrors.NoApplyUpgradeOnInit();
    }

    function supportsInterface(bytes4 interfaceId) public view override returns (bool) {
        return
            _methods[interfaceId] != address(0x00) ||
            interfaceId == type(IERC165).interfaceId ||
            interfaceId == type(IUpgradable).interfaceId ||
            interfaceId == type(IUpgrade).interfaceId ||
            interfaceId == type(IInventory).interfaceId;
    }

    function getProxyId() public pure override returns (bytes32) {
        return PROXY_ID;
    }
}

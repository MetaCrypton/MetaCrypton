// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../../../NFTStorage.sol";
import "../../../interfaces/INFT.sol";
import "../../../../upgrades-registry/interfaces/IUpgradesRegistry.sol";
import "../../../../common/proxy/initialization/IInitializable.sol";
import "../../../../common/proxy/initialization/Initializable.sol";
import "../../../../common/upgradability/IUpgrade.sol";
import "../../../../common/upgradability/IUpgradable.sol";


contract NFTInitInitializable is
    IInitializable,
    Initializable,
    NFTStorage
{
    error EmptyUpgradesRegistry();
    error EmptyInventoryInterfaceSetup();
    error EmptyInventorySetup();

    function initialize(bytes memory input) public override (IInitializable, Initializable) {
        (
            address upgradesRegistry,
            address inventoryInterface,
            address inventorySetup,
            uint256[] memory inventoryUpgrades
        ) = abi.decode(input, (address, address, address, uint256[]));
        if (upgradesRegistry == address(0x00)) revert EmptyUpgradesRegistry();
        if (inventoryInterface == address(0x00)) revert EmptyInventoryInterfaceSetup();
        if (inventorySetup == address(0x00)) revert EmptyInventorySetup();
        _upgradesRegistry = upgradesRegistry;
        _inventoryInterface = inventoryInterface;
        _inventorySetup = inventorySetup;
        _inventoryUpgrades = inventoryUpgrades;
        
        _storeMethods(_methods[msg.sig]);

        super.initialize(input);
    }

    function _storeMethods(address upgradeAddress) internal {
        _methods[INFT(address(0x00)).setGovernance.selector] = upgradeAddress;

        _methods[INFT(address(0x00)).inventoryOf.selector] = upgradeAddress;
        _methods[INFT(address(0x00)).tokenIdByInventory.selector] = upgradeAddress;

        _methods[IUpgradable(address(0x00)).upgrade.selector] = upgradeAddress;
        _methods[IUpgradable(address(0x00)).getCurrentUpgrades.selector] = upgradeAddress;
        _methods[IUpgradable(address(0x00)).getMaxPossibleUpgradeIndex.selector] = upgradeAddress;

        _methods[IUpgrade(address(0x00)).getProxyId.selector] = upgradeAddress;
        _methods[IUpgrade(address(0x00)).supportsInterface.selector] = upgradeAddress;
    }
}
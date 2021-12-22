// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../../InventoryStorage.sol";
import "../../interfaces/IInventory.sol";
import "../../../upgrades-registry/interfaces/IUpgradesRegistry.sol";
import "../../../common/proxy/initialization/IInitializable.sol";
import "../../../common/proxy/initialization/Initializable.sol";
import "../../../common/upgradability/IUpgrade.sol";
import "../../../common/upgradability/IUpgradable.sol";


contract InventoryInitInitializable is
    IInitializable,
    Initializable,
    InventoryStorage
{
    error EmptyNftAddress();
    error EmptyUpgradesRegistry();
    
    function initialize(bytes memory input) public override (IInitializable, Initializable) {
        (address nftAddress, uint256 nftId, address upgradesRegistry) = abi.decode(input, (address, uint256, address));
        if (nftAddress == address(0x00)) revert EmptyNftAddress();
        if (upgradesRegistry == address(0x00)) revert EmptyUpgradesRegistry();
        _governance = nftAddress;
        _nftAddress = nftAddress;
        _nftId = nftId;
        _upgradesRegistry = upgradesRegistry;
        
        _storeMethods(_methods[msg.sig]);

        super.initialize(input);
    }

    function _storeMethods(address upgradeAddress) internal {
        _methods[IInventory(address(0x00)).depositERC20.selector] = upgradeAddress;
        _methods[IInventory(address(0x00)).withdrawERC20.selector] = upgradeAddress;
        _methods[IInventory(address(0x00)).getERC20s.selector] = upgradeAddress;
        _methods[IInventory(address(0x00)).getERC20Balance.selector] = upgradeAddress;

        _methods[IInventory(address(0x00)).depositERC721.selector] = upgradeAddress;
        _methods[IInventory(address(0x00)).withdrawERC721.selector] = upgradeAddress;
        _methods[IInventory(address(0x00)).getERC721s.selector] = upgradeAddress;
        _methods[IInventory(address(0x00)).isERC721Owner.selector] = upgradeAddress;

        _methods[IInventory(address(0x00)).onERC721Received.selector] = upgradeAddress;

        _methods[IUpgradable(address(0x00)).upgrade.selector] = upgradeAddress;
        _methods[IUpgradable(address(0x00)).getCurrentUpgrades.selector] = upgradeAddress;
        _methods[IUpgradable(address(0x00)).getMaxPossibleUpgradeIndex.selector] = upgradeAddress;

        _methods[IUpgrade(address(0x00)).getProxyId.selector] = upgradeAddress;
        _methods[IUpgrade(address(0x00)).supportsInterface.selector] = upgradeAddress;
    }
}
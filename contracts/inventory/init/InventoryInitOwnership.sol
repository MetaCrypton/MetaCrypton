// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

import "../InventoryStorage.sol";
import "../InventoryErrors.sol";
import "../../upgrades-registry/interfaces/IUpgradesRegistry.sol";
import "../../common/interfaces/IERC721.sol";
import "../../common/upgradability/IUpgrade.sol";
import "../../common/upgradability/IUpgradable.sol";


contract InventoryInitOwnership is InventoryStorage {
    modifier isOwner() {
        if (msg.sender != IERC721(_nftAddress).ownerOf(_nftId)) revert InventoryErrors.NotInventoryNftOwner();
        _;
    }
}
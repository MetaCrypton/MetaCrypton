// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../InventoryStorage.sol";
import "../../upgrades-registry/interfaces/IUpgradesRegistry.sol";
import "../../common/interfaces/IERC721.sol";
import "../../common/upgradability/IUpgrade.sol";
import "../../common/upgradability/IUpgradable.sol";


contract InventoryInitOwnership is InventoryStorage {
    error NotInventoryNftOwner();

    modifier isOwner() {
        if (msg.sender != IERC721(_nftAddress).ownerOf(_nftId)) revert NotInventoryNftOwner();
        _;
    }
}
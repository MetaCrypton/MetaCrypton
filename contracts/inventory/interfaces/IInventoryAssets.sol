// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../InventoryStructs.sol";

interface IInventoryAssets {
    event AssetAdded(
        uint256 indexed id,
        AssetType indexed assetType,
        bytes data
    );

    event AssetUpdated(
        uint256 indexed id,
        bytes data
    );

    event AssetRemoved(uint256 indexed id);
}

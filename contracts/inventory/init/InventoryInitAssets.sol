// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../InventoryStorage.sol";
import "../interfaces/IInventoryAssets.sol";
import "../InventoryErrors.sol";

contract InventoryInitAssets is IInventoryAssets, InventoryStorage {
    function _addAsset(uint256 id, AssetType assetType, bytes memory data) internal {
        _assets.assets.push(Asset(id, assetType, data));
        _assets.assetIndexById[id] = _assets.assets.length;

        emit AssetAdded(
            id,
            assetType,
            data
        );
    }

    function _updateAsset(Asset storage asset, bytes memory data) internal {
        asset.data = data;

        emit AssetUpdated(asset.id, data);
    }

    function _removeAsset(uint256 index, Asset storage toRemove) internal {
        uint256 idToRemove = toRemove.id;

        uint256 lastIndex = _assets.assets.length - 1;
        Asset memory last = _assets.assets[lastIndex];
        
        toRemove.id = last.id;
        toRemove.assetType = last.assetType;
        toRemove.data = last.data;
        _assets.assetIndexById[last.id] = index;

        _assets.assets.pop();
        delete _assets.assetIndexById[idToRemove];

        emit AssetRemoved(idToRemove);
    }

    function _getAssets(uint256 startIndex, uint256 number) internal view returns (Asset[] memory) {
        uint256 endIndex = startIndex + number;
        if (endIndex >= _assets.assets.length) revert InventoryErrors.WrongEndIndex();
        
        Asset[] memory assets = new Asset[](number);
        for (uint256 i = startIndex; i < endIndex; i++) {
            assets[i - startIndex] = _assets.assets[i];
        }
        return assets;
    }

    function _getAssetByIndex(uint256 index) internal view returns (Asset storage) {
        return _assets.assets[index - 1];
    }

    function _getAssetIndexById(uint256 id) internal view returns (uint256) {
        uint256 index = _assets.assetIndexById[id];
        return index;
    }
}

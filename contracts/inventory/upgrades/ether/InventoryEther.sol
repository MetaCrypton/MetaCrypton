// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./InventoryEtherUpgrade.sol";
import "../init/InventoryInitAssets.sol";
import "../init/InventoryInitOwnership.sol";
import "../../InventoryErrors.sol";
import "../../InventoryStorage.sol";
import "../../interfaces/IInventoryEtherInternal.sol";
import "../../interfaces/IInventoryEther.sol";
import "../../interfaces/IInventory.sol";
import "../../interfaces/IInventoryEvents.sol";
import "../../../common/interfaces/IERC165.sol";

contract InventoryEther is
    IInventoryEther,
    IInventoryEvents,
    InventoryEtherUpgrade,
    InventoryInitOwnership
{
    using InventoryInitAssets for *;

    modifier verifyEtherInput(uint256 amount) {
        if (amount == 0) revert InventoryErrors.ZeroAmount();
        _;
    }

    function depositEther(bytes calldata data) external payable override isOwner returns (bytes memory) {
        _depositEther(msg.value);

        if (IERC165(address(this)).supportsInterface(IInventoryEtherInternal(address(0x00)).processDepositEther.selector)) {
            return IInventoryEtherInternal(address(this)).processDepositEther(msg.sender, msg.value, data);
        }
        return new bytes(0);
    }

    function withdrawEther(address recipient, uint256 amount, bytes calldata data) external override isOwner returns (bytes memory) {
        _withdrawEther(recipient, amount);

        if (IERC165(address(this)).supportsInterface(IInventoryEtherInternal(address(0x00)).processWithdrawEther.selector)) {
            return IInventoryEtherInternal(address(this)).processWithdrawEther(recipient, amount, data);
        }
        return new bytes(0);
    }
    
    function getEtherBalance() external view override returns (uint256) {
        uint256 id = _getEtherId();
        uint256 index = _assetsSet._getAssetIndexById(id);
        if (index == 0) revert InventoryErrors.UnexistingAsset();

        Asset storage asset = _assetsSet._getAssetByIndex(index);
        EtherStruct memory storedEther = _assetToEther(asset);

        return storedEther.amount;
    }

    function _depositEther(uint256 amount) internal verifyEtherInput(amount) {
        emit DepositEther(msg.sender, amount);

        uint256 id = _getEtherId();
        uint256 index = _assetsSet._getAssetIndexById(id);

        if (index == 0) {
            bytes memory data = abi.encode(EtherStruct(amount));
            emit AssetAdded(
                id,
                AssetType.Ether,
                data
            );
            _assetsSet._addAsset(id, AssetType.Ether, data);
        } else {
            Asset storage asset = _assetsSet._getAssetByIndex(index);
            EtherStruct memory storedEther = _assetToEther(asset);
            if (type(uint256).max - storedEther.amount < amount) revert InventoryErrors.DepositOverflow();
            storedEther.amount += amount;

            bytes memory data = abi.encode(storedEther);
            emit AssetUpdated(id, data);
            asset._updateAsset(data);
        }
    }

    function _withdrawEther(address recipient, uint256 amount) internal verifyEtherInput(amount) {
        emit WithdrawEther(recipient, amount);

        uint256 id = _getEtherId();
        uint256 index = _assetsSet._getAssetIndexById(id);
        if (index == 0) revert InventoryErrors.UnexistingAsset();

        Asset storage asset = _assetsSet._getAssetByIndex(index);
        EtherStruct memory storedEther = _assetToEther(asset);
        if (storedEther.amount < amount) revert InventoryErrors.WithdrawOverflow();

        storedEther.amount -= amount;
        if (storedEther.amount > 0) {
            bytes memory data = abi.encode(storedEther);
            emit AssetUpdated(id, data);
            asset._updateAsset(data);
        } else {
            emit AssetRemoved(id);
            _assetsSet._removeAsset(index);
        }

        (bool success, ) = recipient.call{value: amount}("");
        if (!success) revert InventoryErrors.EtherTransferFailed();
    }

    function _assetToEther(Asset memory asset) internal pure returns (EtherStruct memory) {
        if (asset.assetType != AssetType.Ether) revert InventoryErrors.UnmatchingAssetType();

        return abi.decode(asset.data, (EtherStruct));
    }
    
    function _getEtherId() internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked("Ether")));
    } 
}

// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./InventoryInitAssets.sol";
import "./InventoryInitOwnership.sol";
import "../InventoryErrors.sol";
import "../InventoryStorage.sol";
import "../interfaces/IInventoryERC721Internal.sol";
import "../interfaces/IInventoryERC721.sol";
import "../interfaces/IInventory.sol";
import "../interfaces/IInventoryEvents.sol";
import "../../common/interfaces/IERC721.sol";
import "../../common/interfaces/IERC165.sol";

contract InventoryInitERC721 is
    IInventoryERC721,
    IInventoryEvents,
    InventoryInitOwnership
{
    using InventoryInitAssets for *;

    modifier verifyERC721Input(address token) {
        if (token == address(0x00)) revert InventoryErrors.EmptyAddress();
        _;
    }

    function depositERC721(address from, address token, uint256 tokenId, bytes calldata data) external override isOwner returns (bytes memory) {
        _depositERC721(from, token, tokenId);

        if (IERC165(address(this)).supportsInterface(IInventoryERC721Internal(address(0x00)).processDepositERC721.selector)) {
            return IInventoryERC721Internal(address(this)).processDepositERC721(from, token, tokenId, data);
        }
        return new bytes(0);
    }

    function withdrawERC721(address recipient, address token, uint256 tokenId, bytes calldata data) external override isOwner returns (bytes memory) {
        _withdrawERC721(recipient, token, tokenId);

        if (IERC165(address(this)).supportsInterface(IInventoryERC721Internal(address(0x00)).processWithdrawERC721.selector)) {
            return IInventoryERC721Internal(address(this)).processWithdrawERC721(recipient, token, tokenId, data);
        }
        return new bytes(0);
    }
    
    function getERC721s(uint256 startIndex, uint256 number) external view override returns (ERC721Struct[] memory) {
        return _assetsSetListToERC721(_assetsSet._getAssets(startIndex, number));
    }
    
    function isERC721Owner(address token, uint256 tokenId) external view override returns (bool) {
        uint256 id = _getERC721Id(token, tokenId);
        uint256 index = _assetsSet._getAssetIndexById(id);
        return index != 0;
    }

    function _depositERC721(address from, address token, uint256 tokenId) internal verifyERC721Input(token) {
        emit DepositERC721(
            from,
            token,
            tokenId
        );

        uint256 id = _getERC721Id(token, tokenId);
        uint256 index = _assetsSet._getAssetIndexById(id);

        if (index != 0) revert InventoryErrors.ExistingToken();
        bytes memory data = abi.encode(ERC721Struct(token, tokenId));
        emit AssetAdded(
            id,
            AssetType.ERC721,
            data
        );
        _assetsSet._addAsset(id, AssetType.ERC721, data);

        IERC721(token).transferFrom(from, address(this), tokenId);
    }

    function _withdrawERC721(address recipient, address token, uint256 tokenId) internal verifyERC721Input(token) {
        emit WithdrawERC721(
            recipient,
            token,
            tokenId
        );

        uint256 id = _getERC721Id(token, tokenId);
        uint256 index = _assetsSet._getAssetIndexById(id);
        if (index == 0) revert InventoryErrors.UnexistingAsset();

        Asset storage asset = _assetsSet._getAssetByIndex(index);
        ERC721Struct memory storedToken = _assetToERC721Token(asset);
        if (storedToken.tokenAddress != token) revert InventoryErrors.UnmatchingTokenAddress();
        if (storedToken.tokenId != tokenId) revert InventoryErrors.UnmatchingTokenId();

        emit AssetRemoved(id);
        _assetsSet._removeAsset(index);

        IERC721(token).transferFrom(address(this), recipient, tokenId);
    }

    function _assetToERC721Token(Asset memory asset) internal pure returns (ERC721Struct memory) {
        if (asset.assetType != AssetType.ERC721) revert InventoryErrors.UnmatchingAssetType();

        return abi.decode(asset.data, (ERC721Struct));
    }

    function _assetsSetListToERC721(Asset[] memory assets) internal pure returns (ERC721Struct[] memory) {
        uint256 tokensLength = 0;
        uint256 assetsLength = assets.length;

        for (uint256 i = 0; i < assetsLength; i++) {
            if (assets[i].assetType == AssetType.ERC721) {
                tokensLength++;
            }
        }

        ERC721Struct[] memory tokens = new ERC721Struct[](tokensLength);
        uint256 counter = 0;
        for (uint256 i = 0; i < assetsLength; i++) {
            if (assets[i].assetType == AssetType.ERC721) {
                tokens[counter++] = _assetToERC721Token(assets[i]);
            }
        }

        return tokens;
    }
    
    function _getERC721Id(address token, uint256 tokenId) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(token, tokenId)));
    } 
}

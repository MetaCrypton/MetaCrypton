// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./InventoryLootboxUpgrade.sol";
import "../init/InventoryInitAssets.sol";
import "../init/InventoryInitOwnership.sol";
import "../../InventoryErrors.sol";
import "../../InventoryStorage.sol";
import "../../interfaces/IInventoryLootbox.sol";
import "../../interfaces/IInventory.sol";
import "../../interfaces/IInventoryEvents.sol";
import "../../../nft/interfaces/INFTLootbox.sol";
import "../../../common/governance/Governable.sol";
import "../../../common/interfaces/IERC165.sol";
import "../../../common/interfaces/IERC721Mintable.sol";

contract InventoryLootbox is
    IInventoryLootbox,
    IInventoryEvents,
    Governable,
    InventoryLootboxUpgrade,
    InventoryInitOwnership
{
    using InventoryInitAssets for *;

    function reveal() external override isOwner returns (address token, uint256[] memory tokensIds) {
        tokensIds = new uint256[](3);
        address lootNFT = INFTLootbox(_nftAddress).getLootNFT();

        tokensIds[0] = IERC721Mintable(lootNFT).mint(address(this));
        tokensIds[1] = IERC721Mintable(lootNFT).mint(address(this));
        tokensIds[2] = IERC721Mintable(lootNFT).mint(address(this));

        _addERC721(lootNFT, tokensIds[0]);
        _addERC721(lootNFT, tokensIds[1]);
        _addERC721(lootNFT, tokensIds[2]);

        return (lootNFT, tokensIds);
    }

    function _addERC721(address token, uint256 tokenId) internal {
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
    }

    function _getERC721Id(address token, uint256 tokenId) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(token, tokenId)));
    } 
}

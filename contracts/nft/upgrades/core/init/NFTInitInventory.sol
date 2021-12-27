// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./NFTInitCommon.sol";
import "../../../NFTStorage.sol";
import "../../../interfaces/INFTStaticMethods.sol";
import "../../../interfaces/INFTInventory.sol";

contract NFTInitInventory is
    INFTInventory,
    INFTInventoryStaticMethods,
    NFTStorage
{
    using NFTInitCommon for *;

    function inventoryOf_(uint256 tokenId) external view override returns (address owner) {
        return inventoryOf(tokenId);
    }

    function tokenIdByInventory_(address inventory) external view override returns (uint256) {
        return tokenIdByInventory(inventory);
    }

    function inventoryOf(uint256 tokenId) public view override returns (address owner) {
        Token storage token = _tokensSet._safeGetToken(tokenId);
        return token.inventory;
    }

    function tokenIdByInventory(address inventory) public view override returns (uint256) {
        uint256 tokenId = NFTInitCommon._addressToTokenId(inventory);
        _tokensSet._verifyTokenId(tokenId);
        return tokenId;
    }
}
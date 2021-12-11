// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./NFTInitCommon.sol";
import "../NFTStorage.sol";
import "../interfaces/INFTInventory.sol";

contract NFTInitInventory is
    INFTInventory,
    NFTStorage
{
    using NFTInitCommon for *;

    function inventoryOf(uint256 tokenId) external view override returns (address owner) {
        Token storage token = _tokensSet._safeGetToken(tokenId);
        return token.inventory;
    }

    function tokenIdByInventory(address inventory) external view override returns (uint256) {
        uint256 tokenId = NFTInitCommon._addressToTokenId(inventory);
        _tokensSet._verifyTokenId(tokenId);
        return tokenId;
    }
}
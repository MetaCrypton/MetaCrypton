// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

interface INFTInventory {
    function inventoryOf(uint256 tokenId) external view returns (address owner);

    function tokenIdByInventory(address inventory) external view returns (uint256);
}

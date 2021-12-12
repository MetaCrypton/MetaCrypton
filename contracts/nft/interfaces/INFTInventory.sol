// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

interface INFTInventory {
    function inventoryOf(uint256 tokenId) external view returns (address owner);

    function tokenIdByInventory(address inventory) external view returns (uint256);
}

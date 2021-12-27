// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

enum AssetType {
    Ether,
    ERC20,
    ERC721
}

struct Asset {
    uint256 id;
    AssetType assetType;
    bytes data;
}

struct AssetsSet {
    Asset[] assets;
    // Mapping from assets ids to their indexes plus 1 because 0 means that id is not in used
    mapping(uint256 => uint256) assetIndexById;
}

struct EtherStruct {
    uint256 amount;
}

struct ERC20Struct {
    address tokenAddress;
    uint256 amount;
}

struct ERC721Struct {
    address tokenAddress;
    uint256 tokenId;
}

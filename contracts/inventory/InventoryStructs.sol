// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
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
    mapping (uint256 => uint256) assetIndexById;
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

struct EternalStorage {
    mapping (bytes32 => uint) uints;
    mapping (bytes32 => int) ints;
    mapping (bytes32 => address) addresses;
    mapping (bytes32 => bytes32) bytes32s;
    mapping (bytes32 => bool) bools;
    mapping (bytes32 => bytes) bytesValues;
    mapping (bytes32 => uint[]) uintArrays;
    mapping (bytes32 => int[]) intArrays;
    mapping (bytes32 => address[]) addressArrays;
    mapping (bytes32 => bytes32[]) bytes32Arrays;
    mapping (bytes32 => bool[]) boolArrays;
    mapping (bytes32 => bytes[]) bytesArrays;
}

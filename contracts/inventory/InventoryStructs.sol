// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

struct ERC20Struct {
    address token;
    uint256 amount;
}

struct ERC20Set {
    ERC20Struct[] tokens;
    // Mapping from tokens addresses to their indexes plus 1 because 0 means that address is not in used
    mapping (address => uint256) tokenIndexByAddress;
}

struct ERC721Struct {
    address token;
    uint256[] tokenIds;
}

struct ERC721Set {
    ERC721Struct[] tokens;
    // Mapping from tokens addresses to their indexes plus 1 because 0 means that address is not in used
    mapping (address => uint256) tokenIndexByAddress;
    // Mapping from tokens addresses and ids to their indexes in tokenIds plus 1 because 0 means that address and id aren't not in used
    mapping (address => mapping (uint256 => uint256)) tokenIndexByAddressAndId;
}

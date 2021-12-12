// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

struct Token {
    uint256 id;
    address owner;
    address inventory;
}

struct TokensSet {
    // Tokens list
    Token[] tokens;
    // Mapping from tokens id to index plus 1 because 0 means that id is not in used
    mapping (uint256 => uint256) tokenIndexById;

    // Mapping from token id to approved address
    mapping (uint256 => address) tokenApprovalsById;
    
    // Mapping from owner to her tokens
    mapping (address => uint256[]) tokenIdsByOwner;

    // Mapping from owner to operator approvals
    mapping (address => mapping (address => bool)) operatorApprovals;
}

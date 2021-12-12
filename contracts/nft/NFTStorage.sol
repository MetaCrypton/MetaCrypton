// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./NFTStructs.sol";
import "../common/governance/GovernableStorage.sol";
import "../common/proxy/ProxyStorage.sol";

contract NFTStorage is ProxyStorage, GovernableStorage {
    bytes32 internal constant PROXY_ID = keccak256("NFT");

    string internal _name;
    string internal _symbol;
    string internal _baseURI;

    address internal _upgradesRegistry;
    
    address internal _inventorySetup;

    // Tokens set
    TokensSet internal _tokensSet;
}

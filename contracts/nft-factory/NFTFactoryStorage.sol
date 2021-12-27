// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./NFTFactoryStructs.sol";
import "../common/proxy/ProxyStorage.sol";

contract NFTFactoryStorage is ProxyStorage {
    bytes32 internal constant PROXY_ID = keccak256("NFTFactory");

    address internal _upgradesRegistry;

    address internal _nftSetup;
    address internal _inventorySetup;

    NFTToken[] internal _registeredTokens;
    mapping(string => uint256) internal _tokenBySymbol;
    mapping(address => uint256) internal _tokenByAddress;
    mapping(address => uint256[]) internal _tokensByGovernance;
}

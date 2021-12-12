// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./InventoryStructs.sol";
import "../common/proxy/ProxyStorage.sol";

contract InventoryStorage is ProxyStorage {
    bytes32 internal constant PROXY_ID = keccak256("Inventory");

    address internal _upgradesRegistry;

    address internal _nftAddress;
    uint256 internal _nftId;

    AssetsSet internal _assetsSet;
    EternalStorage internal _eternalStorage;
}

// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./UpgradesRegistryStructs.sol";
import "../common/proxy/ProxyStorage.sol";

contract UpgradesRegistryStorage is ProxyStorage {
    bytes32 internal constant PROXY_ID = keccak256("UpgradesRegistry");

    mapping(address => StoredProxy) internal _proxies;
    mapping(bytes32 => Upgrades) internal _upgrades;
}

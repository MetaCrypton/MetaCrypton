// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

import "./UpgradesRegistryStructs.sol";
import "../common/governance/GovernableStorage.sol";
import "../common/proxy/ProxyStorage.sol";

contract UpgradesRegistryStorage is ProxyStorage, GovernableStorage {
    bytes32 internal constant PROXY_ID = keccak256("UpgradesRegistry");

    mapping(address => StoredProxy) internal _proxies;
    mapping(bytes32 => Upgrades) internal _upgrades;
}

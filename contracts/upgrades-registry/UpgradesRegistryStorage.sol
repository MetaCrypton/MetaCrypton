// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../common/governance/GovernableStorage.sol";
import "../common/initialization/InitializableStorage.sol";

struct StoredProxy {
    bytes32 proxyId;
    uint256[] currentUpgradesList;
}

struct Upgrades {
    address[] upgradesAddresses;
    mapping(address => uint256) upgradesIndexes;
}

contract UpgradesRegistryStorage is GovernableStorage, InitializableStorage {
    bytes32 internal constant PROXY_ID = keccak256("UpgradesRegistry");

    mapping(address => StoredProxy) internal _proxies;
    mapping(bytes32 => Upgrades) internal _upgrades;

    mapping(bytes4 => address) internal _methods;
}

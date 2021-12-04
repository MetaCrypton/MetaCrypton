// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./UpgradesRegistryStorage.sol";
import "../common/proxy/Proxy.sol";

contract UpgradesRegistryProxy is Proxy, UpgradesRegistryStorage {
    constructor(address setup) Proxy(setup) { }
}

// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./UpgradesRegistryStorage.sol";
import "../common/proxy/Proxy.sol";

contract UpgradesRegistryProxy is Proxy, UpgradesRegistryStorage {
    constructor(
        address interfaceAddress,
        address setup,
        address governance
    ) Proxy(interfaceAddress, setup, governance) {}
}

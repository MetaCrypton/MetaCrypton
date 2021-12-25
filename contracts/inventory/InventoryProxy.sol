// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./InventoryStorage.sol";
import "../common/proxy/Proxy.sol";

contract InventoryProxy is Proxy, InventoryStorage {
    error UseDepositEtherFunction();

    constructor(address interfaceAddress, address setup, address governance) Proxy(interfaceAddress, setup, governance) { }

    receive() external payable override (Proxy) {
        revert UseDepositEtherFunction();
    }
}

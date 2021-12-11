// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

import "./TestStorage.sol";
import "../../common/proxy/Proxy.sol";

contract TestProxy is Proxy, TestStorage {
    constructor(address setup) Proxy(setup) { }
}

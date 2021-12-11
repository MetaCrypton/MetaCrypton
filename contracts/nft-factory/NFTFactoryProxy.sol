// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

import "./NFTFactoryStorage.sol";
import "../common/proxy/Proxy.sol";

contract NFTFactoryProxy is Proxy, NFTFactoryStorage {
    constructor(address setup) Proxy(setup) { }
}

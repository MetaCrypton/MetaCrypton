// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./TestStorage.sol";
import "../../common/proxy/Proxy.sol";

contract TestProxy is Proxy, TestStorage {
    constructor(address setup) Proxy(setup) { }
}

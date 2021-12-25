// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../governance/GovernableStorage.sol";

contract ProxyStorage is GovernableStorage {
    address internal _interfaceAddress;
    address internal _initializerAddress;
    mapping(bytes4 => address) internal _methods;
}

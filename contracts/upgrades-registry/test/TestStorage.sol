// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

import "../../common/proxy/ProxyStorage.sol";
import "../../common/governance/GovernableStorage.sol";

contract TestStorage is ProxyStorage, GovernableStorage {
    bytes32 internal constant PROXY_ID = keccak256("Test");

    address internal _upgradesRegistry;
}

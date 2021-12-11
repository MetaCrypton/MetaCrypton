// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

contract ProxyStorage {
    address internal _initializerAddress;
    mapping(bytes4 => address) internal _methods;
}

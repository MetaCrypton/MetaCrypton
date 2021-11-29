// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UpgradesRegistryStorage {
    address internal _owner;

    mapping(bytes4 => address) internal _methods;
}

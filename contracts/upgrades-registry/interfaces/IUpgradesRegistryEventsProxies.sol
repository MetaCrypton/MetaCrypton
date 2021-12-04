// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IUpgradesRegistryEventsProxies {
    event ProxyRegistered(bytes32 indexed proxyId, address indexed proxyAddress);
}

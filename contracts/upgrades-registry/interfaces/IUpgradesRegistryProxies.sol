// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IUpgradesRegistryProxies {
    function registerProxy(address proxyAddress) external;

    function getProxyId(address proxyAddress) external view returns (bytes32);

    function isProxyRegistered(address proxyAddress) external view returns (bool);
}

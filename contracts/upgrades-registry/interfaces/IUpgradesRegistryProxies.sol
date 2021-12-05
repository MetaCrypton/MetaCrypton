// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IUpgradesRegistryEventsProxies.sol";

interface IUpgradesRegistryProxies is IUpgradesRegistryEventsProxies {
    function registerProxy(address proxyAddress) external;

    function getProxyId(address proxyAddress) external view returns (bytes32);

    function isProxyRegistered(address proxyAddress) external view returns (bool);
}

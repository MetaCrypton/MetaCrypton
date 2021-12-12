// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

interface IUpgradesRegistryProxies {
    function registerProxy(address proxyAddress) external;

    function getProxyId(address proxyAddress) external view returns (bytes32);

    function isProxyRegistered(address proxyAddress) external view returns (bool);
}

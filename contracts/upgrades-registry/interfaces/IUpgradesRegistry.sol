// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IUpgradesRegistry {
    event ProxyRegistered(bytes32 indexed proxyId, address indexed proxy, uint256 indexed version);

    event UpgradeRegistered(bytes32 indexed proxyId, address indexed upgrade, uint256 indexed version);

    event ProxyUpdated(address indexed proxy, uint256 indexed version, address indexed upgrade);

    function registerProxy(address proxy) external;

    function getProxyId(address proxy) external view returns (bytes32);

    function isProxyRegistered(address proxy) external view returns (bool);

    function registerUpgrade(address upgrade) external;

    function updateProxy() external returns (address);

    function getProxyVersion(address proxy) external view returns (uint256);

    function getLatestProxyVersion(bytes32 proxyId) external view returns (uint256);
}

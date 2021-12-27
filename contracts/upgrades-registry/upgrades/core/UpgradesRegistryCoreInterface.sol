// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../../interfaces/IUpgradesRegistry.sol";
import "../../interfaces/IUpgradesRegistryStaticMethods.sol";
import "../../../common/proxy/contract-interface/Interface.sol";
import "../../../common/upgradability/IUpgrade.sol";
import "../../../common/upgradability/IUpgradable.sol";

contract UpgradesRegistryCoreInterface is IUpgradesRegistry, IUpgradable, IUpgrade, Interface {
    function registerProxy(address proxyAddress) external override {
        proxyAddress;
        _delegateCall();
    }

    function registerUpgrade(address upgradeAddress) external override {
        upgradeAddress;
        _delegateCall();
    }

    function upgradeProxy(uint256 upgradeIndex) external override returns (address upgradeAddress) {
        upgradeIndex;
        upgradeAddress;
        _delegateCall();
    }

    function setGovernance(address governance) external override {
        governance;
        _delegateCall();
    }

    function upgrade(uint256 upgradeIndex) external override {
        upgradeIndex;
        _delegateCall();
    }

    function applyUpgrade() external override {
        _delegateCall();
    }

    function getProxyId(address proxyAddress) external view override returns (bytes32 result) {
        result;
        bytes memory data = abi.encodeWithSelector(
            bytes4(keccak256("getProxyId_(address)")),
            proxyAddress
        );
        _staticCall(data);
    }

    function isProxyRegistered(address proxyAddress) external view override returns (bool result) {
        result;
        bytes memory data = abi.encodeWithSelector(
            IUpgradesRegistryStaticMethods(address(0x00)).isProxyRegistered_.selector,
            proxyAddress
        );
        _staticCall(data);
    }

    function getProxyCurrentUpgrades(address proxyAddress) external view override returns (uint256[] memory upgradesIndexes) {
        upgradesIndexes;
        bytes memory data = abi.encodeWithSelector(
            IUpgradesRegistryStaticMethods(address(0x00)).getProxyCurrentUpgrades_.selector,
            proxyAddress
        );
        _staticCall(data);
    }

    function getProxyMaxPossibleUpgradeIndex(bytes32 proxyId) external view override returns (uint256 index) {
        index;
        bytes memory data = abi.encodeWithSelector(
            IUpgradesRegistryStaticMethods(address(0x00)).getProxyMaxPossibleUpgradeIndex_.selector,
            proxyId
        );
        _staticCall(data);
    }

    function getCurrentUpgrades() external view override returns (uint256[] memory upgradesIndexes) {
        upgradesIndexes;
        bytes memory data = abi.encodeWithSelector(IUpgradableStaticMethods(address(0x00)).getCurrentUpgrades_.selector);
        _staticCall(data);
    }

    function getMaxPossibleUpgradeIndex() external view override returns (uint256 index) {
        index;
        bytes memory data = abi.encodeWithSelector(IUpgradableStaticMethods(address(0x00)).getMaxPossibleUpgradeIndex_.selector);
        _staticCall(data);
    }

    function getProxyId() external view override returns (bytes32 result) {
        result;
        bytes memory data = abi.encodeWithSelector(IUpgradeStaticMethods(address(0x00)).getProxyId_.selector);
        _staticCall(data);
    }

    function supportsInterface(bytes4 interfaceId) external view override returns (bool result) {
        result;
        bytes memory data = abi.encodeWithSelector(
            IUpgradeStaticMethods(address(0x00)).supportsInterface_.selector,
            interfaceId
        );
        _staticCall(data);
    }
}

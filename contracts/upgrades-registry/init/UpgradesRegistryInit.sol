// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./UpgradesRegistryInitCommon.sol";
import "./UpgradesRegistryInitErrors.sol";
import "../interfaces/IUpgradesRegistry.sol";
import "../interfaces/IUpgradesRegistryInitializable.sol";
import "../../common/governance/GovernableErrors.sol";
import "../../common/governance/Governable.sol";
import "../../common/initialization/InitializableErrors.sol";
import "../../common/initialization/Initializable.sol";
import "../../common/interfaces/upgradability/IUpgradable.sol";
import "../../common/interfaces/upgradability/IUpgrade.sol";

contract UpgradesRegistryInit is
    IUpgradesRegistryInitializable,
    IUpgradesRegistry,
    IUpgradable,
    IUpgrade,
    UpgradesRegistryInitCommon,
    Governable,
    Initializable
{
    function initialize(address governance) external override isInitializer(_initializerAddress) {
        if (governance == address(0x00)) revert GovernableErrors.EmptyGovernance();

        delete _initializerAddress;
        _governance = governance;

        address init = _methods[msg.sig];
        _methods[msg.sig] = address(0x00);

        _storeMethods(init);
        _storeUpgrade(PROXY_ID, init);
        _storeProxy(PROXY_ID, address(this));
    }

    function registerProxy(address proxyAddress) external override isGovernance(_governance) {
        bytes32 proxyId = _registerProxy(proxyAddress);

        emit ProxyRegistered(proxyId, proxyAddress);
    }

    function registerUpgrade(address upgradeAddress) external override isGovernance(_governance) {
        (bytes32 proxyId, uint256 upgradeIndex) = _registerUpgrade(upgradeAddress);

        emit UpgradeRegistered(proxyId, upgradeAddress, upgradeIndex);
    }

    function upgradeProxy(uint256 upgradeIndex) external override {
        _upgradeProxy(msg.sender, upgradeIndex);

        emit ProxyUpgraded(msg.sender, upgradeIndex);
    }

    function getProxyId(address proxyAddress) external view override returns (bytes32) {
        return _getProxyId(proxyAddress);
    }

    function isProxyRegistered(address proxyAddress) external view override returns (bool) {
        return _isProxyRegistered(proxyAddress);
    }

    function getProxyCurrentUpgrades(address proxyAddress) external view override returns (uint256[] memory upgradesIndexes) {
        return _getCurrentUpgrades(proxyAddress);
    }

    function getProxyMaxPossibleUpgradeIndex(bytes32 proxyId) external view override returns (uint index) {
        return _getProxyMaxPossibleUpgradeIndex(proxyId);
    }

    function _storeMethods(address upgradeAddress) internal {
        _methods[IUpgradesRegistry(address(0x00)).registerProxy.selector] = upgradeAddress;
        _methods[IUpgradesRegistry(address(0x00)).getProxyId.selector] = upgradeAddress;
        _methods[IUpgradesRegistry(address(0x00)).isProxyRegistered.selector] = upgradeAddress;
        _methods[IUpgradesRegistry(address(0x00)).registerUpgrade.selector] = upgradeAddress;
        _methods[IUpgradesRegistry(address(0x00)).upgradeProxy.selector] = upgradeAddress;
        _methods[IUpgradesRegistry(address(0x00)).getProxyCurrentUpgrades.selector] = upgradeAddress;
        _methods[IUpgradesRegistry(address(0x00)).getProxyMaxPossibleUpgradeIndex.selector] = upgradeAddress;

        _methods[IUpgradable(address(0x00)).upgrade.selector] = upgradeAddress;
        _methods[IUpgradable(address(0x00)).getCurrentUpgrades.selector] = upgradeAddress;
        _methods[IUpgradable(address(0x00)).getMaxPossibleUpgradeIndex.selector] = upgradeAddress;

        _methods[IUpgrade(address(0x00)).getProxyId.selector] = upgradeAddress;
    }
}

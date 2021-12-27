// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./UpgradesRegistryInitCommon.sol";
import "../../../interfaces/IUpgradesRegistry.sol";
import "../../../interfaces/IUpgradesRegistryStaticMethods.sol";
import "../../../../common/proxy/initialization/IInitializable.sol";
import "../../../../common/proxy/initialization/Initializable.sol";

contract UpgradesRegistryInitInitializable is IInitializable, Initializable, UpgradesRegistryInitCommon {
    function initialize(bytes memory input) public override(IInitializable, Initializable) {
        address init = _methods[msg.sig];
        _storeMethods(init);
        _storeUpgrade(PROXY_ID, init);
        _storeProxy(PROXY_ID, address(this));

        super.initialize(input);
    }

    function _storeMethods(address upgradeAddress) internal {
        _methods[IUpgradesRegistry(address(0x00)).setGovernance.selector] = upgradeAddress;

        _methods[IUpgradesRegistry(address(0x00)).registerProxy.selector] = upgradeAddress;
        _methods[IUpgradesRegistry(address(0x00)).registerUpgrade.selector] = upgradeAddress;
        _methods[IUpgradesRegistry(address(0x00)).upgradeProxy.selector] = upgradeAddress;

        _methods[IUpgradesRegistry(address(0x00)).getProxyId.selector] = upgradeAddress;
        _methods[IUpgradesRegistry(address(0x00)).isProxyRegistered.selector] = upgradeAddress;
        _methods[IUpgradesRegistry(address(0x00)).getProxyCurrentUpgrades.selector] = upgradeAddress;
        _methods[IUpgradesRegistry(address(0x00)).getProxyMaxPossibleUpgradeIndex.selector] = upgradeAddress;

        _methods[bytes4(keccak256("getProxyId_(address)"))] = upgradeAddress;
        _methods[IUpgradesRegistryStaticMethods(address(0x00)).isProxyRegistered_.selector] = upgradeAddress;
        _methods[IUpgradesRegistryStaticMethods(address(0x00)).getProxyCurrentUpgrades_.selector] = upgradeAddress;
        _methods[
            IUpgradesRegistryStaticMethods(address(0x00)).getProxyMaxPossibleUpgradeIndex_.selector
        ] = upgradeAddress;

        _methods[IUpgradable(address(0x00)).upgrade.selector] = upgradeAddress;
        _methods[IUpgradable(address(0x00)).getCurrentUpgrades.selector] = upgradeAddress;
        _methods[IUpgradable(address(0x00)).getMaxPossibleUpgradeIndex.selector] = upgradeAddress;
        _methods[IUpgradableStaticMethods(address(0x00)).getCurrentUpgrades_.selector] = upgradeAddress;
        _methods[IUpgradableStaticMethods(address(0x00)).getMaxPossibleUpgradeIndex_.selector] = upgradeAddress;

        _methods[IUpgrade(address(0x00)).getProxyId.selector] = upgradeAddress;
        _methods[IUpgrade(address(0x00)).supportsInterface.selector] = upgradeAddress;
        _methods[IUpgradeStaticMethods(address(0x00)).getProxyId_.selector] = upgradeAddress;
        _methods[IUpgradeStaticMethods(address(0x00)).supportsInterface_.selector] = upgradeAddress;
    }
}

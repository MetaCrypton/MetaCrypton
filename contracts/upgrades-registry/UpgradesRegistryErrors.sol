// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

library UpgradesRegistryErrors {
    error EmptyProxyId();
    error EmptyProxyAddress();
    error ExistingProxy();
    error UnexistingProxy();
    error UnexistingInitUpgrade();
    error EmptyUpgradeAddress();
    error ExistingUpgrade();
    error UnexistingUpgrade();
    error UpgradeApplied();
    error NoUpgrades();
    error NoUpgradableInterfaceSupport();
    error NoUpgradeInterfaceSupport();
}

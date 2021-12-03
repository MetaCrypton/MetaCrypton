// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library UpgradesRegistryInitErrors {
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
    error NoUpgradeMethod();
    error NoGetCurrentUpgradesMethod();
    error NoGetMaxPossibleUpgradeIndexMethod();
    error NoApplyUpgradeMethod();
    error NoGetProxyIdMethod();
}

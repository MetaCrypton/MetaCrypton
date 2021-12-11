// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

import "./UpgradesRegistryInitProxies.sol";
import "./UpgradesRegistryInitUpgrades.sol";
import "./UpgradesRegistryInitInitializable.sol";
import "./UpgradesRegistryInitUpgradable.sol";
import "./UpgradesRegistryInitUpgrade.sol";

contract UpgradesRegistryInit is
    UpgradesRegistryInitProxies,
    UpgradesRegistryInitUpgrades,
    UpgradesRegistryInitInitializable,
    UpgradesRegistryInitUpgradable,
    UpgradesRegistryInitUpgrade
{ }

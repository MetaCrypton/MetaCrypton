// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
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

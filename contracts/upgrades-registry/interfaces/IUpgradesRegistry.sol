// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IUpgradesRegistryEvents.sol";
import "./IUpgradesRegistryProxies.sol";
import "./IUpgradesRegistryUpgrades.sol";

interface IUpgradesRegistry is
    IUpgradesRegistryEvents,
    IUpgradesRegistryProxies,
    IUpgradesRegistryUpgrades
{ }

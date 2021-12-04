// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IUpgradesRegistryEventsProxies.sol";
import "./IUpgradesRegistryEventsUpgrades.sol";
import "./IUpgradesRegistryProxies.sol";
import "./IUpgradesRegistryUpgrades.sol";

interface IUpgradesRegistry is
    IUpgradesRegistryEventsProxies,
    IUpgradesRegistryEventsUpgrades,
    IUpgradesRegistryProxies,
    IUpgradesRegistryUpgrades
{ }

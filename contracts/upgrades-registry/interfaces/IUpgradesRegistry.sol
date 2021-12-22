// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../../common/governance/interfaces/IGovernable.sol";
import "./IUpgradesRegistryEvents.sol";
import "./IUpgradesRegistryProxies.sol";
import "./IUpgradesRegistryUpgrades.sol";

interface IUpgradesRegistry is
    IGovernable,
    IUpgradesRegistryEvents,
    IUpgradesRegistryProxies,
    IUpgradesRegistryUpgrades
{ }

// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./NFTInitGovernable.sol";
import "./NFTInitInventory.sol";
import "./NFTInitInitializable.sol";
import "./NFTInitUpgradable.sol";
import "./NFTInitUpgrade.sol";

contract NFTInit is
    NFTInitGovernable,
    NFTInitInventory,
    NFTInitInitializable,
    NFTInitUpgradable,
    NFTInitUpgrade
{ }

// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

import "./InventoryInitERC20.sol";
import "./InventoryInitERC721.sol";
import "./InventoryInitERC721Receiver.sol";
import "./InventoryInitInitializable.sol";
import "./InventoryInitUpgradable.sol";
import "./InventoryInitUpgrade.sol";

contract InventoryInit is
    InventoryInitERC20,
    InventoryInitERC721,
    InventoryInitERC721Receiver,
    InventoryInitInitializable,
    InventoryInitUpgradable,
    InventoryInitUpgrade
{ }

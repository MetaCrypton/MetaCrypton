// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./InventoryInitEther.sol";
import "./InventoryInitERC20.sol";
import "./InventoryInitERC721.sol";
import "./InventoryInitInitializable.sol";
import "./InventoryInitUpgradable.sol";
import "./InventoryInitUpgrade.sol";

contract InventoryInit is
    InventoryInitEther,
    InventoryInitERC20,
    InventoryInitERC721,
    InventoryInitInitializable,
    InventoryInitUpgradable,
    InventoryInitUpgrade
{ }

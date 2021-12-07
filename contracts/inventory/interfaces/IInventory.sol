// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IInventoryAssetsEvents.sol";
import "./IInventoryEther.sol";
import "./IInventoryERC20.sol";
import "./IInventoryERC721.sol";
import "../../common/interfaces/IERC721Receiver.sol";

interface IInventory is
    IInventoryAssetsEvents,
    IInventoryEther,
    IInventoryERC20,
    IInventoryERC721,
    IERC721Receiver
{ }

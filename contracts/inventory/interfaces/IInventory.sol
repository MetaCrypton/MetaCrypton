// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./IInventoryEvents.sol";
import "./IInventoryEther.sol";
import "./IInventoryERC20.sol";
import "./IInventoryERC721.sol";
import "../../common/interfaces/IERC721Receiver.sol";

interface IInventory is IInventoryEvents, IInventoryEther, IInventoryERC20, IInventoryERC721, IERC721Receiver {}

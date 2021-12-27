// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../InventoryStructs.sol";

interface IInventoryEvents {
    event DepositEther(address indexed sender, uint256 amount);
    event WithdrawEther(address indexed recipient, uint256 amount);

    event DepositERC721(address indexed sender, address indexed token, uint256 indexed tokenId);
    event WithdrawERC721(address indexed recipient, address indexed token, uint256 indexed tokenId);

    event DepositERC20(address indexed sender, address indexed token, uint256 amount);

    event WithdrawERC20(address indexed recipient, address indexed token, uint256 amount);

    event AssetAdded(uint256 indexed id, AssetType indexed assetType, bytes data);

    event AssetUpdated(uint256 indexed id, bytes data);

    event AssetRemoved(uint256 indexed id);
}

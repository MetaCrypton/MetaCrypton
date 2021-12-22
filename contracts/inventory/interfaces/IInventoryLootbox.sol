// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

interface IInventoryLootbox {
    function reveal() external returns (address token, uint256[] memory tokenIds);
}

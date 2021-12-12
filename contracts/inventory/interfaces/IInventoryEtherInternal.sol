// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

interface IInventoryEtherInternal {
    function processDepositEther(address sender, uint256 amount, bytes calldata data) external returns (bytes memory);

    function processWithdrawEther(address recipient, uint256 amount, bytes calldata data) external returns (bytes memory);
}

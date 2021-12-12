// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

interface IInventoryERC721Internal {
    function processDepositERC721(address sender, address token, uint256 tokenId, bytes calldata data) external returns (bytes memory);

    function processWithdrawERC721(address recipient, address token, uint256 tokenId, bytes calldata data) external returns (bytes memory);
}

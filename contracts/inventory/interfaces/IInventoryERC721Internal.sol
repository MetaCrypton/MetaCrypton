// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IInventoryERC721Internal {
    function processDepositERC721(address token, uint256 amount, bytes calldata data) external returns (bytes memory);

    function processWithdrawERC721(address recipient, address token, uint256 amount, bytes calldata data) external returns (bytes memory);
}

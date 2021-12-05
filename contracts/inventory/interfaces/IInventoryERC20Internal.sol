// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IInventoryERC20Internal {
    function processDepositERC20(address token, uint256 amount, bytes calldata data) external returns (bytes memory);

    function processWithdrawERC20(address recipient, address token, uint256 amount, bytes calldata data) external returns (bytes memory);
}

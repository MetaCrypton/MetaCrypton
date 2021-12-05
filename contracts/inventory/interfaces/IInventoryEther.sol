// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IInventoryEther {
    event DepositEther (
        uint256 amount
    );

    event WithdrawEther (
        uint256 amount
    );

    function depositEther() external;

    function withdrawEther(uint256 amount) external;
}

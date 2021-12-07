// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IInventoryEther {
    event DepositEther(address indexed sender, uint256 amount);

    event WithdrawEther(address indexed recipient, uint256 amount);

    function depositEther(bytes calldata data) external payable returns (bytes memory);

    function withdrawEther(address recipient, uint256 amount, bytes calldata data) external returns (bytes memory);

    function getEtherBalance() external view returns (uint256);
}

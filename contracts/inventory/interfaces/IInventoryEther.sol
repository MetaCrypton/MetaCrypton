// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

interface IInventoryEther {
    function depositEther(bytes calldata data) external payable returns (bytes memory);

    function withdrawEther(address recipient, uint256 amount, bytes calldata data) external returns (bytes memory);

    function getEtherBalance() external view returns (uint256);
}

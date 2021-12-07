// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../InventoryStructs.sol";

interface IInventoryERC20 {
    event DepositERC20(
        address indexed sender,
        address indexed token,
        uint256 amount
    );

    event WithdrawERC20(
        address indexed recipient,
        address indexed token,
        uint256 amount
    );

    function depositERC20(address from, address token, uint256 amount, bytes calldata data) external returns (bytes memory);

    function withdrawERC20(address recipient, address token, uint256 amount, bytes calldata data) external returns (bytes memory);
    
    function getERC20s(uint256 startIndex, uint256 number) external view returns (ERC20Struct[] memory);
    
    function getERC20Balance(address token) external view returns (uint256);
}

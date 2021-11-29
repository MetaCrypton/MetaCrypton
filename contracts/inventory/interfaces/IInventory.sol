// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IInventory {
    event DepositERC721 (
        address indexed token,
        uint256 indexed tokenId
    );

    event DepositERC20 (
        address indexed token,
        uint256 amount
    );

    event WithdrawERC721 (
        address indexed token,
        uint256 indexed tokenId
    );

    event WithdrawERC20 (
        address indexed token,
        uint256 amount
    );

    function depositERC721(address token, uint256 tokenId) external;

    function depositERC20(address token, uint256 amount) external;

    function withdrawERC721(address token, uint256 tokenId) external;

    function withdrawERC20(address token, uint256 amount) external;
}

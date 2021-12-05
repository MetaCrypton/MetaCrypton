// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../InventoryStructs.sol";

interface IInventoryERC721 {
    event DepositERC721 (
        address indexed sender,
        address indexed token,
        uint256 indexed tokenId
    );
    event WithdrawERC721 (
        address indexed recipient,
        address indexed token,
        uint256 indexed tokenId
    );

    function depositERC721(address token, uint256 tokenId, bytes calldata data) external;

    function withdrawERC721(address recipient, address token, uint256 tokenId, bytes calldata data) external;
    
    function getERC721s() external view returns (ERC721Struct[] memory);
    
    function getERC721Collection(address token) external view returns (uint256[] memory);
}

// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

import "../InventoryStructs.sol";

interface IInventoryERC721 {
    function depositERC721(address from, address token, uint256 tokenId, bytes calldata data) external returns (bytes memory);

    function withdrawERC721(address recipient, address token, uint256 tokenId, bytes calldata data) external returns (bytes memory);
    
    function getERC721s(uint256 startIndex, uint256 number) external view returns (ERC721Struct[] memory);
    
    function isERC721Owner(address token, uint256 tokenId) external view returns (bool);
}

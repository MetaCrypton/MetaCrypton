// SPDX-License-Identifier: MIT
// Modified copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
// Original copyright OpenZeppelin Contracts v4.4.0 (token/ERC721/extensions/ERC721Burnable.sol)

pragma solidity ^0.8.0;

/**
 * @title ERC721 Burnable Token
 * @dev ERC721 Token that can be irreversibly burned (destroyed).
 */
interface IERC721Burnable {
    /**
     * @dev Emitted when `tokenId` token is burned.
     */
    event Burn(uint256 indexed tokenId);

    /**
     * @dev Burns `tokenId`. See {ERC721-_burn}.
     *
     * Requirements:
     *
     * - The caller must own `tokenId` or be an approved operator.
     */
    function burn(uint256 tokenId) external;
}


   
// SPDX-License-Identifier: MIT
// Modified copyright Anton "BaldyAsh" Grigorev
// Original copyright OpenZeppelin Contracts v4.4.0 (token/ERC721/extensions/IERC721Metadata.sol)

pragma solidity ^0.8.0;

import "./NFTInitCommon.sol";
import "../NFTStorage.sol";
import "../../common/interfaces/IERC721Metadata.sol";
import "../../common/libs/StringUtils.sol";

/**
 * @title ERC-721 Non-Fungible Token Standard, optional metadata extension
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
contract NFTInitERC721Metadata is
    IERC721Metadata,
    NFTStorage
{
    using NFTInitCommon for *;
    using StringUtils for *;

    /**
     * @dev Returns the token collection name.
     */
    function name() external view override returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the token collection symbol.
     */
    function symbol() external view override returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the Uniform Resource Identifier (URI) for `tokenId` token.
     */
    function tokenURI(uint256 tokenId) external view override returns (string memory) {
        _tokensSet._verifyTokenId(tokenId);

        string memory baseURI = _baseURI;
        return bytes(baseURI).length > 0
            ? string(abi.encodePacked(baseURI, tokenId._toString()))
            : "";
    }
}
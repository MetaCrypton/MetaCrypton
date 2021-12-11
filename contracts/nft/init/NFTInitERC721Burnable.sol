
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./NFTInitCommon.sol";
import "../NFTStorage.sol";
import "../NFTErrors.sol";
import "../../common/interfaces/IERC721Burnable.sol";
import "../../common/interfaces/IERC721Events.sol";

/**
 * @title ERC721 Burnable Token
 * @dev ERC721 Token that can be irreversibly burned (destroyed).
 */
contract NFTInitERC721Burnable is
    IERC721Events,
    IERC721Burnable,
    NFTStorage
{
    using NFTInitCommon for *;
    
    /**
     * @dev Burns `tokenId`. See {ERC721-_burn}.
     *
     * Requirements:
     *
     * - The caller must own `tokenId` or be an approved operator.
     */
    function burn(uint256 tokenId) external override {
        if(!_tokensSet._safeIsApprovedOrOwner(msg.sender, tokenId)) revert NFTErrors.BurnNotFromOwnerNorApproved();

        address from = _tokensSet._burn(tokenId);

        emit Transfer(from, address(0x00), tokenId);
    }
}
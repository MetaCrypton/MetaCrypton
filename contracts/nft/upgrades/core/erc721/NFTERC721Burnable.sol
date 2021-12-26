
// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./NFTERC721Upgrade.sol";
import "../init/NFTInitCommon.sol";
import "../../../NFTErrors.sol";
import "../../../../common/interfaces/IERC721Burnable.sol";
import "../../../../common/interfaces/IERC721Events.sol";

/**
 * @title ERC721 Burnable Token
 * @dev ERC721 Token that can be irreversibly burned (destroyed).
 */
contract NFTERC721Burnable is
    IERC721Events,
    IERC721Burnable,
    NFTERC721Upgrade
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

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./NFTInitCommon.sol";
import "../NFTStorage.sol";
import "../NFTErrors.sol";
import "../../common/governance/Governable.sol";
import "../../common/interfaces/IERC721Mintable.sol";
import "../../common/interfaces/IERC721Events.sol";

/**
 * @title ERC721 Mintable Token
 * @dev ERC721 Token that can be irreversibly minted.
 */
contract NFTInitERC721Mintable is
    IERC721Events,
    IERC721Mintable,
    Governable,
    NFTStorage
{
    using NFTInitCommon for *;
    
    /**
     * @dev Mints `tokenId`. See {ERC721-_mint}.
     *
     * Requirements:
     *
     * - The caller must own `tokenId` or be an approved operator.
     */
    function mint(address owner) external override isGovernance {
        uint256 tokenId = _tokensSet._mint(
            _upgradesRegistry,
            _inventorySetup,
            owner
        );

        emit Transfer(address(0x00), owner, tokenId);
    }

    /**
     * @dev Mints `tokenId`. See {ERC721-_safeMint}.
     *
     * Requirements:
     *
     * - The caller must own `tokenId` or be an approved operator.
     */
    function safeMint(address owner) external override isGovernance {
        uint256 tokenId = _tokensSet._safeMint(
            _upgradesRegistry,
            _inventorySetup,
            owner
        );

        emit Transfer(address(0x00), owner, tokenId);
    }

    /**
     * @dev Mints `tokenId`. See {ERC721-_safeMint}.
     *
     * Requirements:
     *
     * - The caller must own `tokenId` or be an approved operator.
     */
    function safeMint(address owner, bytes calldata data) external override isGovernance {
        uint256 tokenId = _tokensSet._safeMint(
            _upgradesRegistry,
            _inventorySetup,
            owner,
            data
        );

        emit Transfer(address(0x00), owner, tokenId);
    }
}
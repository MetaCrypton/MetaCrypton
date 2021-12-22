// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./NFTInitCommon.sol";
import "../../NFTStorage.sol";
import "../../NFTErrors.sol";
import "../../../common/governance/Governable.sol";
import "../../../common/interfaces/IERC721Mintable.sol";
import "../../../common/interfaces/IERC721Events.sol";

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
    function mint(address owner) external override requestPermission {
        uint256 tokenId = _tokensSet._mint(
            _upgradesRegistry,
            _inventorySetup,
            owner,
            _inventoryUpgrades
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
    function safeMint(address owner) external override requestPermission {
        uint256 tokenId = _tokensSet._safeMint(
            _upgradesRegistry,
            _inventorySetup,
            owner,
            _inventoryUpgrades
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
    function safeMint(address owner, bytes calldata data) external override requestPermission {
        uint256 tokenId = _tokensSet._safeMint(
            _upgradesRegistry,
            _inventorySetup,
            owner,
            data,
            _inventoryUpgrades
        );

        emit Transfer(address(0x00), owner, tokenId);
    }
}
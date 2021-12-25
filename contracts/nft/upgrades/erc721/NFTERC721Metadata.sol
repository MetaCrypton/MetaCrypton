
   
// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.

pragma solidity ^0.8.0;

import "./NFTERC721Upgrade.sol";
import "../init/NFTInitCommon.sol";
import "../../../common/interfaces/IERC721Metadata.sol";
import "../../../common/libs/StringUtils.sol";

/**
 * @title ERC-721 Non-Fungible Token Standard, optional metadata extension
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
contract NFTERC721Metadata is
    IERC721Metadata,
    NFTERC721Upgrade
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
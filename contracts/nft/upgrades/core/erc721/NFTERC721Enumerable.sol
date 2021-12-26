// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./NFTERC721Upgrade.sol";
import "../init/NFTInitCommon.sol";
import "../../../NFTErrors.sol";
import "../../../../common/interfaces/IERC721Enumerable.sol";

/**
 * @title ERC-721 Non-Fungible Token Standard, optional enumeration extension
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
contract NFTERC721Enumerable is
    IERC721Enumerable,
    NFTERC721Upgrade
{
    /**
     * @dev Returns the total amount of tokens stored by the contract.
     */
    function totalSupply() external view override returns (uint256) {
        return _tokensSet.tokens.length;
    }

    /**
     * @dev Returns a token ID owned by `owner` at a given `index` of its token list.
     * Use along with {balanceOf} to enumerate all of ``owner``'s tokens.
     */
    function tokenOfOwnerByIndex(address owner, uint256 index) external view override returns (uint256 tokenId) {
        if (index >= _tokensSet.tokenIdsByOwner[owner].length) revert NFTErrors.IndexOutOfBounds();
        return _tokensSet.tokenIdsByOwner[owner][index];
    }

    /**
     * @dev Returns a token ID at a given `index` of all the tokens stored by the contract.
     * Use along with {totalSupply} to enumerate all tokens.
     */
    function tokenByIndex(uint256 index) external view override returns (uint256) {
        if (index >= _tokensSet.tokens.length) revert NFTErrors.IndexOutOfBounds();
        return _tokensSet.tokens[index].id;
    }
}
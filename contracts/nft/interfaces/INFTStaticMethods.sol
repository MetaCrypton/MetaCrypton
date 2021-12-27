// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../NFTStructs.sol";
import "../../common/upgradability/IUpgradableStaticMethods.sol";
import "../../common/upgradability/IUpgradeStaticMethods.sol";

interface INFTInventoryStaticMethods {
    function inventoryOf_(uint256 tokenId) external view returns (address owner);

    function tokenIdByInventory_(address inventory) external view returns (uint256);
}

interface INFTERC721StaticMethods {
    /**
     * @dev Returns the number of tokens in ``owner``'s account.
     */
    function balanceOf_(address owner) external view returns (uint256 balance);

    /**
     * @dev Returns the owner of the `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function ownerOf_(uint256 tokenId) external view returns (address owner);

    /**
     * @dev Returns the account approved for `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function getApproved_(uint256 tokenId) external view returns (address operator);

    /**
     * @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
     *
     * See {setApprovalForAll}
     */
    function isApprovedForAll_(address owner, address operator) external view returns (bool);
}

interface INFTERC721EnumerableStaticMethods {
    /**
     * @dev Returns the total amount of tokens stored by the contract.
     */
    function totalSupply_() external view returns (uint256);

    /**
     * @dev Returns a token ID owned by `owner` at a given `index` of its token list.
     * Use along with {balanceOf} to enumerate all of ``owner``'s tokens.
     */
    function tokenOfOwnerByIndex_(address owner, uint256 index) external view returns (uint256 tokenId);

    /**
     * @dev Returns a token ID at a given `index` of all the tokens stored by the contract.
     * Use along with {totalSupply} to enumerate all tokens.
     */
    function tokenByIndex_(uint256 index) external view returns (uint256);
}

interface INFTERC721MetadataStaticMethods {
    /**
     * @dev Returns the token collection name.
     */
    function name_() external view returns (string memory);

    /**
     * @dev Returns the token collection symbol.
     */
    function symbol_() external view returns (string memory);

    /**
     * @dev Returns the Uniform Resource Identifier (URI) for `tokenId` token.
     */
    function tokenURI_(uint256 tokenId) external view returns (string memory);
}

interface INFTStaticMethods is
    INFTInventoryStaticMethods,
    INFTERC721StaticMethods,
    INFTERC721EnumerableStaticMethods,
    INFTERC721MetadataStaticMethods,
    IUpgradableStaticMethods,
    IUpgradeStaticMethods
{}

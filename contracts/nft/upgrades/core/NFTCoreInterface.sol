// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../../interfaces/INFT.sol";
import "../../interfaces/INFTStaticMethods.sol";
import "../../../common/proxy/contract-interface/Interface.sol";
import "../../../common/upgradability/IUpgrade.sol";
import "../../../common/upgradability/IUpgradable.sol";

contract NFTCoreInterface is INFT, IUpgradable, IUpgrade, Interface {
    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
     * are aware of the ERC721 protocol to prevent tokens from being forever locked.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must be have been allowed to move this token by either
     * {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received},
     * which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external override {
        from;
        to;
        tokenId;
        _delegateCall();
    }

    /**
     * @dev Transfers `tokenId` token from `from` to `to`.
     *
     * WARNING: Usage of this method is discouraged, use {safeTransferFrom} whenever possible.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external override {
        from;
        to;
        tokenId;
        _delegateCall();
    }

    /**
     * @dev Gives permission to `to` to transfer `tokenId` token to another account.
     * The approval is cleared when the token is transferred.
     *
     * Only a single account can be approved at a time, so approving the zero address clears previous approvals.
     *
     * Requirements:
     *
     * - The caller must own the token or be an approved operator.
     * - `tokenId` must exist.
     *
     * Emits an {Approval} event.
     */
    function approve(address to, uint256 tokenId) external override {
        to;
        tokenId;
        _delegateCall();
    }

    /**
     * @dev Approve or remove `operator` as an operator for the caller.
     * Operators can call {transferFrom} or {safeTransferFrom} for any token owned by the caller.
     *
     * Requirements:
     *
     * - The `operator` cannot be the caller.
     *
     * Emits an {ApprovalForAll} event.
     */
    function setApprovalForAll(address operator, bool _approved) external override {
        operator;
        _approved;
        _delegateCall();
    }

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either
     * {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received},
     * which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external override {
        from;
        to;
        tokenId;
        data;
        _delegateCall();
    }

    /**
     * @dev Burns `tokenId`. See {ERC721-_burn}.
     *
     * Requirements:
     *
     * - The caller must own `tokenId` or be an approved operator.
     */
    function burn(uint256 tokenId) external override {
        tokenId;
        _delegateCall();
    }

    /**
     * @dev Mints `tokenId`. See {ERC721-_mint}.
     *
     * Requirements:
     *
     * - The caller must own `tokenId` or be an approved operator.
     */
    function mint(address owner) external override returns (uint256 tokenId) {
        owner;
        tokenId;
        _delegateCall();
    }

    /**
     * @dev Mints `tokenId`. See {ERC721-_safeMint}.
     *
     * Requirements:
     *
     * - The caller must own `tokenId` or be an approved operator.
     */
    function safeMint(address owner) external override returns (uint256 tokenId) {
        owner;
        tokenId;
        _delegateCall();
    }

    /**
     * @dev Mints `tokenId`. See {ERC721-_safeMint}.
     *
     * Requirements:
     *
     * - The caller must own `tokenId` or be an approved operator.
     */
    function safeMint(address owner, bytes calldata data) external override returns (uint256 tokenId) {
        owner;
        data;
        tokenId;
        _delegateCall();
    }

    function setGovernance(address governance) external override {
        governance;
        _delegateCall();
    }

    function upgrade(uint256 upgradeIndex) external override {
        upgradeIndex;
        _delegateCall();
    }

    function applyUpgrade() external override {
        _delegateCall();
    }

    /**
     * @dev Returns the number of tokens in ``owner``'s account.
     */
    function balanceOf(address owner) external view override returns (uint256 balance) {
        balance;
        bytes memory data = abi.encodeWithSelector(INFTStaticMethods(address(0x00)).balanceOf_.selector, owner);
        _staticCall(data);
    }

    /**
     * @dev Returns the owner of the `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function ownerOf(uint256 tokenId) external view override returns (address owner) {
        owner;
        bytes memory data = abi.encodeWithSelector(INFTStaticMethods(address(0x00)).ownerOf_.selector, tokenId);
        _staticCall(data);
    }

    /**
     * @dev Returns the account approved for `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function getApproved(uint256 tokenId) external view override returns (address operator) {
        operator;
        bytes memory data = abi.encodeWithSelector(INFTStaticMethods(address(0x00)).getApproved_.selector, tokenId);
        _staticCall(data);
    }

    /**
     * @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
     *
     * See {setApprovalForAll}
     */
    function isApprovedForAll(address owner, address operator) external view override returns (bool result) {
        result;
        bytes memory data = abi.encodeWithSelector(
            INFTStaticMethods(address(0x00)).isApprovedForAll_.selector,
            owner,
            operator
        );
        _staticCall(data);
    }

    /**
     * @dev Returns the total amount of tokens stored by the contract.
     */
    function totalSupply() external view override returns (uint256 result) {
        result;
        bytes memory data = abi.encodeWithSelector(INFTStaticMethods(address(0x00)).totalSupply_.selector);
        _staticCall(data);
    }

    /**
     * @dev Returns a token ID owned by `owner` at a given `index` of its token list.
     * Use along with {balanceOf} to enumerate all of ``owner``'s tokens.
     */
    function tokenOfOwnerByIndex(address owner, uint256 index) external view override returns (uint256 tokenId) {
        tokenId;
        bytes memory data = abi.encodeWithSelector(
            INFTStaticMethods(address(0x00)).tokenOfOwnerByIndex_.selector,
            owner,
            index
        );
        _staticCall(data);
    }

    /**
     * @dev Returns a token ID at a given `index` of all the tokens stored by the contract.
     * Use along with {totalSupply} to enumerate all tokens.
     */
    function tokenByIndex(uint256 index) external view override returns (uint256 result) {
        result;
        bytes memory data = abi.encodeWithSelector(INFTStaticMethods(address(0x00)).tokenByIndex_.selector, index);
        _staticCall(data);
    }

    /**
     * @dev Returns the token collection name.
     */
    function name() external view override returns (string memory result) {
        result;
        bytes memory data = abi.encodeWithSelector(INFTStaticMethods(address(0x00)).name_.selector);
        _staticCall(data);
    }

    /**
     * @dev Returns the token collection symbol.
     */
    function symbol() external view override returns (string memory result) {
        result;
        bytes memory data = abi.encodeWithSelector(INFTStaticMethods(address(0x00)).symbol_.selector);
        _staticCall(data);
    }

    /**
     * @dev Returns the Uniform Resource Identifier (URI) for `tokenId` token.
     */
    function tokenURI(uint256 tokenId) external view override returns (string memory result) {
        result;
        bytes memory data = abi.encodeWithSelector(INFTStaticMethods(address(0x00)).tokenURI_.selector, tokenId);
        _staticCall(data);
    }

    function inventoryOf(uint256 tokenId) external view override returns (address owner) {
        owner;
        bytes memory data = abi.encodeWithSelector(INFTStaticMethods(address(0x00)).inventoryOf_.selector, tokenId);
        _staticCall(data);
    }

    function tokenIdByInventory(address inventory) external view override returns (uint256 result) {
        result;
        bytes memory data = abi.encodeWithSelector(
            INFTStaticMethods(address(0x00)).tokenIdByInventory_.selector,
            inventory
        );
        _staticCall(data);
    }

    function getCurrentUpgrades() external view override returns (uint256[] memory upgradesIndexes) {
        upgradesIndexes;
        bytes memory data = abi.encodeWithSelector(
            IUpgradableStaticMethods(address(0x00)).getCurrentUpgrades_.selector
        );
        _staticCall(data);
    }

    function getMaxPossibleUpgradeIndex() external view override returns (uint256 index) {
        index;
        bytes memory data = abi.encodeWithSelector(
            IUpgradableStaticMethods(address(0x00)).getMaxPossibleUpgradeIndex_.selector
        );
        _staticCall(data);
    }

    function getProxyId() external view override returns (bytes32 result) {
        result;
        bytes memory data = abi.encodeWithSelector(IUpgradeStaticMethods(address(0x00)).getProxyId_.selector);
        _staticCall(data);
    }

    function supportsInterface(bytes4 interfaceId) external view override returns (bool result) {
        result;
        bytes memory data = abi.encodeWithSelector(
            IUpgradeStaticMethods(address(0x00)).supportsInterface_.selector,
            interfaceId
        );
        _staticCall(data);
    }
}

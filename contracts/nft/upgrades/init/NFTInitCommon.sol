// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../../NFTStorage.sol";
import "../../NFTErrors.sol";
import "../../../inventory/InventoryProxy.sol";
import "../../../upgrades-registry/interfaces/IUpgradesRegistry.sol";
import "../../../common/interfaces/IERC721Receiver.sol";
import "../../../common/libs/AddressUtils.sol";
import "../../../common/upgradability/IUpgradable.sol";

library NFTInitCommon {
    function _safeMint(
        TokensSet storage tokensSet,
        address upgradesRegistry,
        address inventorySetup,
        address to,
        uint256[] memory inventoryUpgrades
    ) internal returns (uint256 tokenId) {
        return _safeMint(
            tokensSet,
            upgradesRegistry,
            inventorySetup,
            to,
            "",
            inventoryUpgrades
        );
    }

    function _safeMint(
        TokensSet storage tokensSet,
        address upgradesRegistry,
        address inventorySetup,
        address to,
        bytes memory data,
        uint256[] memory inventoryUpgrades
    ) internal returns (uint256 tokenId) {
        tokenId = _mint(
            tokensSet,
            upgradesRegistry,
            inventorySetup,
            to,
            inventoryUpgrades
        );
        if (!_checkOnERC721Received(address(0x00), to, tokenId, data)) revert NFTErrors.TransferToNonERC721ReceiverImplementer();
        
        return tokenId;
    }

    function _mint(
        TokensSet storage tokensSet,
        address upgradesRegistry,
        address inventorySetup,
        address to,
        uint256[] memory inventoryUpgrades
    ) internal returns (uint256 tokenId) {
        address inventory;
        (inventory, tokenId)  = _deployInventory(
            upgradesRegistry,
            inventorySetup,
            inventoryUpgrades
        );
        uint256 index = _idToTokenIndex(tokensSet, tokenId);
        if (index > 0) revert NFTErrors.ExistingToken();

        _addToken(tokensSet, to, tokenId, inventory);
        _addToOwner(tokensSet, to, tokenId);

        return tokenId;
    }

    function _safeTransfer(
        TokensSet storage tokensSet,
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) internal {
        _transfer(tokensSet, from, to, tokenId);
        if (!_checkOnERC721Received(from, to, tokenId, data)) revert NFTErrors.TransferToNonERC721ReceiverImplementer();
    }

    function _transfer(
        TokensSet storage tokensSet,
        address from,
        address to,
        uint256 tokenId
    ) internal {
        Token storage token = _safeGetToken(tokensSet, tokenId);
        address owner = token.owner;
        if (from != owner) revert NFTErrors.TransferNotFromOwner();
        if (to == owner) revert NFTErrors.TransferToOwner();
        if (to == address(0x00)) revert NFTErrors.RecipientIsZero();

        _approve(tokensSet, address(0x00), tokenId);

        _removeFromOwner(tokensSet, from, tokenId);
        _addToOwner(tokensSet, to, tokenId);
    }

    function _burn(
        TokensSet storage tokensSet,
        uint256 tokenId
    ) internal returns (address) {
        Token storage token = _safeGetToken(tokensSet, tokenId);
        address owner = token.owner;

        _approve(tokensSet, address(0x00), tokenId);

        _removeToken(tokensSet, tokenId);
        _removeFromOwner(tokensSet, owner, tokenId);

        return owner;
    }

    function _addToken(
        TokensSet storage tokensSet,
        address to,
        uint256 tokenId,
        address inventory
    ) internal {
        tokensSet.tokens.push(Token(tokenId, to, inventory));
        tokensSet.tokenIndexById[tokenId] = tokensSet.tokens.length;
    }

    function _removeToken(
        TokensSet storage tokensSet,
        uint256 tokenId
    ) internal {
        uint256 toDeleteIndex = _idToTokenIndex(tokensSet, tokenId) - 1;
        uint256 lastIndex = tokensSet.tokens.length - 1;

        Token storage toDelete = tokensSet.tokens[toDeleteIndex];
        Token storage last = tokensSet.tokens[lastIndex];

        toDelete = last;
        tokensSet.tokens.pop();

        tokensSet.tokenIndexById[toDelete.id] = toDeleteIndex;
        delete tokensSet.tokenIndexById[tokenId];
    }

    function _addToOwner(
        TokensSet storage tokensSet,
        address to,
        uint256 tokenId
    ) internal {
        tokensSet.tokenIdsByOwner[to].push(tokenId);
    }

    function _removeFromOwner(
        TokensSet storage tokensSet,
        address from,
        uint256 tokenId
    ) internal {
        uint256 fromLength = tokensSet.tokenIdsByOwner[from].length;
        for (uint256 i = 0; i < fromLength; i++) {
            if (tokensSet.tokenIdsByOwner[from][i] == tokenId) {
                tokensSet.tokenIdsByOwner[from][i] = tokensSet.tokenIdsByOwner[from][fromLength - 1];
                break;
            }
        }
        tokensSet.tokenIdsByOwner[from].pop();
    }

    function _approve(
        TokensSet storage tokensSet,
        address to,
        uint256 tokenId
    ) internal {
        tokensSet.tokenApprovalsById[tokenId] = to;
    }

    function _setApprovalForAll(
        TokensSet storage tokensSet,
        address owner,
        address operator,
        bool approved
    ) internal {
        if (owner == operator) revert NFTErrors.ApproveToCaller();
        tokensSet.operatorApprovals[owner][operator] = approved;
    }

    function _deployInventory(
        address upgradesRegistry,
        address inventorySetup,
        uint256[] memory inventoryUpgrades
    ) internal returns (address inventory, uint256 tokenId) {
        inventory = address(new InventoryProxy(inventorySetup));
        tokenId = _addressToTokenId(inventory);

        IInitializable(inventory).initialize(
            abi.encode(address(this), tokenId, upgradesRegistry)
        );

        IUpgradesRegistry(upgradesRegistry).registerProxy(inventory);

        uint upgradesLen = inventoryUpgrades.length;
        for (uint i = 0; i < upgradesLen; i++) {
            IUpgradable(inventory).upgrade(inventoryUpgrades[i]);
        }

        return (inventory, tokenId);
    }

    function _checkOnERC721Received(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) internal returns (bool) {
        if (AddressUtils.isContract(to)) {
            try IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, data) returns (bytes4 retval) {
                return retval == IERC721Receiver.onERC721Received.selector;
            } catch (bytes memory reason) {
                if (reason.length == 0) revert NFTErrors.TransferToNonERC721ReceiverImplementer();
                assembly {
                    revert(add(32, reason), mload(reason))
                }
            }
        } else {
            return true;
        }
    }

    function _safeGetToken(TokensSet storage tokensSet, uint256 tokenId) internal view returns (Token storage) {
        uint256 index = _safeGetTokenIndex(tokensSet, tokenId);
        return tokensSet.tokens[index];
    }

    function _safeGetTokenIndex(TokensSet storage tokensSet, uint256 tokenId) internal view returns (uint256) {
        uint256 index = _idToTokenIndex(tokensSet, tokenId);
        _verifyTokenIndex(index);
        return index;
    }

    function _verifyTokenId(TokensSet storage tokensSet, uint256 tokenId) internal view {
        uint256 index = _idToTokenIndex(tokensSet, tokenId);
        _verifyTokenIndex(index);
    }

    function _idToTokenIndex(TokensSet storage tokensSet, uint256 tokenId) internal view returns (uint256) {
        return tokensSet.tokenIndexById[tokenId];
    }

    function _safeOwnerOf(TokensSet storage tokensSet, uint256 tokenId) internal view returns (address owner) {
        Token storage token = _safeGetToken(tokensSet, tokenId);
        return token.owner;
    }

    function _safeGetApproved(TokensSet storage tokensSet, uint256 tokenId) internal view returns (address operator) {
        _verifyTokenId(tokensSet, tokenId);
        return tokensSet.tokenApprovalsById[tokenId];
    }

    function _isApprovedForAll(
        TokensSet storage tokensSet,
        address owner,
        address operator
    ) internal view returns (bool) {
        return tokensSet.operatorApprovals[owner][operator];
    }

    function _safeIsApprovedOrOwner(
        TokensSet storage tokensSet,
        address spender,
        uint256 tokenId
    ) internal view returns (bool) {
        address owner = _safeOwnerOf(tokensSet, tokenId);
        return (
            spender == owner
            || tokensSet.tokenApprovalsById[tokenId] == spender
            || _isApprovedForAll(tokensSet, owner, spender)
        );
    }

    function _addressToTokenId(address inventory) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(inventory)));
    }

    function _verifyTokenIndex(uint256 index) internal pure {
        if (index == 0) revert NFTErrors.UnexistingToken();
    }
}
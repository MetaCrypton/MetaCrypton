// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../../interfaces/IInventory.sol";
import "../../interfaces/IInventoryStaticMethods.sol";
import "../../../common/proxy/contract-interface/Interface.sol";
import "../../../common/upgradability/IUpgrade.sol";
import "../../../common/upgradability/IUpgradable.sol";

contract InventoryCoreInterface is IInventory, IUpgradable, IUpgrade, Interface {
    function depositEther(bytes calldata data) external payable override returns (bytes memory result) {
        data;
        result;
        _delegateCall();
    }

    function withdrawEther(address recipient, uint256 amount, bytes calldata data) external override returns (bytes memory result) {
        recipient;
        amount;
        data;
        result;
        _delegateCall();
    }

    function depositERC20(address from, address token, uint256 amount, bytes calldata data) external override returns (bytes memory result) {
        from;
        token;
        amount;
        data;
        result;
        _delegateCall();
    }

    function withdrawERC20(address recipient, address token, uint256 amount, bytes calldata data) external override returns (bytes memory result) {
        recipient;
        token;
        amount;
        data;
        result;
        _delegateCall();
    }

    function depositERC721(address from, address token, uint256 tokenId, bytes calldata data) external override returns (bytes memory result) {
        from;
        token;
        tokenId;
        data;
        result;
        _delegateCall();
    }

    function withdrawERC721(address recipient, address token, uint256 tokenId, bytes calldata data) external override returns (bytes memory result) {
        recipient;
        token;
        tokenId;
        data;
        result;
        _delegateCall();
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external override returns (bytes4 result) {
        operator;
        from;
        tokenId;
        data;
        result;
        _delegateCall();
    }

    function upgrade(uint256 upgradeIndex) external override {
        upgradeIndex;
        _delegateCall();
    }

    function applyUpgrade() external override {
        _delegateCall();
    }
    
    function getERC20s(uint256 startIndex, uint256 number) external view override returns (ERC20Struct[] memory result) {
        result;
        bytes memory data = abi.encodeWithSelector(
            IInventoryStaticMethods(address(0x00)).getERC20s_.selector,
            startIndex,
            number
        );
        _staticCall(data);
    }
    
    function getERC20Balance(address token) external view override returns (uint256 result) {
        result;
        bytes memory data = abi.encodeWithSelector(
            IInventoryStaticMethods(address(0x00)).getERC20Balance_.selector,
            token
        );
        _staticCall(data);
    }
    
    function getERC721s(uint256 startIndex, uint256 number) external view override returns (ERC721Struct[] memory result) {
        result;
        bytes memory data = abi.encodeWithSelector(
            IInventoryStaticMethods(address(0x00)).getERC721s_.selector,
            startIndex,
            number
        );
        _staticCall(data);
    }
    
    function isERC721Owner(address token, uint256 tokenId) external view override returns (bool result) {
        result;
        bytes memory data = abi.encodeWithSelector(
            IInventoryStaticMethods(address(0x00)).isERC721Owner_.selector,
            token,
            tokenId
        );
        _staticCall(data);
    }

    function getEtherBalance() external view override returns (uint256 result) {
        result;
        bytes memory data = abi.encodeWithSelector(IInventoryStaticMethods(address(0x00)).getEtherBalance_.selector);
        _staticCall(data);
    }

    function getCurrentUpgrades() external view override returns (uint256[] memory upgradesIndexes) {
        upgradesIndexes;
        bytes memory data = abi.encodeWithSelector(IUpgradableStaticMethods(address(0x00)).getCurrentUpgrades_.selector);
        _staticCall(data);
    }

    function getMaxPossibleUpgradeIndex() external view override returns (uint256 index) {
        index;
        bytes memory data = abi.encodeWithSelector(IUpgradableStaticMethods(address(0x00)).getMaxPossibleUpgradeIndex_.selector);
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

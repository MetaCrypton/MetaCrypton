// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../../interfaces/INFTFactory.sol";
import "../../interfaces/INFTFactoryStaticMethods.sol";
import "../../../common/proxy/contract-interface/Interface.sol";
import "../../../common/upgradability/IUpgrade.sol";
import "../../../common/upgradability/IUpgradable.sol";

contract NFTFactoryCoreInterface is INFTFactory, IUpgradable, IUpgrade, Interface {
    function deployToken(
        TokenMetadata calldata tokenMetadata,
        address interfaceAddress,
        address governance,
        address inventoryInterface,
        uint256[] calldata inventoryUpgrades,
        uint256[] calldata nftUpgrades
    ) external override returns (address result) {
        tokenMetadata;
        interfaceAddress;
        governance;
        inventoryInterface;
        inventoryUpgrades;
        nftUpgrades;
        result;
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

    function getTokens(uint256 startIndex, uint256 number) external view override returns (NFTToken[] memory result) {
        result;
        bytes memory data = abi.encodeWithSelector(
            INFTFactoryStaticMethods(address(0x00)).getTokens_.selector,
            startIndex,
            number
        );
        _staticCall(data);
    }
    
    function getTokensTotal() external view override returns (uint256 result) {
        result;
        bytes memory data = abi.encodeWithSelector(
            INFTFactoryStaticMethods(address(0x00)).getTokensTotal_.selector
        );
        _staticCall(data);
    }

    function getTokensByGovernanceTotal(address governance) external view override returns (uint256 result) {
        result;
        bytes memory data = abi.encodeWithSelector(
            INFTFactoryStaticMethods(address(0x00)).getTokensByGovernanceTotal_.selector,
            governance
        );
        _staticCall(data);
    }

    function getTokenByAddress(address token) external view override returns (NFTToken memory result) {
        result;
        bytes memory data = abi.encodeWithSelector(
            INFTFactoryStaticMethods(address(0x00)).getTokenByAddress_.selector,
            token
        );
        _staticCall(data);
    }

    function getTokenBySymbol(string calldata symbol) external view override returns (NFTToken memory result) {
        result;
        bytes memory data = abi.encodeWithSelector(
            INFTFactoryStaticMethods(address(0x00)).getTokenBySymbol_.selector,
            symbol
        );
        _staticCall(data);
    }

    function getTokensByGovernance(address governance, uint256 startIndex, uint256 number) external view override returns (NFTToken[] memory result) {
        result;
        bytes memory data = abi.encodeWithSelector(
            INFTFactoryStaticMethods(address(0x00)).getTokensByGovernance_.selector,
            governance,
            startIndex,
            number
        );
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

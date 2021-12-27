// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../../NFTStorage.sol";
import "../../interfaces/INFTLootbox.sol";
import "../../interfaces/INFTLootboxStaticMethods.sol";
import "../../../common/upgradability/IUpgrade.sol";
import "../../../common/upgradability/UpgradeErrors.sol";

contract NFTLootboxUpgrade is IUpgrade, NFTStorage {
    constructor() {
        _methods[IUpgrade(address(0x00)).applyUpgrade.selector] = address(this);
        _methods[IUpgrade(address(0x00)).getProxyId.selector] = address(this);
        _methods[IUpgrade(address(0x00)).supportsInterface.selector] = address(this);
    }

    function applyUpgrade() external override {
        if (msg.sender != address(this)) revert UpgradeErrors.ApplyUpgradeOnlyCallableByItself();

        address upgradeAddress = _methods[msg.sig];
        _methods[INFTLootbox(address(0x00)).setLootNFT.selector] = upgradeAddress;
        _methods[INFTLootbox(address(0x00)).getLootNFT.selector] = upgradeAddress;
        _methods[INFTLootboxStaticMethods(address(0x00)).getLootNFT_.selector] = upgradeAddress;
    }

    function supportsInterface(bytes4 interfaceId) external view override returns (bool) {
        return _methods[interfaceId] != address(0x00) || interfaceId == type(IUpgrade).interfaceId;
    }

    function getProxyId() external pure override returns (bytes32) {
        return PROXY_ID;
    }
}

// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./NFTLootboxUpgrade.sol";
import "../../NFTErrors.sol";
import "../../interfaces/INFTLootbox.sol";
import "../../interfaces/INFTLootboxStaticMethods.sol";
import "../../../common/governance/Governable.sol";
import "../../../common/libs/EternalStorage.sol";

contract NFTLootbox is INFTLootbox, INFTLootboxStaticMethods, Governable, NFTLootboxUpgrade {
    using EternalStorageLib for *;

    bytes32 internal constant LOOT_NFT = keccak256(abi.encodePacked("Loot NFT"));

    function setLootNFT(address lootNFT) external override requestPermission {
        if (lootNFT == address(0x00)) revert NFTErrors.EmptyLootNFT();

        address oldLootNFT = _eternalStorage._getAddress(LOOT_NFT);
        if (lootNFT == oldLootNFT) revert NFTErrors.SameLootNFT();

        _eternalStorage._setAddress(LOOT_NFT, lootNFT);
    }

    function getLootNFT_() external view override returns (address) {
        return getLootNFT();
    }

    function getLootNFT() public view override returns (address) {
        return _eternalStorage._getAddress(LOOT_NFT);
    }
}

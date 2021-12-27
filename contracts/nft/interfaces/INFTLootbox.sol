// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

interface INFTLootbox {
    function setLootNFT(address lootNFT) external;

    function getLootNFT() external view returns (address);
}

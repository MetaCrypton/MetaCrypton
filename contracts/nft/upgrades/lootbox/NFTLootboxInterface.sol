// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../core/NFTCoreInterface.sol";
import "../../interfaces/INFTLootbox.sol";
import "../../interfaces/INFTLootboxStaticMethods.sol";

contract NFTLootboxInterface is INFTLootbox, NFTCoreInterface {
    function setLootNFT(address lootNFT) external override {
        lootNFT;
        _delegateCall();
    }

    function getLootNFT() external view override returns (address result) {
        result;
        bytes memory data = abi.encodeWithSelector(
            INFTLootboxStaticMethods(address(0x00)).getLootNFT_.selector
        );
        _staticCall(data);
    }
}

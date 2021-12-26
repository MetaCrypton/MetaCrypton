// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../core/InventoryCoreInterface.sol";
import "../../interfaces/IInventoryLootbox.sol";

contract InventoryLootboxInterface is IInventoryLootbox, InventoryCoreInterface {
    function reveal() external override returns (address token, uint256[] memory tokenIds) {
        token;
        tokenIds;
        _delegateCall();
    }
}

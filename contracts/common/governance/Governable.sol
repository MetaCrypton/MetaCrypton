// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./GovernableErrors.sol";
import "./GovernableStorage.sol";
import "./interfaces/IGovernance.sol";
import "../libs/AddressUtils.sol";

contract Governable is GovernableStorage {
    using AddressUtils for *;

    modifier requestPermission() {
        if (msg.sender != _governance) {
            if (_governance.isContract()) {
                IGovernance(_governance).requestPermission(msg.sender, address(this));
            } else {
                revert GovernableErrors.NoPermission();
            }
        }
            
        _;
    }
}

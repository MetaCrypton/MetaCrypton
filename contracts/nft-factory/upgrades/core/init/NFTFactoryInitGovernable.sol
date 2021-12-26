// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../../../NFTFactoryStorage.sol";
import "../../../../common/governance/interfaces/IGovernable.sol";
import "../../../../common/governance/Governable.sol";
import "../../../../common/governance/GovernableErrors.sol";


contract NFTFactoryInitGovernable is
    IGovernable,
    Governable,
    NFTFactoryStorage
{
    function setGovernance(address governance) external override requestPermission {
        if (governance == address(0x00)) revert GovernableErrors.EmptyGovernance();
        if (governance == _governance) revert GovernableErrors.SameGovernance();
        _governance = governance;
    }
}
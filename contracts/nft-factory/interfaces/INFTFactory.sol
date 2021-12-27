// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./INFTFactoryTokens.sol";
import "../../common/governance/interfaces/IGovernable.sol";

interface INFTFactory is IGovernable, INFTFactoryTokens {}

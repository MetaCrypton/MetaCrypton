// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

interface INFTFactoryEvents {
    event TokenDeployed(
        string name,
        string symbol,
        string baseURI,
        address governance,
        address token
    );
}

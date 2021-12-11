// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
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

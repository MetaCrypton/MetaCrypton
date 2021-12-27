// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

interface IProxyUpgradable {
    function upgradeTo(address newInterface) external;

    function implementation() external view returns (address);
}

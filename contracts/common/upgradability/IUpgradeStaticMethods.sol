// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity >=0.8.0 <0.9.0;

interface IUpgradeStaticMethods {
    function getProxyId_() external view returns (bytes32);

    function supportsInterface_(bytes4 interfaceId) external view returns (bool);
}

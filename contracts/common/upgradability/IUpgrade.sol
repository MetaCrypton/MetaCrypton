// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity >=0.8.0 <0.9.0;

import "../interfaces/IERC165.sol";

interface IUpgrade is IERC165 {
    function applyUpgrade() external;

    function getProxyId() external view returns (bytes32);
}

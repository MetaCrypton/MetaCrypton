// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity >=0.8.0 <0.9.0;

import "../interfaces/IERC165.sol";

interface IUpgrade is IERC165 {
    function applyUpgrade() external;

    function getProxyId() external view returns (bytes32);
}

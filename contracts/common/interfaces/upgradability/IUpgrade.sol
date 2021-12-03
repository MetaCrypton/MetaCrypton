// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "../IERC165.sol";

interface IUpgrade is IERC165 {
    function applyUpgrade() external;

    function getProxyId() external view returns (bytes32);
}

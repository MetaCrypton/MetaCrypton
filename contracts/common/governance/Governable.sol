// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./GovernableErrors.sol";

contract Governable {
    modifier isGovernance(address governance) {
        if (msg.sender != governance) revert GovernableErrors.NotGovernance();
        _;
    }
}

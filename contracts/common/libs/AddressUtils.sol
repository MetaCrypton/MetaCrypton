// SPDX-License-Identifier: MIT
// Modified copyright Anton "BaldyAsh" Grigorev
// Original copyright OpenZeppelin Contracts v4.4.0 (utils/Address.sol)
pragma solidity ^0.8.0;

library AddressUtils {
    function isContract(address _addr) internal view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(_addr)
        }
        return size > 0;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library Proxy {
    error EmptySetupAddress();
    error UnknownMethod();

    function _fallback(address impl) internal {
        if (impl == address(0x00)) revert UnknownMethod();

        assembly {
            let p := mload(0x40)
            calldatacopy(p, 0x00, calldatasize())
            let result := delegatecall(gas(), impl, p, calldatasize(), 0x00, 0x00)
            let size := returndatasize()
            returndatacopy(p, 0x00, size)

            switch result
            case 0x00 {
                revert(p, size)
            }
            default {
                return(p, size)
            }
        }
    }
}

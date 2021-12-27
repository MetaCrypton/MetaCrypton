// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../ProxyStorage.sol";

contract Interface is ProxyStorage {
    error UnknownMethod();

    // solhint-disable-next-line comprehensive-interface
    receive() external payable virtual {}

    // solhint-disable-next-line comprehensive-interface
    fallback() external payable {
        _delegateCall();
    }

    function _delegateCall() internal {
        address impl = _methods[msg.sig];
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

    function _staticCall(bytes memory payload) internal view {
        (bool result, bytes memory data) = address(this).staticcall(payload);

        assembly {
            switch result
            case 0x00 {
                revert(add(data, 32), returndatasize())
            }
            default {
                return(add(data, 32), returndatasize())
            }
        }
    }
}

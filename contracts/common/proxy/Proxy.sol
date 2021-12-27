// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./ProxyStorage.sol";
import "./initialization/IInitializable.sol";
import "../governance/Governable.sol";
import "../upgradability/IProxyUpgradable.sol";
import "../interfaces/IERC165.sol";

contract Proxy is IProxyUpgradable, Governable, ProxyStorage {
    error EmptySetupAddress();
    error EmptyInterfaceAddress();
    error SameInterfaceAddress();

    event Upgraded(address indexed implementation);

    constructor(
        address interfaceAddress,
        address setup,
        address governance
    ) {
        if (interfaceAddress == address(0x00)) revert Proxy.EmptyInterfaceAddress();
        if (setup == address(0x00)) revert Proxy.EmptySetupAddress();
        if (governance == address(0x00)) revert GovernableErrors.EmptyGovernance();
        _initializerAddress = msg.sender;

        _interfaceAddress = interfaceAddress;
        emit Upgraded(interfaceAddress);

        _governance = governance;

        _methods[IInitializable.initialize.selector] = setup;
        _methods[IERC165.supportsInterface.selector] = setup;
    }

    // solhint-disable-next-line comprehensive-interface
    receive() external payable virtual {}

    // solhint-disable-next-line comprehensive-interface
    fallback() external payable {
        address impl = _interfaceAddress;

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

    function upgradeTo(address newInterface) external override requestPermission {
        if (newInterface == address(0x00)) revert EmptyInterfaceAddress();
        if (_interfaceAddress == newInterface) revert SameInterfaceAddress();
        _interfaceAddress = newInterface;
        emit Upgraded(newInterface);
    }

    function implementation() external view override returns (address) {
        return _interfaceAddress;
    }
}

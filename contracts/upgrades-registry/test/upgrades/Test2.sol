// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../TestStorage.sol";
import "../interfaces/ITest.sol";
import "../../../common/upgradability/IUpgrade.sol";
import "../../../common/upgradability/UpgradeErrors.sol";

contract Test2 is ITest, IUpgrade, TestStorage {
    constructor() {
        _methods[IUpgrade(address(0x00)).applyUpgrade.selector] = address(this);
        _methods[IUpgrade(address(0x00)).getProxyId.selector] = address(this);
        _methods[IUpgrade(address(0x00)).supportsInterface.selector] = address(this);
    }

    function applyUpgrade() external override {
        if (msg.sender != address(this)) revert UpgradeErrors.ApplyUpgradeOnlyCallableByItself();

        _methods[ITest(address(0x00)).test.selector] = _methods[msg.sig];
    }

    function supportsInterface(bytes4 interfaceId) external view override returns (bool) {
        return
            _methods[interfaceId] != address(0x00) ||
            interfaceId == type(IUpgrade).interfaceId ||
            interfaceId == type(ITest).interfaceId;
    }

    function test() external pure override returns (uint256) {
        return 2;
    }

    function getProxyId() external pure override returns (bytes32) {
        return PROXY_ID;
    }
}

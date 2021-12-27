// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../TestStorage.sol";
import "../interfaces/ITest.sol";
import "../../interfaces/IUpgradesRegistry.sol";
import "../../../common/proxy/initialization/IInitializable.sol";
import "../../../common/proxy/initialization/Initializable.sol";
import "../../../common/governance/Governable.sol";
import "../../../common/upgradability/IUpgrade.sol";
import "../../../common/upgradability/IUpgradable.sol";

contract Test1 is ITest, IUpgrade, IUpgradable, IInitializable, Initializable, Governable, TestStorage {
    error EmptyUpgradesRegistry();

    function upgrade(uint256 upgradeIndex) external override requestPermission {
        address upgradeAddress = IUpgradesRegistry(_upgradesRegistry).upgradeProxy(upgradeIndex);
        _methods[IUpgrade(address(0x00)).applyUpgrade.selector] = upgradeAddress;
        IUpgrade(address(this)).applyUpgrade();

        delete _methods[IUpgrade(address(0x00)).applyUpgrade.selector];
    }

    function getCurrentUpgrades() external view override returns (uint256[] memory) {
        return IUpgradesRegistry(_upgradesRegistry).getProxyCurrentUpgrades(address(this));
    }

    function getMaxPossibleUpgradeIndex() external view override returns (uint256) {
        return IUpgradesRegistry(_upgradesRegistry).getProxyMaxPossibleUpgradeIndex(PROXY_ID);
    }

    function supportsInterface(bytes4 interfaceId) external view override returns (bool) {
        return
            _methods[interfaceId] != address(0x00) ||
            interfaceId == type(IERC165).interfaceId ||
            interfaceId == type(IUpgradable).interfaceId ||
            interfaceId == type(IUpgrade).interfaceId ||
            interfaceId == type(ITest).interfaceId;
    }

    function test() external pure override returns (uint256) {
        return 1;
    }

    function getProxyId() external pure override returns (bytes32) {
        return PROXY_ID;
    }

    function applyUpgrade() external pure override {
        revert InitializableErrors.NoApplyUpgradeOnInit();
    }

    function initialize(bytes memory input) public override(IInitializable, Initializable) {
        address upgradesRegistry = abi.decode(input, (address));
        if (upgradesRegistry == address(0x00)) revert EmptyUpgradesRegistry();
        _upgradesRegistry = upgradesRegistry;

        _storeMethods(_methods[msg.sig]);

        super.initialize(input);
    }

    function _storeMethods(address upgradeAddress) internal {
        _methods[ITest(address(0x00)).test.selector] = upgradeAddress;

        _methods[IUpgradable(address(0x00)).upgrade.selector] = upgradeAddress;
        _methods[IUpgradable(address(0x00)).getCurrentUpgrades.selector] = upgradeAddress;
        _methods[IUpgradable(address(0x00)).getMaxPossibleUpgradeIndex.selector] = upgradeAddress;

        _methods[IUpgrade(address(0x00)).getProxyId.selector] = upgradeAddress;
        _methods[IUpgrade(address(0x00)).supportsInterface.selector] = upgradeAddress;
    }
}

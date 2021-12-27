// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../../../NFTFactoryStorage.sol";
import "../../../interfaces/INFTFactory.sol";
import "../../../interfaces/INFTFactoryStaticMethods.sol";
import "../../../../upgrades-registry/interfaces/IUpgradesRegistry.sol";
import "../../../../common/proxy/initialization/IInitializable.sol";
import "../../../../common/proxy/initialization/Initializable.sol";
import "../../../../common/upgradability/IUpgrade.sol";
import "../../../../common/upgradability/IUpgradable.sol";

contract NFTFactoryInitInitializable is IInitializable, Initializable, NFTFactoryStorage {
    error EmptyUpgradesRegistry();
    error EmptyInventorySetup();
    error EmptyNFTSetup();

    function initialize(bytes memory input) public override(IInitializable, Initializable) {
        (address upgradesRegistry, address nftSetup, address inventorySetup) = abi.decode(
            input,
            (address, address, address)
        );
        if (upgradesRegistry == address(0x00)) revert EmptyUpgradesRegistry();
        if (nftSetup == address(0x00)) revert EmptyNFTSetup();
        if (inventorySetup == address(0x00)) revert EmptyInventorySetup();
        _upgradesRegistry = upgradesRegistry;
        _nftSetup = nftSetup;
        _inventorySetup = inventorySetup;

        _storeMethods(_methods[msg.sig]);

        super.initialize(input);
    }

    function _storeMethods(address upgradeAddress) internal {
        _methods[INFTFactory(address(0x00)).setGovernance.selector] = upgradeAddress;

        _methods[INFTFactory(address(0x00)).deployToken.selector] = upgradeAddress;

        _methods[INFTFactory(address(0x00)).getTokens.selector] = upgradeAddress;
        _methods[INFTFactory(address(0x00)).getTokensTotal.selector] = upgradeAddress;
        _methods[INFTFactory(address(0x00)).getTokensByGovernanceTotal.selector] = upgradeAddress;
        _methods[INFTFactory(address(0x00)).getTokenByAddress.selector] = upgradeAddress;
        _methods[INFTFactory(address(0x00)).getTokenBySymbol.selector] = upgradeAddress;
        _methods[INFTFactory(address(0x00)).getTokensByGovernance.selector] = upgradeAddress;

        _methods[INFTFactoryStaticMethods(address(0x00)).getTokens_.selector] = upgradeAddress;
        _methods[INFTFactoryStaticMethods(address(0x00)).getTokensTotal_.selector] = upgradeAddress;
        _methods[INFTFactoryStaticMethods(address(0x00)).getTokensByGovernanceTotal_.selector] = upgradeAddress;
        _methods[INFTFactoryStaticMethods(address(0x00)).getTokenByAddress_.selector] = upgradeAddress;
        _methods[INFTFactoryStaticMethods(address(0x00)).getTokenBySymbol_.selector] = upgradeAddress;
        _methods[INFTFactoryStaticMethods(address(0x00)).getTokensByGovernance_.selector] = upgradeAddress;

        _methods[IUpgradable(address(0x00)).upgrade.selector] = upgradeAddress;
        _methods[IUpgradable(address(0x00)).getCurrentUpgrades.selector] = upgradeAddress;
        _methods[IUpgradable(address(0x00)).getMaxPossibleUpgradeIndex.selector] = upgradeAddress;
        _methods[IUpgradableStaticMethods(address(0x00)).getCurrentUpgrades_.selector] = upgradeAddress;
        _methods[IUpgradableStaticMethods(address(0x00)).getMaxPossibleUpgradeIndex_.selector] = upgradeAddress;

        _methods[IUpgrade(address(0x00)).getProxyId.selector] = upgradeAddress;
        _methods[IUpgrade(address(0x00)).supportsInterface.selector] = upgradeAddress;
        _methods[IUpgradeStaticMethods(address(0x00)).getProxyId_.selector] = upgradeAddress;
        _methods[IUpgradeStaticMethods(address(0x00)).supportsInterface_.selector] = upgradeAddress;
    }
}

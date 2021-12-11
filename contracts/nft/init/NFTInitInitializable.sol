// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

import "../NFTStorage.sol";
import "../interfaces/INFT.sol";
import "../../upgrades-registry/interfaces/IUpgradesRegistry.sol";
import "../../common/governance/GovernableErrors.sol";
import "../../common/proxy/initialization/IInitializable.sol";
import "../../common/proxy/initialization/Initializable.sol";
import "../../common/upgradability/IUpgrade.sol";
import "../../common/upgradability/IUpgradable.sol";


contract NFTInitInitializable is
    IInitializable,
    Initializable,
    NFTStorage
{
    error EmptyUpgradesRegistry();
    error EmptyInventorySetup();

    function initialize(bytes memory input) public override (IInitializable, Initializable) {
        (
            address governance,
            address upgradesRegistry,
            address inventorySetup
        ) = abi.decode(input, (address, address, address));
        if (governance == address(0x00)) revert GovernableErrors.EmptyGovernance();
        if (upgradesRegistry == address(0x00)) revert EmptyUpgradesRegistry();
        if (inventorySetup == address(0x00)) revert EmptyInventorySetup();
        _governance = governance;
        _upgradesRegistry = upgradesRegistry;
        _inventorySetup = inventorySetup;
        
        _storeMethods(_methods[msg.sig]);

        super.initialize(input);
    }

    function _storeMethods(address upgradeAddress) internal {
        _methods[INFT(address(0x00)).transferFrom.selector] = upgradeAddress;
        _methods[bytes4(keccak256("safeTransferFrom(address,address,uint256)"))] = upgradeAddress;
        _methods[bytes4(keccak256("safeTransferFrom(address,address,uint256,bytes)"))] = upgradeAddress;
        _methods[INFT(address(0x00)).approve.selector] = upgradeAddress;
        _methods[INFT(address(0x00)).setApprovalForAll.selector] = upgradeAddress;
        _methods[INFT(address(0x00)).balanceOf.selector] = upgradeAddress;
        _methods[INFT(address(0x00)).ownerOf.selector] = upgradeAddress;
        _methods[INFT(address(0x00)).getApproved.selector] = upgradeAddress;
        _methods[INFT(address(0x00)).isApprovedForAll.selector] = upgradeAddress;

        _methods[INFT(address(0x00)).burn.selector] = upgradeAddress;

        _methods[INFT(address(0x00)).totalSupply.selector] = upgradeAddress;
        _methods[INFT(address(0x00)).tokenOfOwnerByIndex.selector] = upgradeAddress;
        _methods[INFT(address(0x00)).tokenByIndex.selector] = upgradeAddress;

        _methods[INFT(address(0x00)).name.selector] = upgradeAddress;
        _methods[INFT(address(0x00)).symbol.selector] = upgradeAddress;
        _methods[INFT(address(0x00)).tokenURI.selector] = upgradeAddress;

        _methods[INFT(address(0x00)).mint.selector] = upgradeAddress;
        _methods[bytes4(keccak256("safeMint(address)"))] = upgradeAddress;
        _methods[bytes4(keccak256("safeMint(address,bytes)"))] = upgradeAddress;

        _methods[INFT(address(0x00)).inventoryOf.selector] = upgradeAddress;
        _methods[INFT(address(0x00)).tokenIdByInventory.selector] = upgradeAddress;

        _methods[IUpgradable(address(0x00)).upgrade.selector] = upgradeAddress;
        _methods[IUpgradable(address(0x00)).getCurrentUpgrades.selector] = upgradeAddress;
        _methods[IUpgradable(address(0x00)).getMaxPossibleUpgradeIndex.selector] = upgradeAddress;

        _methods[IUpgrade(address(0x00)).getProxyId.selector] = upgradeAddress;
        _methods[IUpgrade(address(0x00)).supportsInterface.selector] = upgradeAddress;
    }
}
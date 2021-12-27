// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../../../NFTStorage.sol";
import "../../../interfaces/INFT.sol";
import "../../../interfaces/INFTStaticMethods.sol";
import "../../../../common/upgradability/IUpgrade.sol";
import "../../../../common/upgradability/UpgradeErrors.sol";


contract NFTERC721Upgrade is
    IUpgrade,
    NFTStorage
{
    constructor() {
        _methods[IUpgrade(address(0x00)).applyUpgrade.selector] = address(this);
        _methods[IUpgrade(address(0x00)).getProxyId.selector] = address(this);
        _methods[IUpgrade(address(0x00)).supportsInterface.selector] = address(this);
    }

    function applyUpgrade() external override {
        if (msg.sender != address(this)) revert UpgradeErrors.ApplyUpgradeOnlyCallableByItself();
        
        address upgradeAddress = _methods[msg.sig];

        _methods[INFT(address(0x00)).transferFrom.selector] = upgradeAddress;
        _methods[bytes4(keccak256("safeTransferFrom(address,address,uint256)"))] = upgradeAddress;
        _methods[bytes4(keccak256("safeTransferFrom(address,address,uint256,bytes)"))] = upgradeAddress;
        _methods[INFT(address(0x00)).approve.selector] = upgradeAddress;
        _methods[INFT(address(0x00)).setApprovalForAll.selector] = upgradeAddress;
        _methods[INFT(address(0x00)).balanceOf.selector] = upgradeAddress;
        _methods[INFT(address(0x00)).ownerOf.selector] = upgradeAddress;
        _methods[INFT(address(0x00)).getApproved.selector] = upgradeAddress;
        _methods[INFT(address(0x00)).isApprovedForAll.selector] = upgradeAddress;
        _methods[INFTStaticMethods(address(0x00)).balanceOf_.selector] = upgradeAddress;
        _methods[INFTStaticMethods(address(0x00)).ownerOf_.selector] = upgradeAddress;
        _methods[INFTStaticMethods(address(0x00)).getApproved_.selector] = upgradeAddress;
        _methods[INFTStaticMethods(address(0x00)).isApprovedForAll_.selector] = upgradeAddress;

        _methods[INFT(address(0x00)).burn.selector] = upgradeAddress;

        _methods[INFT(address(0x00)).totalSupply.selector] = upgradeAddress;
        _methods[INFT(address(0x00)).tokenOfOwnerByIndex.selector] = upgradeAddress;
        _methods[INFT(address(0x00)).tokenByIndex.selector] = upgradeAddress;
        _methods[INFTStaticMethods(address(0x00)).totalSupply_.selector] = upgradeAddress;
        _methods[INFTStaticMethods(address(0x00)).tokenOfOwnerByIndex_.selector] = upgradeAddress;
        _methods[INFTStaticMethods(address(0x00)).tokenByIndex_.selector] = upgradeAddress;

        _methods[INFT(address(0x00)).name.selector] = upgradeAddress;
        _methods[INFT(address(0x00)).symbol.selector] = upgradeAddress;
        _methods[INFT(address(0x00)).tokenURI.selector] = upgradeAddress;
        _methods[INFTStaticMethods(address(0x00)).name_.selector] = upgradeAddress;
        _methods[INFTStaticMethods(address(0x00)).symbol_.selector] = upgradeAddress;
        _methods[INFTStaticMethods(address(0x00)).tokenURI_.selector] = upgradeAddress;

        _methods[INFT(address(0x00)).mint.selector] = upgradeAddress;
        _methods[bytes4(keccak256("safeMint(address)"))] = upgradeAddress;
        _methods[bytes4(keccak256("safeMint(address,bytes)"))] = upgradeAddress;
    }

    function supportsInterface(bytes4 interfaceId) external view override returns (bool) {
        return _methods[interfaceId] != address(0x00)
            || interfaceId == type(IUpgrade).interfaceId;
    }

    function getProxyId() external pure override returns (bytes32) {
        return PROXY_ID;
    }
}
// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../InventoryStructs.sol";
import "../../common/upgradability/IUpgradableStaticMethods.sol";
import "../../common/upgradability/IUpgradeStaticMethods.sol";

interface IInventoryERC20StaticMethods {
    function getERC20s_(uint256 startIndex, uint256 number) external view returns (ERC20Struct[] memory);
    
    function getERC20Balance_(address token) external view returns (uint256);
}

interface IInventoryERC721StaticMethods {
    function getERC721s_(uint256 startIndex, uint256 number) external view returns (ERC721Struct[] memory);
    
    function isERC721Owner_(address token, uint256 tokenId) external view returns (bool);
}

interface IInventoryERCEtherStaticMethods {
    function getEtherBalance_() external view returns (uint256);
}

interface IInventoryStaticMethods is
    IInventoryERC20StaticMethods,
    IInventoryERC721StaticMethods,
    IInventoryERCEtherStaticMethods,
    IUpgradableStaticMethods,
    IUpgradeStaticMethods
{ }

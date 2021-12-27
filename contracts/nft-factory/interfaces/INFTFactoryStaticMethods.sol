// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../NFTFactoryStructs.sol";
import "../../common/upgradability/IUpgradableStaticMethods.sol";
import "../../common/upgradability/IUpgradeStaticMethods.sol";

interface INFTFactoryTokensStaticMethods {
    function getTokens_(uint256 startIndex, uint256 number) external view returns (NFTToken[] memory);
    
    function getTokensTotal_() external view returns (uint256);

    function getTokensByGovernanceTotal_(address governance) external view returns (uint256);

    function getTokenByAddress_(address token) external view returns (NFTToken memory);

    function getTokenBySymbol_(string calldata symbol) external view returns (NFTToken memory);

    function getTokensByGovernance_(address governance, uint256 startIndex, uint256 number) external view returns (NFTToken[] memory);
}

interface INFTFactoryStaticMethods is
    INFTFactoryTokensStaticMethods,
    IUpgradableStaticMethods,
    IUpgradeStaticMethods
{ }

// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../NFTFactoryStructs.sol";

interface INFTFactory {
    function deployToken(
        string calldata name,
        string calldata symbol,
        string calldata baseURI,
        address governance,
        uint256[] calldata inventoryUpgrades
    ) external returns (address);

    function getTokens(uint256 startIndex, uint256 number) external view returns (NFTToken[] memory);
    
    function getTokensTotal() external view returns (uint256);

    function getTokensByGovernanceTotal(address governance) external view returns (uint256);

    function getTokenByAddress(address token) external view returns (NFTToken memory);

    function getTokenBySymbol(string calldata symbol) external view returns (NFTToken memory);

    function getTokensByGovernance(address governance, uint256 startIndex, uint256 number) external view returns (NFTToken[] memory);
}

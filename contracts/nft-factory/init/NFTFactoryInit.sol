// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./NFTFactoryInitInitializable.sol";
import "./NFTFactoryInitUpgradable.sol";
import "./NFTFactoryInitUpgrade.sol";
import "../NFTFactoryErrors.sol";
import "../interfaces/INFTFactory.sol";
import "../interfaces/INFTFactoryEvents.sol";
import "../../upgrades-registry/interfaces/IUpgradesRegistry.sol";
import "../../nft/NFTProxy.sol";

contract NFTFactoryInit is
    INFTFactory,
    INFTFactoryEvents,
    NFTFactoryInitInitializable,
    NFTFactoryInitUpgradable,
    NFTFactoryInitUpgrade
{
    function deployToken(
        string calldata name,
        string calldata symbol,
        string calldata baseURI,
        address governance
    ) external override requestPermission returns (address) {
        if (_tokenBySymbol[symbol] != 0) revert NFTFactoryErrors.ExistingToken();

        address token = address(new NFTProxy(name, symbol, baseURI, _nftSetup));
        IInitializable(token).initialize(
            abi.encode(governance, _upgradesRegistry, _inventorySetup)
        );
        IUpgradesRegistry(_upgradesRegistry).registerProxy(token);

        _registeredTokens.push(NFTToken(
            token,
            governance,
            symbol
        ));

        uint256 id = _registeredTokens.length;
        _tokenBySymbol[symbol] = id;
        _tokenByAddress[token] = id;
        _tokensByGovernance[governance].push(id);

        emit TokenDeployed(
            name,
            symbol,
            baseURI,
            governance,
            token
        );

        return token;
    }

    function getTokens(uint256 startIndex, uint256 number) external view override returns (NFTToken[] memory) {
        uint256 endIndex = startIndex + number;
        if (endIndex >= _registeredTokens.length) revert NFTFactoryErrors.WrongEndIndex();
        
        NFTToken[] memory result = new NFTToken[](number);
        for (uint256 i = startIndex; i < endIndex; i++) {
            result[i - startIndex] = _registeredTokens[i];
        }
        return result;
    }
    
    function getTokensTotal() external view override returns (uint256) {
        return _registeredTokens.length;
    }

    function getTokensByGovernanceTotal(address governance) external view override returns (uint256) {
        return _tokensByGovernance[governance].length;
    }

    function getTokenByAddress(address token) external view override returns (NFTToken memory) {
        uint index = _tokenByAddress[token];
        if (index == 0) revert NFTFactoryErrors.UnexistingToken();
        return _registeredTokens[index - 1];
    }

    function getTokenBySymbol(string calldata symbol) external view override returns (NFTToken memory) {
        uint index = _tokenBySymbol[symbol];
        if (index == 0) revert NFTFactoryErrors.UnexistingToken();
        return _registeredTokens[index - 1];
    }

    function getTokensByGovernance(address governance, uint256 startIndex, uint256 number) external view override returns (NFTToken[] memory) {
        uint256 endIndex = startIndex + number;
        if (endIndex >= _tokensByGovernance[governance].length) revert NFTFactoryErrors.WrongEndIndex();
        
        NFTToken[] memory result = new NFTToken[](number);
        for (uint256 i = startIndex; i < endIndex; i++) {
            result[i - startIndex] = _registeredTokens[_tokensByGovernance[governance][i]];
        }
        return result;
    }
}

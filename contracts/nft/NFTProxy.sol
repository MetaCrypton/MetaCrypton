// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./NFTStorage.sol";
import "../common/proxy/Proxy.sol";

contract NFTProxy is Proxy, NFTStorage {
    error UseDepositEtherFunction();
    error WrongSymbolLength();
    error WrongNameLength();

    constructor(
        string memory name,
        string memory symbol,
        string memory baseURI,
        address setup
    ) Proxy(setup) {
        if ((bytes(name).length == 0) || (bytes(name).length > 30)) revert WrongNameLength();
        if ((bytes(symbol).length == 0) || (bytes(symbol).length > 10)) revert WrongSymbolLength();

        _name = name;
        _symbol = symbol;
        _baseURI = baseURI;
    }

    receive() external payable override (Proxy) {
        revert UseDepositEtherFunction();
    }
}

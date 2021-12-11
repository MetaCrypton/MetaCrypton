// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

library InventoryErrors {
    error UnexistingAsset();
    error UnmatchingAssetType();
    error WrongEndIndex();
    error EmptyAddress();
    error ZeroAmount();
    error UnmatchingTokenId();
    error UnmatchingTokenAddress();
    error ExistingToken();
    error DepositOverflow();
    error WithdrawOverflow();
    error EtherTransferFailed();
    error NotInventoryNftOwner();
}

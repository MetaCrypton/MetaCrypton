// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

library NFTErrors {
    error TransferToNonERC721ReceiverImplementer();
    error TransferNotFromOwner();
    error TransferToOwner();
    error ApproveToCaller();
    error ExistingToken();
    error UnexistingToken();
    error TransferNotFromOwnerNorApproved();
    error ApprovalToCurrentOwner();
    error NotApproved();
    error IndexOutOfBounds();
    error RecipientIsZero();
    error BurnNotFromOwnerNorApproved();
    error EmptyLootNFT();
    error SameLootNFT();
}

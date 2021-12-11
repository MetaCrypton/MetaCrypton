// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
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
}

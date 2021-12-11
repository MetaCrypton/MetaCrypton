// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

import "./INFTInventory.sol";
import "../../common/interfaces/IERC721.sol";
import "../../common/interfaces/IERC165.sol";
import "../../common/interfaces/IERC721Burnable.sol";
import "../../common/interfaces/IERC721Enumerable.sol";
import "../../common/interfaces/IERC721Mintable.sol";
import "../../common/interfaces/IERC721Metadata.sol";

interface INFT is
    IERC721,
    IERC165,
    IERC721Burnable,
    IERC721Enumerable,
    IERC721Mintable,
    IERC721Metadata,
    INFTInventory
{ }

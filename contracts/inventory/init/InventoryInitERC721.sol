// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./InventoryInitOwnership.sol";
import "../interfaces/IInventoryERC721.sol";
import "../../common/interfaces/IERC721.sol";

contract InventoryERC721 is
    IInventoryERC721,
    InventoryInitOwnership
{
}

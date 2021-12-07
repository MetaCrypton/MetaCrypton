// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IInventoryAssets.sol";
import "./IInventoryEther.sol";
import "./IInventoryERC20.sol";
import "./IInventoryERC721.sol";
import "../../common/interfaces/IERC1155.sol";
import "../../common/interfaces/IERC1155Receiver.sol";
import "../../common/interfaces/IERC20Receiver.sol";
import "../../common/interfaces/IERC721Receiver.sol";

interface IInventory is
    IInventoryAssets,
    IInventoryEther,
    IInventoryERC20,
    IInventoryERC721,
    IERC1155,
    IERC1155Receiver,
    IERC20Receiver,
    IERC721Receiver
{ }

// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

import "./NFTInitERC721.sol";
import "./NFTInitERC721Mintable.sol";
import "./NFTInitERC721Burnable.sol";
import "./NFTInitERC721Enumerable.sol";
import "./NFTInitERC721Metadata.sol";
import "./NFTInitInventory.sol";
import "./NFTInitInitializable.sol";
import "./NFTInitUpgradable.sol";
import "./NFTInitUpgrade.sol";

contract NFTInit is
    NFTInitERC721,
    NFTInitERC721Mintable,
    NFTInitERC721Burnable,
    NFTInitERC721Enumerable,
    NFTInitERC721Metadata,
    NFTInitInventory,
    NFTInitInitializable,
    NFTInitUpgradable,
    NFTInitUpgrade
{ }

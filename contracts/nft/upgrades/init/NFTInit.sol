// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./NFTInitGovernable.sol";
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
    NFTInitGovernable,
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

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./InventoryInitAssets.sol";
import "./InventoryInitOwnership.sol";
import "../InventoryErrors.sol";
import "../interfaces/IInventoryERC20Internal.sol";
import "../interfaces/IInventoryERC20.sol";
import "../interfaces/IInventory.sol";
import "../../common/interfaces/IERC20.sol";
import "../../common/interfaces/IERC165.sol";

contract InventoryInitERC20 is
    IInventoryERC20,
    InventoryInitOwnership,
    InventoryInitAssets
{
    modifier verifyERC20Input(address token, uint256 amount) {
        if (token == address(0x00)) revert InventoryErrors.EmptyAddress();
        if (amount == 0) revert InventoryErrors.ZeroAmount();
        _;
    }

    function depositERC20(address from, address token, uint256 amount, bytes calldata data) external override isOwner returns (bytes memory) {
        _depositERC20(from, token, amount);

        if (IERC165(address(this)).supportsInterface(IInventoryERC20Internal(address(0x00)).processDepositERC20.selector)) {
            return IInventoryERC20Internal(address(this)).processDepositERC20(from, token, amount, data);
        }
        return new bytes(0);
    }

    function withdrawERC20(address recipient, address token, uint256 amount, bytes calldata data) external override isOwner returns (bytes memory) {
        _withdrawERC20(recipient, token, amount);

        if (IERC165(address(this)).supportsInterface(IInventoryERC20Internal(address(0x00)).processWithdrawERC20.selector)) {
            return IInventoryERC20Internal(address(this)).processWithdrawERC20(recipient, token, amount, data);
        }
        return new bytes(0);
    }
    
    function getERC20s(uint256 startIndex, uint256 number) external view override returns (ERC20Struct[] memory) {
        return _assetsListToERC20(_getAssets(startIndex, number));
    }
    
    function getERC20Balance(address token) external view override returns (uint256) {
        uint256 id = _getERC20Id(token);
        uint256 index = _getAssetIndexById(id);
        if (index == 0) revert InventoryErrors.UnexistingAsset();

        Asset storage asset = _getAssetByIndex(index);
        ERC20Struct memory storedToken = _assetToERC20Token(asset);
        if (storedToken.tokenAddress != token) revert InventoryErrors.UnmatchingTokenAddress();

        return storedToken.amount;
    }

    function _depositERC20(address from, address token, uint256 amount) internal verifyERC20Input(token, amount) {
        emit DepositERC20(
            from,
            token,
            amount
        );

        uint256 id = _getERC20Id(token);
        uint256 index = _getAssetIndexById(id);

        if (index == 0) {
            _addAsset(id, AssetType.ERC20, abi.encode(ERC20Struct(token, amount)));
        } else {
            Asset storage asset = _getAssetByIndex(index);
            ERC20Struct memory storedToken = _assetToERC20Token(asset);
            if (storedToken.tokenAddress != token) revert InventoryErrors.UnmatchingTokenAddress();
            if (type(uint256).max - storedToken.amount < amount) revert InventoryErrors.DepositOverflow();
            storedToken.amount += amount;
            _updateAsset(asset, abi.encode(storedToken));
        }

        IERC20(token).transferFrom(from, address(this), amount);
    }

    function _withdrawERC20(address recipient, address token, uint256 amount) internal verifyERC20Input(token, amount) {
        emit WithdrawERC20(
            recipient,
            token,
            amount
        );

        uint256 id = _getERC20Id(token);
        uint256 index = _getAssetIndexById(id);
        if (index == 0) revert InventoryErrors.UnexistingAsset();

        Asset storage asset = _getAssetByIndex(index);
        ERC20Struct memory storedToken = _assetToERC20Token(asset);
        if (storedToken.tokenAddress != token) revert InventoryErrors.UnmatchingTokenAddress();
        if (storedToken.amount < amount) revert InventoryErrors.WithdrawOverflow();

        storedToken.amount -= amount;
        if (storedToken.amount > 0) {
            _updateAsset(asset, abi.encode(storedToken));
        } else {
            _removeAsset(index, asset);
        }

        IERC20(token).transfer(recipient, amount);
    }

    function _assetToERC20Token(Asset memory asset) internal pure returns (ERC20Struct memory) {
        if (asset.assetType != AssetType.ERC20) revert InventoryErrors.UnmatchingAssetType();

        return abi.decode(asset.data, (ERC20Struct));
    }

    function _assetsListToERC20(Asset[] memory assets) internal pure returns (ERC20Struct[] memory) {
        uint256 tokensLength = 0;
        uint256 assetsLength = assets.length;

        for (uint256 i = 0; i < assetsLength; i++) {
            if (assets[i].assetType == AssetType.ERC20) {
                tokensLength++;
            }
        }

        ERC20Struct[] memory tokens = new ERC20Struct[](tokensLength);
        uint256 counter = 0;
        for (uint256 i = 0; i < assetsLength; i++) {
            if (assets[i].assetType == AssetType.ERC20) {
                tokens[counter++] = _assetToERC20Token(assets[i]);
            }
        }

        return tokens;
    }
    
    function _getERC20Id(address token) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(token)));
    } 
}

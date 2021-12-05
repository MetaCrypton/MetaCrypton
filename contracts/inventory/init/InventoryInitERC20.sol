// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./InventoryInitOwnership.sol";
import "../InventoryErrors.sol";
import "../interfaces/IInventoryERC20Internal.sol";
import "../interfaces/IInventoryERC20.sol";
import "../../common/interfaces/IERC20.sol";
import "../../common/interfaces/IERC165.sol";

contract InventoryERC20 is
    IInventoryERC20,
    InventoryInitOwnership
{
    function depositERC20(address token, uint256 amount, bytes calldata data) external override isOwner returns (bytes memory) {
        _depositERC20(token, amount);

        if (IERC165(address(this)).supportsInterface(IInventory(address(0x00)).processDepositERC20.selector)) {
            return IInventoryERC20Internal(address(this)).processDepositERC20(token, amount, data);
        }
    }

    function withdrawERC20(address recipient, address token, uint256 amount, bytes calldata data) external override isOwner returns (bytes memory) {
        _withdrawERC20(recipient, token, amount);

        if (IERC165(address(this)).supportsInterface(IInventory(address(0x00)).processWithdrawERC20.selector)) {
            return IInventoryERC20Internal(address(this)).processWithdrawERC20(token, amount, data);
        }
    }
    
    function getERC20s() external view override returns (ERC20Struct[] memory) {
        return _erc20s.tokens;
    }
    
    function getERC20Balance(address token) external view override returns (uint256) {
        uint256 index = _getERC20IndexByAddress(token);
        if (index == 0) revert InventoryErrors.UnexistingToken();

        return _erc20s.tokens[index - 1].amount;
    }

    function _withdrawERC20(address recipient, address token, uint256 amount) internal {
        emit WithdrawERC20(
            recipient,
            token,
            amount
        );

        IERC20(token).transfer(recipient, amount);

        _removeERC20(
            token,
            amount
        );
    }

    function _depositERC20(address token, uint256 amount) internal {
        emit DepositERC20(
            msg.sender,
            token,
            amount
        );

        IERC20(token).transferFrom(msg.sender, address(this), amount);

        _addERC20(
            token,
            amount
        );
    }

    function _addERC20(address token, uint256 amount) internal verifyAddToken(token, amount) {
        uint256 index = _getERC20IndexByAddress(token);
        if (index == 0) {
            _erc20s.tokens.push(ERC20Struct(token, amount));
            _erc20s.tokenIndexByAddress[token] = _erc20s.tokens.length;
        } else {
            ERC20Struct storage storedToken = _erc20s.tokens[index - 1];
            storedToken.amount += amount;
        }
    }

    function _removeERC20(address token, uint256 amount) internal verifyRemoveToken(token, amount) {
        uint256 index = _getERC20IndexByAddress(token);
        if (index == 0) revert UnexistingToken();
        
        ERC20Struct storage storedToken = _erc20s.tokens[index - 1];
        uint256 tokenAmount = storedToken.amount;
        if (tokenAmount == 0) revert ZeroAmount();
        if (amount > tokenAmount) revert RemoveAmountOverflow();
        uint256 resultAmount = tokenAmount - amount;

        if (resultAmount = 0) {
            uint256 lastIndex = _erc20s.tokens.length - 1;
            ERC20Struct memory last = _erc20s.tokens[lastIndex];

            storedToken = last;
            _erc20s.tokenIndexByAddress[last.token] = index;

            _erc20s.tokens.pop();
            delete _erc20s.tokenIndexByAddress[token];
        } else {
            storedToken.amount -= amount;
        }
    }

    function _getERC20IndexByAddress(address token) internal view returns (uint256) {
        uint index = _erc20s.tokenIndexByAddress[token];
        return index;
    }
}

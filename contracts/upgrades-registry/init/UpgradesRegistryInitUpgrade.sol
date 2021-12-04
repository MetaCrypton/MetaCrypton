// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./UpgradesRegistryInitCommon.sol";
import "../../common/upgradability/IUpgrade.sol";
import "../../common/proxy/initialization/InitializableErrors.sol";

contract UpgradesRegistryInitUpgrade is
    IUpgrade,
    UpgradesRegistryInitCommon
{
    function supportsInterface(bytes4 interfaceId) external view override returns (bool) {
        return _methods[interfaceId] != address(0x00);
    }

    function getProxyId() external pure override returns (bytes32) {
        return PROXY_ID;
    }

    function applyUpgrade() external pure override {
        revert InitializableErrors.NoApplyUpgradeOnInit();
    }
}

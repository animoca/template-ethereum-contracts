// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IForwarderRegistry} from "@animoca/ethereum-contracts/contracts/metatx/interfaces/IForwarderRegistry.sol";
import {ERC20} from "@animoca/ethereum-contracts/contracts/token/ERC20/ERC20.sol";
import {ERC20Detailed} from "@animoca/ethereum-contracts/contracts/token/ERC20/ERC20Detailed.sol";
import {ERC20Metadata} from "@animoca/ethereum-contracts/contracts/token/ERC20/ERC20Metadata.sol";
import {ERC20Permit} from "@animoca/ethereum-contracts/contracts/token/ERC20/ERC20Permit.sol";
import {ERC20SafeTransfers} from "@animoca/ethereum-contracts/contracts/token/ERC20/ERC20SafeTransfers.sol";
import {ERC20BatchTransfers} from "@animoca/ethereum-contracts/contracts/token/ERC20/ERC20BatchTransfers.sol";
import {TokenRecovery} from "@animoca/ethereum-contracts/contracts/security/TokenRecovery.sol";
import {ContractOwnership} from "@animoca/ethereum-contracts/contracts/access/ContractOwnership.sol";
import {Context} from "@openzeppelin/contracts/utils/Context.sol";
import {ForwarderRegistryContextBase} from "@animoca/ethereum-contracts/contracts/metatx/base/ForwarderRegistryContextBase.sol";
import {ForwarderRegistryContext} from "@animoca/ethereum-contracts/contracts/metatx/ForwarderRegistryContext.sol";

contract Token is ERC20, ERC20Detailed, ERC20Metadata, ERC20Permit, ERC20SafeTransfers, ERC20BatchTransfers, TokenRecovery, ForwarderRegistryContext {
    constructor(
        string memory tokenName,
        string memory tokenSymbol,
        uint8 tokenDecimals,
        IForwarderRegistry forwarderRegistry
    )
        ERC20()
        ERC20Detailed(tokenName, tokenSymbol, tokenDecimals)
        ERC20Metadata()
        ForwarderRegistryContext(forwarderRegistry)
        ContractOwnership(msg.sender)
    {}

    /// @inheritdoc ForwarderRegistryContextBase
    function _msgSender() internal view virtual override(Context, ForwarderRegistryContextBase) returns (address) {
        return ForwarderRegistryContextBase._msgSender();
    }

    /// @inheritdoc ForwarderRegistryContextBase
    function _msgData() internal view virtual override(Context, ForwarderRegistryContextBase) returns (bytes calldata) {
        return ForwarderRegistryContextBase._msgData();
    }
}

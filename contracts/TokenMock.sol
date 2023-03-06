// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IForwarderRegistry} from "@animoca/ethereum-contracts/contracts/metatx/interfaces/IForwarderRegistry.sol";
import {ForwarderRegistryContextBase} from "@animoca/ethereum-contracts/contracts/metatx/base/ForwarderRegistryContextBase.sol";
import {ERC20Mintable} from "@animoca/ethereum-contracts/contracts/token/ERC20/ERC20Mintable.sol";
import {Context} from "@openzeppelin/contracts/utils/Context.sol";
import {Token} from "./Token.sol";

contract TokenMock is Token, ERC20Mintable {
    constructor(
        string memory tokenName,
        string memory tokenSymbol,
        uint8 tokenDecimals,
        IForwarderRegistry forwarderRegistry
    ) Token(tokenName, tokenSymbol, tokenDecimals, forwarderRegistry) {}

    /// @inheritdoc Token
    function _msgSender() internal view virtual override(Context, Token) returns (address) {
        return Token._msgSender();
    }

    /// @inheritdoc Token
    function _msgData() internal view virtual override(Context, Token) returns (bytes calldata) {
        return Token._msgData();
    }

    function __msgData() external view returns (bytes calldata) {
        return _msgData();
    }
}

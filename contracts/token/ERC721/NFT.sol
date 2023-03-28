// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IOperatorFilterRegistry} from "@animoca/ethereum-contracts/contracts/token/royalty/interfaces/IOperatorFilterRegistry.sol";
import {IForwarderRegistry} from "@animoca/ethereum-contracts/contracts/metatx/interfaces/IForwarderRegistry.sol";
import {ERC721WithOperatorFilterer} from "@animoca/ethereum-contracts/contracts/token/ERC721/ERC721WithOperatorFilterer.sol";
// solhint-disable-next-line max-line-length
import {ERC721BatchTransferWithOperatorFilterer} from "@animoca/ethereum-contracts/contracts/token/ERC721/ERC721BatchTransferWithOperatorFilterer.sol";
import {ERC721MetadataWithBaseURI} from "@animoca/ethereum-contracts/contracts/token/ERC721/ERC721MetadataWithBaseURI.sol";
import {ERC721Mintable} from "@animoca/ethereum-contracts/contracts/token/ERC721/ERC721Mintable.sol";
import {ERC721Deliverable} from "@animoca/ethereum-contracts/contracts/token/ERC721/ERC721Deliverable.sol";
import {ERC721Burnable} from "@animoca/ethereum-contracts/contracts/token/ERC721/ERC721Burnable.sol";
import {ERC2981} from "@animoca/ethereum-contracts/contracts/token/royalty/ERC2981.sol";
import {TokenRecovery} from "@animoca/ethereum-contracts/contracts/security/TokenRecovery.sol";
import {ContractOwnership} from "@animoca/ethereum-contracts/contracts/access/ContractOwnership.sol";
import {Context} from "@openzeppelin/contracts/utils/Context.sol";
import {ForwarderRegistryContextBase} from "@animoca/ethereum-contracts/contracts/metatx/base/ForwarderRegistryContextBase.sol";
import {ForwarderRegistryContext} from "@animoca/ethereum-contracts/contracts/metatx/ForwarderRegistryContext.sol";

contract NFT is
    ERC721WithOperatorFilterer,
    ERC721BatchTransferWithOperatorFilterer,
    ERC721MetadataWithBaseURI,
    ERC721Burnable,
    ERC721Mintable,
    ERC721Deliverable,
    ERC2981,
    TokenRecovery,
    ForwarderRegistryContext
{
    constructor(
        string memory name,
        string memory symbol,
        IOperatorFilterRegistry filterRegistry,
        IForwarderRegistry forwarderRegistry
    )
        ERC721WithOperatorFilterer(filterRegistry)
        ERC721MetadataWithBaseURI(name, symbol)
        ContractOwnership(msg.sender)
        ForwarderRegistryContext(forwarderRegistry)
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

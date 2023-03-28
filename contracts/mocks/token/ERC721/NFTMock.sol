// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IForwarderRegistry} from "@animoca/ethereum-contracts/contracts/metatx/interfaces/IForwarderRegistry.sol";
import {IOperatorFilterRegistry} from "@animoca/ethereum-contracts/contracts/token/royalty/interfaces/IOperatorFilterRegistry.sol";
import {NFT} from "./../../../token/ERC721/NFT.sol";

contract NFTMock is NFT {
    constructor(
        string memory name,
        string memory symbol,
        IOperatorFilterRegistry filterRegistry,
        IForwarderRegistry forwarderRegistry
    ) NFT(name, symbol, filterRegistry, forwarderRegistry) {}

    function __msgData() external view returns (bytes calldata) {
        return _msgData();
    }
}

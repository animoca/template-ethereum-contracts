// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {IForwarderRegistry} from "@animoca/ethereum-contracts/contracts/metatx/interfaces/IForwarderRegistry.sol";
import {MyContract} from "./../MyContract.sol";

contract MyContractMock is MyContract {
    constructor(address data, IForwarderRegistry forwarderRegistry) MyContract(data, forwarderRegistry) {}

    function __msgData() external view returns (bytes calldata) {
        return _msgData();
    }
}

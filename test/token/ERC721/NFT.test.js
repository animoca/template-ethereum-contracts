const {runBehaviorTests} = require('@animoca/ethereum-contract-helpers/src/test/run');
const {getForwarderRegistryAddress, getOperatorFilterRegistryAddress} = require('@animoca/ethereum-contracts/test/helpers/registries');
const {behavesLikeERC721} = require('@animoca/ethereum-contracts/test/contracts/token/ERC721/behaviors/ERC721.behavior');

const name = 'name';
const symbol = 'symbol';
const baseMetadataURI = '';

const config = {
  immutable: {
    name: 'NFTMock',
    ctorArguments: ['name', 'symbol', 'operatorFilterRegistry', 'forwarderRegistry'],
    testMsgData: true,
  },
  defaultArguments: {
    name,
    symbol,
    operatorFilterRegistry: getOperatorFilterRegistryAddress,
    forwarderRegistry: getForwarderRegistryAddress,
  },
};

runBehaviorTests('REVVRacingNFT', config, function (deployFn) {
  const implementation = {
    name,
    symbol,
    baseMetadataURI,
    revertMessages: {
      NonApproved: 'ERC721: non-approved sender',
      SelfApproval: 'ERC721: self-approval',
      SelfApprovalForAll: 'ERC721: self-approval for all',
      BalanceOfAddressZero: 'ERC721: balance of address(0)',
      TransferToAddressZero: 'ERC721: transfer to address(0)',
      MintToAddressZero: 'ERC721: mint to address(0)',
      SafeTransferRejected: 'ERC721: safe transfer rejected',
      NonExistingToken: 'ERC721: non-existing token',
      NonOwnedToken: 'ERC721: non-owned token',
      ExistingToken: 'ERC721: existing token',
      InconsistentArrays: 'ERC721: inconsistent arrays',

      // Admin
      NotMinter: "AccessControl: missing 'minter' role",
      NotContractOwner: 'Ownership: not the owner',
    },
    features: {
      BaseMetadataURI: true,
      WithOperatorFilter: true,
    },
    interfaces: {
      ERC721: true,
      ERC721BatchTransfer: true,
      ERC721Mintable: true,
      ERC721Deliverable: true,
      ERC721Burnable: true,
      ERC721Metadata: true,
    },
    methods: {
      'batchTransferFrom(address,address,uint256[])': async function (contract, from, to, ids, signer) {
        return contract.connect(signer).batchTransferFrom(from, to, ids);
      },
      'mint(address,uint256)': async function (contract, to, tokenId, signer) {
        return contract.connect(signer).mint(to, tokenId);
      },
      'safeMint(address,uint256,bytes)': async function (contract, to, tokenId, data, signer) {
        return contract.connect(signer).safeMint(to, tokenId, data);
      },
      'batchMint(address,uint256[])': async function (contract, to, tokenIds, signer) {
        return contract.connect(signer).batchMint(to, tokenIds);
      },
      'burnFrom(address,uint256)': async function (contract, from, id, signer) {
        return contract.connect(signer).burnFrom(from, id);
      },
      'batchBurnFrom(address,uint256[])': async function (contract, from, tokenIds, signer) {
        return contract.connect(signer).batchBurnFrom(from, tokenIds);
      },
    },
    deploy: async function (deployer) {
      const contract = await deployFn();
      await contract.grantRole(await contract.MINTER_ROLE(), deployer.address);
      return contract;
    },
    mint: async function (contract, to, id, _value) {
      return contract.mint(to, id);
    },
    tokenMetadata: async function (contract, id) {
      return contract.tokenURI(id);
    },
  };

  behavesLikeERC721(implementation);
});

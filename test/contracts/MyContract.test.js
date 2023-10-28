const {ethers} = require('hardhat');
const {expect} = require('chai');
const {runBehaviorTests} = require('@animoca/ethereum-contract-helpers/src/test/run');
const {loadFixture} = require('@animoca/ethereum-contract-helpers/src/test/fixtures');
const {getDeployerAddress} = require('@animoca/ethereum-contract-helpers/src/test/accounts');
const {getForwarderRegistryAddress} = require('@animoca/ethereum-contracts/test/helpers/registries');

const config = {
  immutable: {name: 'MyContractMock', ctorArguments: ['data', 'forwarderRegistry'], testMsgData: true},
  defaultArguments: {
    data: getDeployerAddress,
    forwarderRegistry: getForwarderRegistryAddress,
  },
};

runBehaviorTests('MyContract', config, function (deployFn) {
  let deployer, other;

  before(async function () {
    [deployer, other] = await ethers.getSigners();
  });

  const fixture = async function () {
    this.contract = await deployFn();
  };

  beforeEach(async function () {
    await loadFixture(fixture, this);
  });

  describe('constructor(address,address)', function () {
    it('reverts if the data is zero', async function () {
      const artifact = await ethers.getContractFactory('MyContractMock');
      expect(deployFn({data: ethers.ZeroAddress})).to.be.revertedWithCustomError(artifact, 'InvalidZeroData');
    });

    context('when successful', function () {
      it('sets the data', async function () {
        expect(await this.contract.myData()).to.equal(deployer.address);
      });

      it('emits a DataSet event', async function () {
        await expect(this.contract.deployTransaction.hash).to.emit(this.contract, 'DataSet').withArgs(deployer.address);
      });
    });
  });

  describe('setData(address)', function () {
    it('reverts if the data is zero', async function () {
      expect(this.contract.setData(ethers.ZeroAddress)).to.be.revertedWithCustomError(this.contract, 'InvalidZeroData');
    });

    it('reverts if not called by the contract owner', async function () {
      expect(this.contract.connect(other).setData(other.address))
        .to.be.revertedWithCustomError(this.contract, 'NotContractOwner')
        .withArgs(other.address);
    });

    context('when successful', function () {
      beforeEach(async function () {
        this.receipt = await this.contract.setData(other.address);
      });

      it('sets the data', async function () {
        expect(await this.contract.myData()).to.equal(other.address);
      });

      it('emits a DataSet event', async function () {
        await expect(this.receipt).to.emit(this.contract, 'DataSet').withArgs(other.address);
      });
    });
  });
});

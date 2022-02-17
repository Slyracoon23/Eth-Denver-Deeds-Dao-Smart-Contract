const { expect, assert } = require("chai");
const { ethers, artifacts } = require("hardhat");


describe("ERC721 Vault Factory contract", function() {


    let settings_contract;
    let factory_contract;
    let ERC721_contract;

    let owner;
    let addr1;
    let addr2;
    let addrs;

     /// @notice Depolyment on contract
     beforeEach(async function() {
        // Create accounts
        [owner, addr1, addr2, ...addrs] = await ethers.getSigners();

        // create and deploy setttings contract
        settings = await ethers.getContractFactory("Settings");
        settings_contract = await settings.deploy();

        // create and deploy ERC721VaultFactor Contract
        const factory = await ethers.getContractFactory("ERC721VaultFactory");
        factory_contract = await factory.deploy(settings_contract.address);

        // create and deploy ERC721 Contract
        const ERC721 = await ethers.getContractFactory("SimpleERC721");
        ERC721_contract = await ERC721.deploy(); // Params are with the contract: ERC721("Test-NFT","t-nft")


    });


    it("test deployment", async function() {

        expect(await ERC721_contract.name()).to.equal("Test-NFT");



    });

});


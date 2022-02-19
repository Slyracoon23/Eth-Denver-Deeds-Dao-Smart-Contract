const { expect, assert } = require("chai");
const { ethers, artifacts } = require("hardhat");
const 


describe("ERC721 Token Vault contract", function() {


    let settings_contract;
    let factory_contract;
    let ERC721_contract;

    let owner;
    let addr1;
    let addr2;
    let addrs;

    let vault_address;

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


        ERC721_contract.mint(owner.address, 1);

        ERC721_contract.setApprovalForAll(factory_contract.address, true);

        factory_contract.mint("Test-NFT", "t-nft",ERC721_contract.address, 1, 1000, 100, 50);

        vault_address = await factory_contract.vaults(0);

        // crete ERC721TokenVault
        const token_vault = await ethers.getContractFactory("TokenVault");

        vault2 = await token_vault.attach(
            vault_address // The deployed contract address
        );
        

    });


    it("test kick Curator", async function() {

        


    });

    it("test initial Reserve", async function() {

        // reserve rpice here should not change
        expect(await vault_address.reservePrice()).to.equal(100);

    });
    
    it("test factory ERC20 mint", async function() {

        factory_contract.mint("Test-NFT", "t-nft",ERC721_contract.address, 1, 1000, 100, 50);

        // expect vaultCount to be 1
        expect(await factory_contract.vaultCount()).to.equal(1);

    });







});


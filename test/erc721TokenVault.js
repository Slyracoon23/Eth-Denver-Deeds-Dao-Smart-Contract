const { expect, assert } = require("chai");
const { ethers, artifacts } = require("hardhat");


describe("ERC721 Token Vault contract", function() {


    let settings_contract;
    let factory_contract;
    let ERC721_contract;

    let owner;
    let addr1;
    let addr2;
    let addrs;

    let vault_address;

    let vault;

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


        ///////////////////////////////////////////////////////////////////

        ERC721_contract.mint(owner.address, 1);

        ERC721_contract.setApprovalForAll(factory_contract.address, true);

        factory_contract.mint("vault-NFT", "v-nft",ERC721_contract.address, 1);

        vault_address = await factory_contract.vaults(0);

        // crete ERC721TokenVault
        const token_vault = await ethers.getContractFactory("TokenVault");

        vault = await token_vault.attach(
            vault_address // The deployed contract address
        );
        

    });


    it("test Vault Key", async function() {

        expect(await vault.name()).to.equal("vault-NFT");



    });

    it("test valult open", async function() {
        expect(await vault.vaultClosed()).to.equal(false);
    })


    it







});


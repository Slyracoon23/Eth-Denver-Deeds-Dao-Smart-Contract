const { expect, assert } = require("chai");
const { ethers, artifacts } = require("hardhat");


describe("Settings contract", function() {

    let settings;

    let settings_contract;

    let owner;
    let addr1;
    let addr2;
    let addrs;
    
    /// @notice Depolyment on contract
    beforeEach(async function() {

        settings = await ethers.getContractFactory("Settings");
        [owner, addr1, addr2, ...addrs] = await ethers.getSigners();

        settings_contract = await settings.deploy();


    });

    it("test setGovernanceFee", async function() {

        settings_contract.setGovernanceFee(90);

        expect(await settings_contract.governanceFee()).to.equal(90);

    });

    it("test Fail setGovernanceFee", async function() {

        try{
         await settings_contract.setGovernanceFee(110);
        
         expect.fail("Should have thrown before");
        } catch(error) {
            
        expect(error.message).to.have.string("fee too high");
    }

    });





});
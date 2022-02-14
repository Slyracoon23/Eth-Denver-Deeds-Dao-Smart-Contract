# Eth-Denver-Deeds-Dao-Smart-Contract
Deeds smart contract 

# Smart contract Workflow Description

## ERC721 Factory smart contract
This is a simple smart contract that a user can call to mint a new Deed the

* an ERC721 token desired name
* an ERC721 token desired symbol

Aditional Info
* URL Link to DEEDS contract on IPFS



## Vault Factory
This is a simple factory where a user can call mint to create a new vault with the token that they want to fractionalize. The user must pass in:

* an ERC20 token desired name
* an ERC20 token desired symbol
* the ERC721 token address they wish to fractionalize
* the ERC721 token id they wish to fractionalize
* the desired ERC20 token supply
* the initial listing price of the NFT
* their desired curator fee

## Token Vault
The token vault is the smart contract which holds the logic for NFTs/Deeds that have been fractionalized.

Token owners are able to update the renting/leaseing price with a weighted average of all token owners renting/leasing prices. This is done automatically on token transfer to new accounts or manually through updateUserPrice.

Alongside this logic, is the payout logic which allows others to lease the NFT through a set of functions

**Buy Lease** 
- Buyer can buy the NFT ownership for a period of time

**Transfer Lease**
- Buyer transfter the lease to other person

**Renew Lease**
- Buyer can renew a lease

**End Lease**
- Buyer ends the leasing period and ownership is reverted back to the smart contract

**NOTE**
THere is some admin logic for the original NFT "owner"(User who initially deposited the NFT). They can change some settings




# Workflow


//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Interfaces/IWETH.sol";
import "./OpenZeppelin/math/Math.sol";
import "./OpenZeppelin/token/ERC20/ERC20.sol";
import "./OpenZeppelin/token/ERC721/ERC721.sol";
import "./OpenZeppelin/token/ERC721/ERC721Holder.sol";
import "./OpenZeppelin/access/Ownable.sol";


import "./Settings.sol";

import "./OpenZeppelin/upgradeable/token/ERC721/utils/ERC721HolderUpgradeable.sol";
import "./OpenZeppelin/upgradeable/token/ERC20/ERC20Upgradeable.sol";

contract TokenVault is ERC721HolderUpgradeable, Ownable {
    using Address for address;

    /// -----------------------------------
    /// -------- BASIC INFORMATION --------
    /// -----------------------------------

    /// @notice weth address
    address public constant weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    /// -----------------------------------
    /// -------- TOKEN INFORMATION --------
    /// -----------------------------------

    /// @notice the ERC721 token address of the vault's token
    address public token;

    /// @notice the ERC721 token ID of the vault's token
    uint256 public id;


    /// -----------------------------------
    /// -------- VAULT INFORMATION --------
    /// -----------------------------------

    /// @notice the governance contract which gets paid in ETH
    address public immutable settings;

    /// @notice list price of entire NFT
    uint245 public listPrice;

    /// @notice a boolean to indicate if the vault has closed
    bool public vaultClosed;

    /// @notice the number of ownership tokens voting on the reserve price at any given time
    uint256 public votingTokens;

    /// @notice price of eth per ERC20 token 
    uint256 public pricePerToken;

    /// @notice maxTotalSupp of ERC20 token
    uint256 public maxTotalSupply;

    /// ------------------------
    /// -------- EVENTS --------
    /// ------------------------

    /// @notice An event emitted when someone redeems all tokens for the NFT
    event Redeem(address indexed redeemer);

    /// @notice An event emitted when someone cashes in ERC20 tokens for ETH from an ERC721 token sale
    event Cash(address indexed owner, uint256 shares);

    constructor(address _settings) {
        settings = _settings;
    }

    function initialize(address _curator, address _token, uint256 _id, uint256 _supply, uint256 _listPrice, uint256 _fee, string memory _name, string memory _symbol) external initializer {
        // initialize inherited contracts
        __ERC721Holder_init(_name, _symbol );
        // set storage variables
        token = _token;
        id = _id;


        _mint(_curator, 1);


    }

    /// --------------------------------
    /// -------- VIEW FUNCTIONS --------
    /// --------------------------------

    

    /// -------------------------------
    /// -------- GOV FUNCTIONS --------
    /// -------------------------------

   

    /// -----------------------------------
    /// -------- CURATOR FUNCTIONS --------
    /// -----------------------------------

   

    /// --------------------------------
    /// -------- CORE FUNCTIONS --------
    /// --------------------------------


    /// @notice retieve contents of Vault to recipent address
    function retrive(address _recipenent) external onlyOwner {


        // transfer erc721 to recipent
        IERC721(token).transferFrom(address(this), _recipenent, id);

        auctionState = State.ended;

        emit NFTSent(winning, livePrice);
    }


}
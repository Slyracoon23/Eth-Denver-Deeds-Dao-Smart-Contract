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

contract TokenVault is ERC20Upgradeable, ERC721HolderUpgradeable, Ownable {
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
        __ERC20_init(_name, _symbol);
        __ERC721Holder_init();
        // set storage variables
        token = _token;
        id = _id;

        listPrice = _listPrice;
        pricePerToken = _pricePerToken;
        maxTotalSupply = _maxTotalSupply;

        _mint(_curator, _supply);


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

    function buy(uint256 _ammount) public payable {
            require(msg.vaule == _ammount * tokenPrice, "Need to send exact amount of wei");

             /*
            * sends the requested amount of tokens
            * from this contract address
            * to the buyer
            */
            transfer(msg.sender, _ammount);
           

        }


    /// @notice an external function to burn ERC20 tokens to receive ETH from ERC721 token purchase
    function sellToken(uint256 _amount) external {
        require(PropertyFinished == State.ended, "cash:vault not closed yet");
        uint256 bal = balanceOf(msg.sender);
        require(bal > 0, "cash:no tokens to cash out");

        // decrement the token balance of the seller
        balances[msg.sender] -= _amount;
        
        // increment the token balance of this contract
        balances[address(this)] += _amount;


        emit Transfer(msg.sender, address(this), _amount);

        
        // e.g. the user is selling 100 tokens, send them 500 wei
        payable(msg.sender).transfer(amount * tokenPrice);

    }

    /// @notice send NFT to recipent address
    function sendVaultNFT(address _recipenent) external onlyOwner {
        require(auctionState == State.ended, "end:vault has already closed");
        require(block.timestamp >= auctionEnd, "end:auction live");


        // transfer erc721 to recipent
        IERC721(token).transferFrom(address(this), _recipenent, id);

        auctionState = State.ended;

        emit NFTSent(winning, livePrice);
    }


}
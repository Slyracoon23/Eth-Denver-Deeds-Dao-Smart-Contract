//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Interfaces/IWETH.sol";
import "./Interfaces/IERC721.sol";
import "./OpenZeppelin/math/Math.sol";
import "./OpenZeppelin/token/ERC20/ERC20.sol";
import "./OpenZeppelin/token/ERC721/ERC721.sol";
import "./OpenZeppelin/token/ERC721/ERC721Holder.sol";
import "./OpenZeppelin/access/Ownable.sol";


import "./Settings.sol";

import "./OpenZeppelin/upgradeable/token/ERC721/utils/ERC721HolderUpgradeable.sol";
import "./OpenZeppelin/upgradeable/token/ERC20/ERC20Upgradeable.sol";

contract TokenVault is ERC721HolderUpgradeable {
    using Address for address;

    /// -----------------------------------
    /// -------- BASIC INFORMATION --------
    /// -----------------------------------

    /// -----------------------------------
    /// -------- TOKEN INFORMATION --------
    /// -----------------------------------

    /// @notice the governance contract which gets paid in ETH
    address public immutable settings;

    /// @notice the ERC721 token address of the vault's token
    address public token;

    /// @notice the ERC721 token ID of the vault's token
    uint256 public id;


    /// -----------------------------------
    /// -------- VAULT INFORMATION --------
    /// -----------------------------------

    /// @notice a boolean to indicate if the vault has closed
    bool public vaultClosed;

    /// ------------------------
    /// -------- EVENTS --------
    /// ------------------------

    /// @notice An event emitted when someone redeems from the  NFT vault
    event Redeem(address indexed redeemer);

 
    constructor(address _settings) ERC721() {
        settings = _settings;
    }

    function initialize(address _curator, address _token, uint256 _id, uint256 _supply, uint256 _listPrice, uint256 _fee, string memory _name, string memory _symbol) external initializer {
        // initialize inherited contracts
        __ERC721Holder_init(_name, _symbol );
        // set storage variables
        token = _token;
        id = _id;

        vaultClosed = false;


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
    function Redeem() external  {
        require(vaultClosed == false, "Redeem: Vault is closed");
        require(ownerOf(1) == msg.sender, "Redeem: sender is not owner of NFT vault");


        // transfer erc721 to recipent
        IERC721(token).transferFrom(address(this), msg.sender, id);

        vaultClosed = true;



        emit Redeem(msg.sender);
    }


}
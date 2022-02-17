pragma solidity ^0.8.0;

import "./OpenZeppelin/token/ERC721/ERC721.sol";

contract SimpleERC721 is ERC721 {

  constructor() ERC721("Test-NFT","t-nft") {

  }

  function mint(address _to, uint256 _id) external {
    _mint(_to, _id);
  }

}
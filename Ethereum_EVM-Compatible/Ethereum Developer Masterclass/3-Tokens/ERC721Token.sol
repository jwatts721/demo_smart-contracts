// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

contract ERC721Token {
    // ERC20 compabible functions
    function name() public view returns (string memory) {}
    function symbol() public view returns (string memory) {}
    function totalSupply() public view returns (uint256) {} 
    function balanceOf(address _owner) public view returns (uint256 balance) {}

    // ERC721 non-fungible functions, defines ownership
    function ownerOf(uint256 _tokenId) public view returns (address owner){}
    function approve(address _to, uint256 _tokenId) public {}
    function takeOwnership(uint256 _tokenId) public {}
    function transfer(address _to, uint256 _tokenId) public {}
    function tokenOfOwnerByIndex(address _owner, uint256 _index) public view returns (uint256 tokenId) {}

    // Token metadata
    function tokenMetadata(uint256 _tokenId) public view returns (string memory infoUrl) {}

    // Events
    event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
}
pragma solidity 0.8.18;

interface ERC721Metadata{
    function name() external view returns(string memory _name);
    function symbol() external view returns(string memory _symbol);
    function tokenURI(uint _tokenID) external view returns(string memory);
}
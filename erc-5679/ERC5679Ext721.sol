// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.18;

import "./IERC5679.sol";
import "../erc-721/erc721_2.sol";

contract ERC5679 is ERC721{
    //For ERC 20
    function safeMint(address _to, uint256 _id, bytes calldata ) external {
        _mintTokenId(_to, _amount);
    }

    function burn(address _from, uint256 _id, bytes calldata ) external{
        _burnTokenId(_from, _amount);
    }
}
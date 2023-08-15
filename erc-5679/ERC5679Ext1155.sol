// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "./IERC5679.sol";
import "../erc-1155/erc_1155.sol";

contract ERC5679Ext1155 is ERC1155{
    function safeMint(address _to, uint256 _id, uint256 _amount, bytes calldata ) external {
        _mint(_to, _id, _amount);
    }

    function safeMintBatch(address to, uint256[] calldata ids, uint256[] calldata amounts, bytes calldata ) external {
        _mintBacth(_to, _id, _amount);
    }

    function burn(address _from, uint256 _id, uint256 _amount, bytes[] calldata ) external {
        _burn(_from, _id, _amount);
    }

    function burnBatch(address _from, uint256[] calldata ids, uint256[] calldata amounts, bytes calldata) external {
        _burnBacth(_from, _id, _amount);
    }
}
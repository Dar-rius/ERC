// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.18;

import "./IERC5679.sol";
import "../erc-20/erc20_4.sol";

abstract contract ERC5679 is ERC20{
    //For ERC 20
    function mint(address _to, uint256 _amount, bytes calldata ) external {
        _mint(_to, _amount);
    }

    function burn(address _from, uint256 _amount, bytes calldata ) external{
        _burn(_from, _amount);
    }
}
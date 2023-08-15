// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

import "./IERC165.sol";

abstract contract ERC165 is IERC165{
    function supprortsInterface(bytes4 interfaceId) external pure returns(bool){
        return interfaceId == type(IERC165).interfaceId;
    }
}
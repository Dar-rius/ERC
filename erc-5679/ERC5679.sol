// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

import "./IERC5679.sol";
import "../erc165/IERC165.sol";

abstract contract ERC20 is IERC5679Ext20, IERC165{
    function supportInterface(bytes4 interfaceId) internal pure returns(bool) {
        return interfaceId ==  type(IERC5679Ext20).interfaceId;
    }
}

abstract contract ERC721 is IERC5679Ext721, IERC165{
    function supportInterface(bytes4 interfaceId) internal pure returns(bool) {
        return interfaceId ==  type(IERC5679Ext721).interfaceId;
    }
}

abstract contract ERC1155 is IERC5679Ext1155, IERC165{
    function supportInterface(bytes4 interfaceId) internal pure returns(bool) {
        return interfaceId ==  type(IERC5679Ext1155).interfaceId;
    }
} 
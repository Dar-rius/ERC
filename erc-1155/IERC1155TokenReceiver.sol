// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

interface ERC1155TokenReceiver{
    function onERC1155Receiver(address _operator, address _from, uint256 _id, uint256 _value, bytes memory _data) external returns(bytes4);
    function onERC1155BatchReceiver(address _operator, address _from, uint256[] calldata _ids, uint256[] calldata _values, bytes calldata _data) external returns(bytes4);
}
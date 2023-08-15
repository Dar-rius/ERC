    // SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

import "./IERC1155TokenReceiver.sol";
import "./common.sol";

contract ERC1155MockReceiver is ERC1155TokenReceiver, CommonConstant{
    bool shoulSend;

    address _lastOperator;
    address _lastFrom;
    address _lastTo;
    uint256 _lastId;
    uint256 _lastValue;
    bytes _lastData;

    function autoirizationSend(bool _value) external {
        shoulSend = _value;
    }

    function onERC1155Receiver(address _operator, address _from, uint256 _id, uint256 _value, bytes calldata _data) external returns(bytes4){
        _lastOperator = _operator;
        _lastFrom = _from;
        _lastId = _id;
        _lastValue = _value;
        _lastData = _data;   
        if (shoulSend != true){
            revert("ERC1155Receiver: Impossible de faire le transport");
        } else{
            return ERC1155_ACCEPTED;
        }
    }

    function onERC1155BatchReceiver(address _operator, address _from, uint256[] calldata _ids, uint256[] calldata _values, bytes calldata _data) external returns(bytes4){
        _lastOperator = _operator;
        _lastFrom = _from;
        _lastId = _ids[0];
        _lastValue = _values[0];
        _lastData = _data;
        if (shoulSend != true){
            revert("ERC1155BatchReceiver: Impossible de faire le transport");
        } else{
            return ERC1155_BATCH_ACCEPTED;
        }
    }
}
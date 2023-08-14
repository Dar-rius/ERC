// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

import {Address} from './Address.sol';
import './IERC1155TokenReceiver.sol';
import './common.sol';


contract ERC1155 is CommonConstant{
    using Address for address;

    //Les varibales
    mapping (uint256 => mapping(address => uint256)) balance;
    mapping (address => mapping(address => bool)) approved;

    event TransferSingle(address indexed _operator, address indexed _from, address indexed _to, uint256  _id, uint _values);
    event TransferBacth(address indexed _operator, address indexed _from, address indexed _to, uint256[] _ids, uint256[] _values);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool approved);

    function supportInterface(bytes4 interfaceId) external pure returns(bool) { 
        if(interfaceId == InterfaceSignatureERC165 ||
            interfaceId == InterfaceSignatureERC1155){
                return true;
            }
        return false;
    }
    
    function _mint(uint256 _id, uint256 _value, address _winner) external{
        balance[_id][_winner] += _value;
    }

    function safeTransfertFrom(address _from, address _to, uint256 _id, uint256 _value, bytes calldata _data) external {
        require(_from != msg.sender && approved[_from][msg.sender], "Adresse non approuve");
        require(_to != address(0x0), "Pas bon");

        balance[_id][_from] -= _value;
        balance[_id][_to] += _value;
        emit TransferSingle(msg.sender, _from, _to, _id, _value);
        
        if (_to.isContract()){
            _acceptReceiver(msg.sender, _from, _to, _id, _value, _data);
        }
    }

    function safeTransferBatchFrom(address _from, address _to, uint256[] calldata _ids, uint256[] calldata _values, bytes calldata _data) external{
        require(_from !=msg.sender && approved[_from][msg.sender]);
        require(_to != address(0x0));
        require(_ids.length == _values.length);
        
        for (uint256 i = 0; i <_ids.length; i++){
            balance[_ids[i]][_from] -= _values[i];
            balance[_ids[i]][_to] += _values[i];
        }

        emit TransferBacth(msg.sender, _from, _to, _ids, _values);
        
        if (_to.isContract()){
            _acceptBatchReceiver(msg.sender, _from, _to, _ids, _values, _data);
        }
    }

    function balanceOf(address _owner, uint256 _id) external view returns(uint256){
        require(_owner != address(0));
        return balance[_id][_owner];
    }

    function balanceBatchOf(address[] calldata _owner, uint256[] calldata _ids) external view returns(uint256[] memory){
        uint256[] memory balances = new uint256[](_ids.length);
        for (uint256 i = 0; i < _ids.length; i++){
            balances[i] = balance[_ids[i]][_owner[i]];
        }
        return balances;
    }

    function  setApprovalForAll(address _operator, bool _approved) external{
        require(_operator != address(0) || msg.sender != _operator);
        
        approved[msg.sender][_operator] = _approved;
    }

    function isApprovalForAll(address _owner, address _operator) external view returns(bool) {
        require(approved[_owner][_operator], 'Il est pas autorise');
        
        return approved[_owner][_operator];
    }
    

    function _acceptReceiver(address _operator, address _from, address _to, uint256 _id, uint256 _value, bytes calldata _data) internal{
        require(ERC1155TokenReceiver(_to).onERC1155Receiver(_operator, _from, _id, _value, _data) == ERC1155_ACCEPTED, "Error receiver don't accpeted");
    }

    function _acceptBatchReceiver(address _operator, address _from, address _to, uint256[] calldata _ids, uint256[] calldata _values, bytes calldata _data) internal{
        require(ERC1155TokenReceiver(_to).onERC1155BatchReceiver(_operator, _from, _ids, _values, _data) == ERC1155_BATCH_ACCEPTED, "Error receiver don't accpeted"); 
    }
}
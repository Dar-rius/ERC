// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.18;

contract ERC721{
    // Declaration des variables
    uint256 totalSupply;
    string name;
    string symbol;

    mapping(uint256 => address) private owner;
    mapping (address => uint256) private balance;
    mapping (uint256 => address) private totalApprovals;
    mapping (address => mapping(address => bool)) private operatorApproval;
    
    //Les evenements
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenID);
    event Approval(address indexed _owner, address indexed _spender, uint256 indexed _tokenID);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
    
    function totalSupplies() external view returns(uint){
        return totalSupply;
    }

    function balanceOf(address account) external view returns(uint256){
        require(account != address(0));
        return balance[account];
    }

    function ownerOf(uint256 _tokenID) external view returns(address){
        require(_tokenExist(_tokenID));
        return owner[_tokenID];
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenID) external payable {
        require(_from != address(0));
        require(_to != address(0));
        require(_tokenExist(_tokenID));
        require(owner[_tokenID] == _from);
        
        delete owner[_tokenID];
        balance[_from] -= 1;
        balance[_to] += 1;
        owner[_tokenID] = _to;
        emit Transfer(_from, _to, _tokenID);
    }
    
    function safeTransferFrom(address _from, address _to, uint256 _tokenID, bytes memory data) external payable {
        require(_from != address(0));
        require(_to != address(0));
        require(_tokenExist(_tokenID));
        require(owner[_tokenID] == _from);
        
        delete owner[_tokenID];
        balance[_from] -= 1;
        balance[_to] += 1;
        owner[_tokenID] = _to;
        emit Transfer(_from, _to, _tokenID);
    }

    function transferFrom(address _from, address _to, uint256 _tokenID) external payable {
        require(_from != address(0));
        require(_to != address(0));
        require(_tokenExist(_tokenID));
        require(owner[_tokenID] == _from);
        
        delete owner[_tokenID];
        balance[_from] -= 1;
        balance[_to] += 1;
        owner[_tokenID] = _to;
        emit Transfer(_from, _to, _tokenID);
    }

    function approve(uint256 _tokenID, address _approved) external{
        require(_tokenExist(_tokenID));
        require(_ownerExist(_tokenID, msg.sender, _approved));

        totalApprovals[_tokenID] == _approved;
        emit Approval(msg.sender, _approved, _tokenID);
    }

    function setApprovalForAll(address _operator, bool _approved) external {
        require(_operator != address(0));
        require(msg.sender != address(0));

        operatorApproval[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    function isApprovalForAll(address _owner, address _approval) external view returns(bool) {
        require(_owner != address(0));
        require(_approval != address(0));
        require(operatorApproval[_owner][_approval]);
        
        return operatorApproval[_owner][_approval];
    }

    function getApprovalForAll(uint256 _tokenID) external view returns(address){
        require(_tokenExist(_tokenID));
        require(totalApprovals[_tokenID] != address(0));

        return totalApprovals[_tokenID];
    }

    // Les permissions pour les droits
    function _tokenExist(uint256 _tokenID) internal view returns(bool success){
        if (owner[_tokenID] != address(0)){
            return success= true;
        }
    }
    
    function _ownerExist(uint _tokenID, address _owner, address _approved) internal view returns(bool success){
       if (_owner != address(0) && _owner != _approved){
            if(_approved!= address(0)){
                if (owner[_tokenID] == _owner && totalApprovals[_tokenID] != _approved){
                    return success = true;
                }else{
                    return success = false;
                }
            }else{
                return success = false;
            }
       }else{
            return success = false;
            } 
    }
}


// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

/*
    The code below is used to develop a smart contract based on the ERC-20 protocol, enabling token transactions to be carried out on the ethereum blockchain.
    on the ethereum blockchain.
    
    This smart contract is a simple ERC-20 contract, but includes token destruction features.
*/

contract ERC20{
    // Declaration of variables containing data on the number of tokens issued, the amount of withdrawals between the owner
    // and the depositor, and the total balance of tokens held by an address.
    uint256 private totalSupply;
    mapping (address => mapping(address => uint256)) private allowed;
    mapping (address => uint) private balance;

    // The following events are generated when a token transaction or a token withdrawal at the owner is carried out
    event Transfer(address indexed _from, address indexed _to, uint256 amout);
    event Approval(address indexed _owner, address indexed _spender, uint256 amount);

    // The following function allows you to check the current balance of an address
    function balanceOf(address account) public view returns(uint256){
        return balance[account];
    }

    // The function below checks the total number of tokens created
    function totalSupplies() public view returns(uint256){
        return totalSupply;
    }
 
    // The function below allows you to perform a transaction to an address of your choice
    function transfer(address _to, uint256 _amount) public returns(bool){
        require(_amount <= balance[msg.sender]);
        require(_to != address(0));
        balance[msg.sender] -= _amount;
        balance[_to] += _amount;
        emit Transfer(msg.sender, _to, _amount);
        return true;
    }
 
    // The function below allows you to carry out a transaction while also keeping the sender's address.
    function transferFrom(address _from, address _to, uint256 _amount) public returns (bool){
        require(_from != address(0));
        require(balance[_from] >= _amount);
        require(_to != address(0));
        balance[_from] -= _amount;
        balance[_to] += _amount;
        emit Transfer(_from, _to, _amount);
        return true;
    }

    // The following function allows you to check the withdrawal amount based on the owner's address and the spender.
    function allowance(address owner, address _spender) public view returns(uint256){
        return allowed[owner][_spender];
    }

   // The function below allows the spender to make a withdrawal on the owner's address
    function approve(address _spender, uint amount) public returns(bool){
        require( _spender != address(0));
        require(balance[msg.sender] >= amount);
        balance[msg.sender] -= amount;
        allowed[msg.sender][_spender] += amount;
        emit Approval(msg.sender, _spender, amount);
        return true;
    }

    // The function below allows you to create new tokens and send them to the owner.
    function _mint(address owner, uint256 amount) public returns(bool){
        require(owner != address(0));
        totalSupply += amount;
        balance[owner] += amount;
        emit Transfer(address(0), owner, amount);
        return true;
    }
    
    // The function below destroys tokens by transferring
    function _burn(address account, uint256 value) internal{
        require(account != address(0));
        balance[account] -= value;
        totalSupply -= value;
        emit Transfer(account, address(0), value);
    }
    
    // The function below destroys tokens by transferring
    function _burnFrom(address account, uint value) internal{
        require(account != address(0));
        allowed[account][msg.sender] -= value ;
        _burn(account, value);
    }
}
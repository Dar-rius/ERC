// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.18;

/*
    The code below is used to develop a smart contract based on the ERC-20 protocol, enabling token transactions to be carried out on the ethereum blockchain.
    on the ethereum blockchain.

    This contract includes the addition and reduction of the withdrawal amount by the owner.
*/

contract ERC20{
    // Declaration of variables containing data on the number of tokens issued, the amount of withdrawals between the owner
    // and the depositor, and the total balance of tokens held by an address.
    uint256 private totalSupply;
    mapping (address => mapping(address => uint)) private allowed;
    mapping(address => uint) private balance;
    
    // The following events are generated when a token transaction or a token withdrawal at the owner is carried out
    event Transfer(address indexed _from, address indexed _to, uint256 _amount);
    event Approval(address indexed _owner , address indexed  _spender, uint amount);
    
    // The following function allows you to check the current balance of an address
    function balanceOf(address account) public view returns(uint256){
        return balance[account];
    }

    // The function below checks the total number of tokens created
    function totalSupplies() public view returns(uint256){
        return totalSupply;
    }

    // The following function allows you to check the withdrawal amount based on the owner's address and the spender.
    function allowance(address _owner, address _spender) public view returns(uint256){
        return allowed[_owner][_spender];
    }

    // The function below allows you to perform a transaction to an address of your choice
    function transfer(address _to,  uint _amount) public returns(bool) {
        require(_to != address(0));
        require(_amount <= balance[msg.sender]);
        balance[msg.sender] -= _amount;
        balance[_to] += _amount;
        emit Transfer(msg.sender, _to, _amount);
        return true;
    }

    // The function below allows you to carry out a transaction while also keeping the sender's address.
    function transferFrom(address _from, address _to, uint256 _amount) public returns(bool){
        require(_to != address(0));
        require(_amount <= balance[_from]);
        balance[_from] -= _amount;
        balance[_to] += _amount;
        emit Transfer(_from, _to, _amount);
        return true;
    }

   // The function below allows the spender to make a withdrawal on the owner's address
    function approve(address _spender, uint256 amount) public returns(bool){
        require(_spender != address(0));
        require(amount <= balance[msg.sender]);
        balance[msg.sender] -= amount;
        allowed[msg.sender][_spender] += amount;
        emit Approval(msg.sender, _spender, amount);
        return true;
    }
    
    //This function allows the owner to send money to the spender
    function increaseAllowance(address _spender, uint256 value) public returns(bool){
        require(value <= balance[msg.sender]);
        require(_spender != address(0));
        balance[msg.sender] -= value;
        allowed[msg.sender][_spender] += value;
        emit Approval(msg.sender, _spender, value);
        return true;
    }

    //This function allows the owner to withdraw certain sums of money from the spender.
    function decreaseAllowance(address _spender, uint256 value) public returns(bool){
        require(value <= balance[msg.sender]);
        require(_spender != address(0));
        allowed[msg.sender][_spender] -= value;
        balance[msg.sender] += value;
        emit Approval(msg.sender, _spender, value);
        return true;
    }

    // The function below allows you to create new tokens and send them to the owner.
    function _mint(uint256 amount) internal {
        totalSupply+= amount;
        balance[msg.sender] += amount;
        emit Transfer(address(0), msg.sender, amount);
    }
}
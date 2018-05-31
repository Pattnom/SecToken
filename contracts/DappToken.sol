pragma solidity ^0.4.2;

contract DappToken {
	// Name
	string public name = "DApp Token";
	// Symbol
	string public symbol = "DAPP";
	// Standard
	string public standard = "DApp Token v1.0";
	// Contructor
	// Set the total number of tokens
	// Read the total number of tokens
	uint256 public totalSupply;

	event Transfer(
		address indexed _from,
		address indexed _to,
		uint256 _value
	);

	// approve
	event Approval(
		address indexed _owner,
		address indexed _spender,
		uint256 _value
	);

	mapping(address => uint256) public balanceOf;
	// allowance
	mapping(address => mapping(address => uint256)) public allowance;
	

	function DappToken (uint256 _initialSupply) public {
		balanceOf[msg.sender] = _initialSupply;
		totalSupply = _initialSupply;
		// allocate the initial supply
	}

	// Transfert
	function transfer(address _to, uint256 _value)	public returns (bool success) {
		// Exception if the account doesn't have enough
		require(balanceOf[msg.sender] >= _value);
		// 
		balanceOf[msg.sender] -= _value;
		balanceOf[_to] += _value;
		// Transfer Event
		Transfer(msg.sender, _to, _value);
		// Return boolean
		return true;
	}
	
	// Approve
	function approve(address _spender, uint256 _value) public returns (bool success){
		// allowance
		allowance[msg.sender][_spender] = _value;

		// approve event
		Approval(msg.sender, _spender, _value);

		return true;
	}

	// TransferFrom
	function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){

		// Require _from has enough tokens
		require(_value <= balanceOf[_from]);
		// Require allowance is big enough
		require(_value <= allowance[_from][msg.sender]);
		// Change the balance
		balanceOf[_from] -= _value;
		balanceOf[_to] += _value;
		// Update the allowance
		allowance[_from][msg.sender] -= _value;
		
		// Transfer event
		Transfer(_from, _to, _value);
		// return a boolean
		return true;
	}
}
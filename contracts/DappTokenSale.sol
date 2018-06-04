pragma solidity ^0.4.2;

import "./DappToken.sol";

contract DappTokenSale {
	address admin;
	DappToken public tokenContract;
	uint256 public tokenPrice;
	uint256 public tokensSold;

	event Sell(address _buyer, uint256 _amount);
	
	function DappTokenSale(DappToken _tokenContract, uint256 _tokenPrice) public {
		// Assign an admin with privileges
		admin = msg.sender;
		// Token Contract
		tokenContract = _tokenContract;
		// Token Price
		tokenPrice = _tokenPrice;
	}

	// multiply
	function multiply(uint x, uint y) internal pure returns (uint z){
		require(y == 0 || (z = x * y) / y == x);
	}

	// Buy tokens
	function buyTokens(uint256 _numberOfTokens) public payable {
		// Require that value is equal to tokens
		require(msg.value == multiply(_numberOfTokens, tokenPrice));
		// Require that the contract has enough tokens
		require(tokenContract.balanceOf(this) >= _numberOfTokens);
		// Require That a transfer is successful
		require(tokenContract.transfer(msg.sender, _numberOfTokens));
		// Keep track of number of tokens sold
		tokensSold += _numberOfTokens;
		// Trigger Sell Event
		Sell(msg.sender, _numberOfTokens);
	}

	// Ending Token DappTokenSale
	function endSale() public {
		// Require admin
		require(msg.sender == admin);
		// Transfer remaining dapp tokens to admin
		require(tokenContract.transfer(admin, tokenContract.balanceOf(this)));
		// Destroy contract
		selfdestruct(admin);
	}
}
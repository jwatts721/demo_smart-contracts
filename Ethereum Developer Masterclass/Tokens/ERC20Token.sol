// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

contract ERC20Token {
    // Variables
    string public name;
    string public symbol; // usually 3-4 characters
    uint8 public decimals; // maximum is 18 decimals
    uint256 public supply;

    mapping(address => uint) public balances;
    // double mapping concept
    mapping(address => mapping(address => uint)) public approvals;

    // Events
    event Transfer(address _sender, address _receiver, uint256 _tokens);
    event Approval(address sender, address delegate, uint256 tokens);

    // Constructor
    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _supply) {
        require(_supply <= 1000000000, "Maximum supply can only be a billion tokens");
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        supply = _supply;
        balances[msg.sender] = _supply; // The total supply of tokens initially belongs to the owner
    }

    // Modifiers
    modifier balanceCheck(address _owner, uint256 _tokens) {
        require(balances[_owner] >= _tokens, "There are not enough tokens to transfer");
        _;
    }

    modifier noSelfAddress(address _address) {
        require(msg.sender != _address, "The sender and receiver cannot be the same");
        _;
    }

    // Functions
    function totalSupply() public view returns (uint256) {
        return supply;
    }

    function balanceOf(address _tokenOwner) public view returns (uint256) {
        return balances[_tokenOwner];
    }

    function transfer(address _receiver, uint256 _tokens) noSelfAddress(_receiver) public returns (bool) {
        require(balances[msg.sender] >= _tokens, "There are not enough tokens to transfer");
        balances[msg.sender] -= _tokens;
        balances[_receiver] += _tokens;
        emit Transfer(msg.sender, _receiver, _tokens);
        return true;
    }

    function approve(address _delegate, uint256 _tokens) public returns (bool) {
        require(msg.sender != _delegate, "Cannot self delegate");
        approvals[msg.sender][_delegate] = _tokens; 
        emit Approval(msg.sender, _delegate, _tokens);       
        return true;
    }

    /**
    * How many tokens has the owner approved the delegate
    */
    function allowance(address _tokenOwner, address _delegate) public view returns (uint256) {
        return approvals[_tokenOwner][_delegate];
    }
    
    /**
    * The delegate transfers tokens from the token owner to someone else
    */
    function transferFrom(address _tokenOwner, address _receiver, uint256 _tokens) noSelfAddress(_receiver) public returns (bool) {
        require(balances[_tokenOwner] >= _tokens, "There are not enough tokens to transfer");
        require(approvals[_tokenOwner][msg.sender] >= _tokens, "The delegate is not approved to transfer this amount of tokens");
        balances[_tokenOwner] -= _tokens;
        balances[_receiver] += _tokens;
        approvals[_tokenOwner][msg.sender] -= _tokens;
        emit Transfer(_tokenOwner, _receiver, _tokens);
        return true;
    }
}

// SPDX-License-Identifier: MIT//
pragma solidity 0.6.12;

contract Lottery {
    address public manager;
    address payable investor;
    //struct Player {
    //    address payable investor;
    //    uint amount;
    //}
    address payable[] players;
    //Player[] public players;

    // Constuctor - set the manager (the owner, which cannot be changed)
    constructor() public {
        manager = msg.sender;
    }

    modifier onlyManager() {
        require(msg.sender == manager, "Only the manager can call this function");
        _;
    }

    // Define events
    event playerInvested(address player, uint amount);
    event winnerSelected(address winner, uint amount);

    // Invest money by players - anyone in the world
    /*
        Requirements:
            - Manager cannot invest
            - Minimum investment = 0.1 ether = exactly invest 3 ether
            - Emit an event to the front-end whenever someone invests
    */
    function invest() public payable {
        require(msg.sender != manager, "Manager cannot invest");
        require(msg.value >=0.1 ether, "The minimum investment amount is 0.1 ether");
        // Keep track of those who invested
        //Player memory newPlayer;
        //newPlayer.investor = msg.sender;
        //newPlayer.amount = msg.value;
        //players.push(newPlayer);
        players.push(msg.sender);
        emit playerInvested(msg.sender, msg.value);
    }

    // Get Balance - current balance
    /*
        Requirements:
            - Only the manager can see the balance
    */
    function balance() public view onlyManager returns(uint) {
        return address(this).balance;
    }

    // Manager clicks a function, it should select the winner
    /*
        Requirements:
            - Only the manager can select the winner
            - Emit an event to the front-end to show who won
    */
    function selectWinner() public onlyManager {   
        uint r = random();
            
        // modulo it with the number of players
        uint index = r % players.length;

        // map the remainder to an index in the array (select the winner)
        //address payable winner = players[index].investor;
        address payable winner = players[index];

        emit winnerSelected(winner, address(this).balance);
        
        // send the total money in the contract to the player (transfer)
        winner.transfer(address(this).balance);

        // make the array empty (this contract can be reused for new lottery)
        //players = new Player[](0);
        players = new address payable[](0);
    }

    /*
        <<< DO NOT USE IN PRODUCTION >>>
        Since there is no way to generate random numbers in the Solidity language, 
        this next few lines of code is a psuedo random number genrator.
        Consider using ORACLES or other external means of generating random numbers
        to then pass into your Solidity function call. 
    */
    function random() private view returns(uint) {
        // first take some global variables, encode it, hash it, convert to uint
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, players.length)));
    }    
}
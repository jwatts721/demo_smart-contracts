An Oracle is an interface between the blockchain and the real world. 
    A.K.A. 
        Off-chain data sources that are available to the blockchain for smart contracts.

    Basically, this is a way of reading external data into a Smart Contract. 

Example: 
    A smart contract is created for betting between teams that win. 
    An Oracle is the interface that connects the real world to the blockchain where the Smart Contract exists. 

Analogy: 
    The Oracle in The Matrix was the connection between the virtual world and the real world. 
    She knew about everything in the virtual world and the real world. 

Concepts: 
    Provable allows you to run queries to remote data. 

        i.e.
            emit LogNewProvableQuery("Provable query was sent, standing by for the answer...");
            provable_query(60, "URL", "json(https://api.kraken.com/0/public/Ticker?pair=ETHXBT).result.XETHXXBT.c.0");


Reference: 
    https://ethereum.org/en/developers/docs/oracles/
    https://github.com/provable-things

    
Source Example:
    https://provable.xyz
    

Other Examples:
* Chainlink - https://chain.link/education/blockchain-oracles


IMPORTANT NOTE: 
    - This functionality can only be done on a Test or Live network so that 
      the contract can talk to the external resources / APIs.
        This includes test networks and networks through an Injected Provider such as MetaMask

    - You must have some ETH in order to perform these transactions.
        - For test networks, you can get ETH from a faucet. 
            
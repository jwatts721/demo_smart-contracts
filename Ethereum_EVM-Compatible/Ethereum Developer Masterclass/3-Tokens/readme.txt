Token Standards:
*** ERC20 and ERC721 are the most popular token standards ***

--------------------------------------------------------------
ERC20 
--------------------------------------------------------------
    - ERC = Ethereum Request for Comments
        - Whenever you want to set a standard, you create an E.I.P. (Ethereum Improvement Proposal).
            - Proposal is negotiated on
            - If approved, becomes an ERC standard

        20 = The number at which the EIP was introduced
            Ex: ERC20, ERC721

    - ERC20 - standard for creating fungible tokens
        https://docs.openzeppelin.com/contracts/2.x/api/token/erc20
        - Fungible - any token can be exchange for other tokens or assets. 
                   - the value of every token is the same 
        - Non-Fungible - any asset where the value is unique to that asset.

        - Definitions of general functions, etc
            - These are defined standards within ERC20 and other ERC protocols (EVM compatible protocols)
                Example Functions:
                    - transfer()
                    - send()
            - When you follow all of the predefined rules, it can become an ERC20 token. 
            - You can define rules that belong to different protocols, ex, ERC721
            - You can define new rules, that derive from ERC20. This may become a different token for a different protocol/blockchain.

            - When you create tokens, you can create any number of tokens you want, depends on the use case

    Functions:
      Note: This is not an exhaustive list. These are the functions that you should implement at minimum. 
        - tokenSupply() returns (uint256)                          - the total number of tokens that you have
        - balanceOf(address tokenOwner) returns (uint)             - how many tokens does any given address have
        - tranfer(address receiver, uint numTokens) returns (bool) - transfers from your account to another address
        - approve(address delegate, uint numTokens) returns (bool) - approves another address the ability to execute functions, gives allowance to delegate address
                                                                      ie: This can be an approval of Binance to access the account to allow purchasing of tokens which can be transferred.
                                                                            This gives flexibility for the seller to not have to be involved in every transaction.
                                                                        Delegates authority to send tokens without the approval of the owner per transaction.
                                                                        Authority is delegated to Binance to transfer tokens on your behalf.
        - allowance(address owner, address delegate) returns (uint) - How much the owner delegated/approved to the delegate (ie: Binance)
        - transferFrom (address owner, address buyer, uint numTokens) returns (bool) - Used by exchanges to send money from owner to buyer

--------------------------------------------------------------
ERC721
--------------------------------------------------------------
    - Differences between ERC20 and ERC721
        - ERC20 - tokens are fungible, not unique in value, like FIAT currency
        - ERC721 - tokens are non-fungible, unique in value, for NFTs
    
    Example: CryptoKitties

    - ERC20 compatible functions exist in this token protocol

--------------------------------------------------------------
Open Zeppelin
--------------------------------------------------------------
https://openzeppelin.com
https://github.com/OpenZeppelin
https://github.com/OpenZeppelin/openzeppelin-contracts

* Defines a standard library for secure smart contracts

In RemixIDE, you can use the OpenZeppelin libraries (any any other libraries) as a direct import. 
When using Visual Studio Code, you have to download the full GIT repository to perform the import.

Imports can be performed using the following methods:

    import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/Math.sol";

Using this method, it will import and read all dependendies remotely. 
This likely only works in RemixIDE. 


    import "@openzeppelin/contracts/utils/math/SafeMath.sol";

Using this method, all dependendies will be pulled down locally and stored in a directory named ".deps".
It pulls the dependendies from GitHub and NPM where relevant. 



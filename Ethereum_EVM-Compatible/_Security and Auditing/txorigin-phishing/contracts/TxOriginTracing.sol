// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/Strings.sol";

/*
- Demo of the contract call chain
*/
abstract contract BaseContract {
    event contractCall(string _message);

    function emitInfo(string memory _contractName) internal {
        emit contractCall(
            string.concat(
                _contractName,
                " - Msg.Sender: ",
                Strings.toHexString(msg.sender),
                " - Tx.Origin: ",
                Strings.toHexString(tx.origin)
            )
        );
    }
}

contract B is BaseContract {
    function showCallInfo() external {
        emitInfo("Contract B");
    }
}

contract A is BaseContract {
    function callContractB(address _contractB) external {
        emitInfo("Contract A");
        B contractB = B(_contractB);
        contractB.showCallInfo();
    }
}

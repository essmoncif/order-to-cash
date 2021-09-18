// SPDX-License-Identifier: GPL-3.0
pragma experimental ABIEncoderV2;
pragma solidity ^0.6.1;

import './CommandeLib.sol';

contract Commande {
    
    
    CommandeLib.CM public cm;
    
    constructor(address client, address supplier, address product, uint unity) public {
        cm = CommandeLib.CM(client, supplier, product, unity, block.timestamp);
    }
    
    function getAddress() public view returns(address){
        return address(this);
    }
    
    function getCM() public view returns(CommandeLib.CM memory){
        return cm;
    }
    
}
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.1;


library CommandeLib {
    
    struct CM{
        address client;
        address supplier;
        address product;
        uint unity;
        uint date_creation;
    }
}
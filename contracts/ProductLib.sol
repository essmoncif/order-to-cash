pragma solidity ^0.6.1;

library Product {
    
    struct Pr {
        string product_name;
        string product_category;
        uint256 price;
        uint date_creation;
        address owner;
    }
    
}
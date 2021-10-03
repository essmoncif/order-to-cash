// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.1;
pragma experimental ABIEncoderV2;
import './ProductLib.sol';

contract ProductContract {
    
    Product.Pr public _product;
    address[] public owners; 
    constructor(string memory product_name, string memory product_category, uint256 price, address owner, string memory carac) public{
        _product = Product.Pr(product_name, product_category, carac, price, block.timestamp);
        owners.push(owner);
    }
    
    function getAddress() public view returns(address){
        return address(this);
    }
    
    function getProduct() public view returns(Product.Pr memory) {
        return _product;
    }

    function getOwners() public view returns(address[] memory){
        return owners;
    }

    function addOwner(address new_owner) public {
        owners.push(new_owner);
    }
}
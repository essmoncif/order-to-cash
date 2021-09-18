// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.1;
pragma experimental ABIEncoderV2;
import './ProductLib.sol';

contract ProductContract {
    
    Product.Pr public _product;
    
    constructor(string memory product_name, string memory product_category, uint256 price, address owner) public{
        _product = Product.Pr(product_name, product_category, price, block.timestamp, owner);
    }
    
    function getAddress() public view returns(address){
        return address(this);
    }
    
    function getProduct() public view returns(Product.Pr memory) {
        return _product;
    }
}
// SPDX-License-Identifier: GPL-3.0
pragma experimental ABIEncoderV2;
pragma solidity ^0.6.1;

import './Product.sol';
import './ProductLib.sol';
import './TermSheet.sol';
import './TransporterLib.sol';
import './Transporter.sol';
import './DeliveryLib.sol';
import './Delivery.sol';

contract Supplier {
    
    struct Supplier_struct {
        string name;
        uint date_creation;
        address supplier_address;
    }

    
    
    Supplier_struct private _supplier;
    
    address[] private products_address;
    mapping(address => ProductContract) public _products;
    
    address[] private transporters_address;
    mapping(address => Transporter) public _transporters;

    address[] private deliveries_address;
    mapping(address => Delivery) public deliveries;


    modifier isInStore(address product_address){
        require(address(_products[product_address]) != address(0), "THIS PRODUCT IS NOT FOUND !");
        _;
    }
    
    modifier isForMe(address sup) {
        require(sup ==  _supplier.supplier_address, "COULD NOT SEND ANY PROPOSAL !");
        _;
    }

    modifier isTransporter(address tr_address) {
        require(address(_transporters[tr_address]) != address(0));
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == _supplier.supplier_address);
        _;
    }
    
    event Termsheet(address indexed ts_address, address indexed seller, address indexed buyer);
    event Deliver(address indexed delivery_address, address  client_address, address  supplier_address, address transporter);
    
    constructor(string memory name, address supplier_address) public {
        _supplier = Supplier_struct(name, block.timestamp, supplier_address);
    }
    
    function createProduct(string memory product_name, string memory product_category, uint256 price, string memory carac) public returns(address){
        
        ProductContract my_product = new ProductContract(product_name, product_category, price, msg.sender, carac);
        _products[address(my_product)] = my_product;
        products_address.push(address(my_product));
        return address(my_product);
    }

    function sendProposal(address supplier, address product, uint unity) isForMe(supplier) isInStore(product) public view returns(uint256) {
        ProductContract pr = _products[product];
        Product.Pr memory data_product = pr.getProduct();
        uint256 total_price = data_product.price * unity;
        return total_price;
    }

    function createTermSheet(string memory issue, address sender, address receiver,  address [] memory products, uint tax, string memory incoterm, uint totalPrice, uint commission, uint date_creation, uint closing_date, uint compensation) public returns(address)  {
        TermSheet ts = new TermSheet(issue, sender, receiver, products, tax, incoterm, totalPrice, commission, date_creation, closing_date, compensation);
        emit Termsheet(ts.getAddress(), sender, receiver);
        ts.getAddress();
    }

    function getProductByAddress(address pr_address) isInStore(pr_address) public view returns(Product.Pr memory) {
        ProductContract pr = _products[pr_address];
        return pr.getProduct();
    }

    function getAllProduct() public view returns(address [] memory) {
        return products_address;
    }

    function getOwnersOfProduct(address pr_address) isInStore(pr_address) public view returns(address[] memory){
        ProductContract pr = _products[pr_address];
        return pr.getOwners();
    }

    function addOwnerToProduct(address pr_address, address new_owner) isInStore(pr_address) public {
        ProductContract pr = _products[pr_address];
        pr.addOwner(new_owner);
    }

    function createTransporter(string memory company_name, string memory type_transport) public returns(address) {
        Transporter tr = new Transporter(company_name, type_transport);
        _transporters[tr.getAddress()] = tr;
        transporters_address.push(tr.getAddress());
        return tr.getAddress();
    }

    function getTransporterByAddress(address transporter_address) isTransporter(transporter_address) public view returns(TransporterLib.TR memory) {
        return _transporters[transporter_address].getTransporter();
    }

    function getAllTransporter() public view returns(address [] memory) {
        return transporters_address;
    }

    function createDelivery(address client, address supplier, address transporter, address termsheet, string memory tracking_number, uint date_creation, uint date_start, uint date_end) public returns(address) {
        Delivery dl = new Delivery(client, supplier, transporter, termsheet, tracking_number, date_creation, date_start, date_end);
        emit Deliver(dl.getAddress(), client, supplier, transporter);
        return dl.getAddress();
    }

    function getAllDeliveries() onlyOwner public view returns(address [] memory ) {
        return deliveries_address;
    }

    function getDeliveryByAddress(address dl_address) onlyOwner public view returns(DeliveryLib.DL memory) {
        return deliveries[dl_address].getDelivery();
    }

}
pragma solidity ^0.6.1;
import './Supplier.sol';
import './Client.sol';


contract Proxy {

    address[] public suppliers_address;
    mapping(address => Supplier) public suppliers;

    address[] public clients_address;
    mapping(address => Client) public clients;

    address private owner;

    constructor() public {
        owner = msg.sender;
    }

    function getSuppliersAddress() public view returns(address[] memory) {
        return suppliers_address;
    }

    function getClientsAddress() public view returns(address[] memory) {
        return clients_address;
    }

    modifier alreadyExistSupplier(address supplier_address) {
        require(address(suppliers[supplier_address]) == address(0));
        _;
    }

    modifier alreadyExistClient(address client_address) {
        require(address(clients[client_address]) == address(0));
        _;
    }

    function createSupplier(string memory name, address supplier_address) alreadyExistSupplier(supplier_address) public returns(address) {
        require(supplier_address != address(0));
        Supplier sp = new Supplier(name, supplier_address);
        suppliers_address.push(supplier_address);
        suppliers[supplier_address] = sp;
        return address(sp);
    }

    function createClient(string memory name, address client_address) alreadyExistClient(client_address) public returns(address) {
        require(client_address != address(0));
        Client cl = new Client(name, client_address);
        clients_address.push(client_address);
        clients[client_address] = cl;
        return address(cl);
    }

}
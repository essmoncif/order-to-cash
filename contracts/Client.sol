// SPDX-License-Identifier: GPL-3.0
pragma experimental ABIEncoderV2;
pragma solidity ^0.6.1;

import './Commande.sol';
import './CommandeLib.sol';

contract Client{
    
    struct Client_struct {
        address c_address;
        string c_name;
    }
    
    // attributs
    Client_struct private _client;
    address private _owner;
    mapping(address => Commande) public commandes;
    address[] public commande_list;
    //events
    event Request(address indexed client, address indexed supplier, address indexed commande);
    event AcceptTermsheet(address indexed termsheet, address indexed supplier, string signature);
    //modifiers
    modifier hasCommande(address commande_address){
        require(address(commandes[commande_address]) != address(0), "THIS COMMANDE IS NOT FOUND !");
        _;
    }
    
    constructor(address clientAddress, string memory ClientName) public {
        _client = Client_struct(clientAddress, ClientName);
        _owner = msg.sender;
    }
    
    function sendRequestToSupplier(address product_address, address supplier_address, uint unity) public {
        Commande cm = new Commande(msg.sender, supplier_address, product_address, unity);
        commandes[address(cm)] = cm;
        commande_list.push(address(cm));
        emit Request(_client.c_address, supplier_address, address(cm));
    }
    
    function getCommande(address commande_address) hasCommande(commande_address) public view returns(CommandeLib.CM memory) {
        return commandes[commande_address].getCM();
    }

    function signeTermSheet(string memory signature, address ts_address, address supplier) public {
        emit AcceptTermsheet(ts_address, supplier, signature);
    }
    
}
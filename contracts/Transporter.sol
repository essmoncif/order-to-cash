pragma solidity ^0.6.1;
pragma experimental ABIEncoderV2;

import './TransporterLib.sol';

contract Transporter{

    TransporterLib.TR public tr;

    constructor(string memory company_name, string memory type_transport) public {
        tr = TransporterLib.TR(company_name, type_transport);
    }

    function getAddress() public view returns(address) {
        return address(this);
    }

    function getTransporter() public view returns(TransporterLib.TR memory) {
        return tr;
    }
}
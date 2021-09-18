pragma solidity ^0.6.1;
pragma experimental ABIEncoderV2;

import './DeliveryLib.sol';

contract Delivery {

    DeliveryLib.DL public dl;

    constructor(address client, address supplier, address transporter, address termsheet, string memory tracking_number, uint date_creation, uint date_start, uint date_end) public {
        dl = DeliveryLib.DL(client, supplier, transporter, termsheet, tracking_number, date_creation, date_start, date_end);
    }

    function getAddress() public view returns(address){
        return address(this);
    }

    function getDelivery() public view returns(DeliveryLib.DL memory) {
        return dl;
    }
}
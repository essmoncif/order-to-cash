pragma solidity ^0.6.1;
pragma experimental ABIEncoderV2;

contract TermSheet {

    struct TermSheet_struct {
        string issue;
        address sender;
        address receiver;
        uint totalPrice;
        uint commission;
        uint date_creation;
        uint closing_date;
        uint compensation;
    }
    
    TermSheet_struct public term;

    constructor(string memory issue, address sender, address receiver, uint totalPrice, uint commission, uint date_creation, uint closing_date, uint compensation) public {
        term = TermSheet_struct(issue, sender, receiver, totalPrice, commission, date_creation, closing_date, compensation);
    }

    function getAddress() public view returns(address) {
        return address(this);
    }
}
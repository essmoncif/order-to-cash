pragma solidity ^0.6.1;


library DeliveryLib {
    
    struct DL{
        address client;
        address supplier;
        address transporter;
        address termsheet;
        string tracking_number;
        uint date_creation;
        uint date_start;
        uint date_end;
    }
}
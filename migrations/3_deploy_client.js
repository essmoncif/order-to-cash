const Client = artifacts.require("Client");

module.exports = function (deployer) {
    deployer.deploy(Client, 'Manal Hader', '0x86A4Df2fBe440eb6b7E75b7EffD3B3eC64627135');
};

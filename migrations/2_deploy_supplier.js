const Supplier = artifacts.require("Supplier");

module.exports = function (deployer) {

    deployer.deploy(Supplier, 'Manal Hader', '0x86A4Df2fBe440eb6b7E75b7EffD3B3eC64627135');
};

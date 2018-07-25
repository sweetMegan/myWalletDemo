/**
 * Created by zhqmac on 2018/7/22.
 */
const web3 = require("../utils/myUtils").getWeb3();
const myUtil = require("../utils/myUtils");
var response = require("../model/responsedata");
setResponseDataWithAccount = async(account, responseData)=> {
    responseData.data.address = account.address;
    responseData.data.privateKey = account.privateKey;
    responseData.data.balance = await getBalanceWithAddress(account.address);
    return responseData;
};

getBalanceWithAddress = async(address)=> {
    console.log("account:" + address);
    var balance = await web3.eth.getBalance(address);
    return web3.utils.fromWei(balance, "ether");
};
//使用私钥解锁账户
unlockAccountWithPrivateKey = async(ctx)=> {
    var responseData = new response(0, "success", {});
    var body = ctx.request.body;
    var privateKey = body.privateKey;
    console.log("privateKey:" + privateKey);
    var account = web3.eth.accounts.privateKeyToAccount(privateKey);
    // ctx.body = {name:"解锁"};
    var data = await setResponseDataWithAccount(account, responseData);
    console.log(data);
    ctx.body = data;
};
//使用keyStore文件
unlockAccountWithKeyStore = async(ctx)=> {
    var responseData = new response(0, "success", {});
    var body = ctx.request.body;
    var pwd = body.pwd;
    var keyStore = body.keyStore;
    try {
        var account = web3.eth.accounts.decrypt(keyStore, pwd);
        ctx.body = await setResponseDataWithAccount(account, responseData);
    }catch (error){
        console.log(error)
        responseData.code = 1;
        responseData.message = "failed";
        responseData.data = {error: error.message};
        ctx.body = responseData;
    }
};
module.exports = {
    unlockAccountWithPrivateKey,
    unlockAccountWithKeyStore,
}
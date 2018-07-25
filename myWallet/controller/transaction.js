/**
 * Created by zhqmac on 2018/7/22.
 */
const web3 = require("../utils/myUtils").getWeb3();
var response = require("../model/responsedata");
var bignumber = require("bignumber.js")

//发起交易
createTransaction = async(ctx)=> {
    console.log("createTransaction");
    var responseData = new response(0, "success", {});
    var body = ctx.request.body;
    var fromAddress = body.from;
    var toAddress = body.to;
    //将输入的金额换算成Wei
    var money = web3.utils.toWei(body.money, "ether");
    var gasPrice = await web3.eth.getGasPrice();
    //获取交易的nonce值,一个顺序累加的值
    var nonce = await web3.eth.getTransactionCount(fromAddress);
    var transactionData = {
        from: fromAddress,
        to: toAddress,
        value: money,
        gasPrice: gasPrice,
        data: '0x00',//当使用代币转账或者合约调用时
        nonce: nonce,
    };
    //estimateGas()方法会将transactionData数据做一些操作,导致,transactionData一些值的类型变化,所以下面对transactionData重新赋值
    var gas = await web3.eth.estimateGas(transactionData);
    transactionData = {
        from: fromAddress,
        to: toAddress,
        value: money,
        gasPrice: gasPrice,
        data: '0x00',//当使用代币转账或者合约调用时
        nonce: nonce,
        gas:gas,
    };
    console.log(transactionData);
    responseData.data = transactionData;
    ctx.body = responseData;

};
//确认交易
/*
* 1、签名交易
* 2、发送交易
* */
sendTransaction = async(ctx)=> {

    console.log("sendTransaction");

    var responseData = new response(0, "success", {});
    var body = ctx.request.body;
    var transactionData = {
        from: body.from,
        to: body.to,
        value: body.value,
        gasPrice: body.gasPrice,
        data: body.data,//当使用代币转账或者合约调用时
        nonce: body.nonce,
        gas: body.gas
    };
    //privateKey为了安全,需要进行加密处理
    var privateKey = body.privateKey;
    //签名交易
    console.log(transactionData);
    console.log(privateKey);
    var signTransactionData = await web3.eth.accounts.signTransaction(transactionData, privateKey);
    try {
        //发送交易
        await web3.eth.sendSignedTransaction(signTransactionData.rawTransaction, (error, hash)=> {
            if (!error) {
                responseData.data.hash = hash;
            } else {
                responseData.code = 1;
                responseData.message = "failed";
                responseData.data = {error: error.message};
            }
        })
    } catch (error) {
        console.log(error);
        responseData.code = 1;
        responseData.message = "failed";
        responseData.data = {error: error.message};
    }
    ctx.body = responseData
};

//根据txHash查询交易状态
transactionStatus = async(ctx)=> {
  var responseData = new response(0,"success",{});
    var data = ctx.request.body;
    var txHash = data.txHash;
    var result = await web3.eth.getTransactionReceipt(txHash);
    if (result != null){
        responseData.data = result;
    }
    ctx.body = responseData;
};
module.exports = {
    createTransaction,
    sendTransaction,
    transactionStatus,
};
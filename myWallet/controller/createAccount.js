/**
 * Created by zhqmac on 2018/7/22.
 */
const web3 = require("../utils/myUtils").getWeb3();
const path = require("path");
const fs = require("fs");
var respones = require("../model/responsedata");
//创建钱包
createAccount = async ctx => {
    var responseData = new respones(0,"success",{});
    // console.log(ctx.request.body);
    var body = ctx.request.body;
    //创建钱包
    var account = web3.eth.accounts.create();
    //生成keyStore文件
    //keyStore是将私钥与用户密码拼接,将拼接结果对称加密得到
    var keyStoreJson = account.encrypt(body.pwd);
    //保存keyStore
    //写入文件的keyStore数据
    // var keyStoreStr = JSON.stringify(keyStoreJson);
    // //keyStore文件名
    // var keyStoreFileName = "UTC--"+new Date().toISOString()+"--"+account.address;
    // //文件保存路径
    // var keyStoreFilePath = path.join(__dirname,"../static/keystore",keyStoreFileName);
    // await fs.writeFile(keyStoreFilePath,keyStoreStr,()=>{});
    // var responseData = new respones(0,"success",{
    //     "downloadUrl":"/keystore/"+keyStoreFileName,
    //     "privateKey":account.privateKey
    // });
    responseData.data.keyStore = keyStoreJson;
    ctx.body = responseData;
};
module.exports={
    createAccount
};
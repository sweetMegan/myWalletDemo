/**
 * Created by zhqmac on 2018/7/22.
 */
const Web3 = require("web3");
var fs = require("fs");
getWeb3 = ()=>{
    //初始化web3访问节点为私有链节点
    const web3 = new Web3(Web3.givenProvider||"http://localhost:8545");
    //以太坊测试链
    // const web3 = new Web3(Web3.givenProvider || "https://kovan.infura.io/v3/4abf7f8865064ed6b99ca3fdac820921");
    return web3;
};
module.exports={
    getWeb3,
};
/**
 * Created by zhqmac on 2018/7/22.
 */
const router = require("koa-router")();
const createAccountController = require("../controller/createAccount");
const accountController = require("../controller/account");
const transactionController = require("../controller/transaction");
router.post("/createaccount",createAccountController.createAccount);
router.post("/unlockaccountwithprivatekey",accountController.unlockAccountWithPrivateKey);
router.post("/unlockaccountwithkeystore",accountController.unlockAccountWithKeyStore);
router.post("/createtransaction",transactionController.createTransaction);
router.post("/sendtransaction",transactionController.sendTransaction);
router.post("/transactionstatus",transactionController.transactionStatus);
module.exports = router;
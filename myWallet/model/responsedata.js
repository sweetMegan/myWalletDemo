/**
 * Created by zhqmac on 2018/7/22.
 */
function response(code, msg, data) {
    this.code = code;//状态码
    this.msg = msg;//状态描述
    this.data = data;//返回的数据
}
module.exports = response;
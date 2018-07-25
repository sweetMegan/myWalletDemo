/**
 * Created by zhqmac on 2018/7/22.
 */
const Koa = require("koa");
const app = new Koa();
const koaBody = require("koa-body");
const router = require("./routers/router");
app.use(async (ctx, next) => {
    console.log(`Process ${ctx.request.method} ${ctx.request.url} ...`);
    await next();
});
//解析post请求
app.use(koaBody({
    multipart:true,
}));
app.use(router.routes());
app.listen("3000");
console.log("服务已开启,监听端口:3000");
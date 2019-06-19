const express = require('express');
const path = require('path');
const app = express();

app.use(express.static(path.resolve(__dirname, 'public')));

app.all('*', (req, res, next) => {
  const proxy = req.query.proxy;
  if (proxy) req.header.cookie = `${req.header.cookie}__proxy__${proxy}`;
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Headers', 'X-Requested-With');
  res.header('Access-Control-Allow-Methods', 'PUT,POST,GET,DELETE,OPTIONS');
  res.header('X-Powered-By', ' 3.2.1')
  res.header('Content-Type', 'application/json; charset=utf-8');
  next();
});
// 获取数据 并分配路由数据接口
app.use('/home', require('./router/home'));
app.use('/hots', require('./router/hots'));
app.use('/types', require('./router/types'));
app.use('/goods', require('./router/goods'));
app.use('/detail', require('./router/detail'));

const port = 8000;
app.listen(port, () => {
  console.log(`Server running @http://192.168.199.191:${port}`);
});

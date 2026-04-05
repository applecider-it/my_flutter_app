import express from 'express';

import { login } from './routes/auth.routes.js';

const app = express();

// JSON形式のリクエストボディを自動でパースする
// これがないと req.body が undefined になる
app.use(express.json());

// 擬似ログイン
app.post("/login", login);

export default app;
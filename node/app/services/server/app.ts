import express from 'express';
import cors from 'cors';

import { setRoutes } from '@/config/routes.js';

const app = express();

app.use(cors({
  origin: true, // リクエスト元をそのまま許可
  credentials: true,
}));

// JSON形式のリクエストボディを自動でパースする
// これがないと req.body が undefined になる
app.use(express.json());

setRoutes(app);

export default app;
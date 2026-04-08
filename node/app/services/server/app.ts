import express from 'express';

import { setRoutes } from '@/config/routes.js';

const app = express();

// JSON形式のリクエストボディを自動でパースする
// これがないと req.body が undefined になる
app.use(express.json());

setRoutes(app);

export default app;
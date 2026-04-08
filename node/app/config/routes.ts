import { Express } from 'express';

import { login } from '@/routes/auth.routes.js';

export const setRoutes = (app: Express) => {
    app.post("/login", login);
}

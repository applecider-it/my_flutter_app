
import { login } from '../routes/auth.routes.js';

export  const setRoutes =  (app) => {
    app.post("/login", login);
}

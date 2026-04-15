import { Express } from "express";

import authController from "@/controllers/auth.controller.js";

export const setRoutes = (app: Express) => {
  app.post("/login", authController.login);
};

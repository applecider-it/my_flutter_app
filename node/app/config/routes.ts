import { Express } from "express";

import authController from "@/controllers/v1/auth.controller.js";

export const setRoutes = (app: Express) => {
  app.post("/v1/login", authController.login);
};

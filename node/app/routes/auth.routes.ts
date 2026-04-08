import { Request, Response } from 'express';

import { execAuth } from "@/services/auth/auth.js";

/** ログイン処理 */
export const login = (req: Request, res: Response) => {
  const { email, password } = req.body;
  const userAgent = req.headers['user-agent'];

  console.log('login', { email, password }, 'userAgent', userAgent)

  const token = execAuth(email, password);

  if (token) {
    // 認証成功の場合

    return res.json({
      token: token
    });
  } else {
    // 認証失敗の場合

    res.status(401).json({
      message: "Invalid credentials"
    });
  }
};
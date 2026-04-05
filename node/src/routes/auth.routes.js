/** ログイン処理 */
export const login = (req, res) => {
  const { email, password } = req.body;

  if (email === "test@example.com" && password === "1234") {
    // 認証成功の場合

    return res.json({
      token: "dummy_token_123"
    });
  } else {
    // 認証失敗の場合

    res.status(401).json({
      message: "Invalid credentials"
    });
  }
};
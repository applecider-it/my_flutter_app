const express = require("express");

const app = express();

// JSON形式のリクエストボディを自動でパースする
// これがないと req.body が undefined になる
app.use(express.json());

// 擬似ログイン
app.post("/login", (req, res) => {
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
});

// サーバーを起動
app.listen(3000, () => {
  console.log("Server running on http://localhost:3000");
});

// Expressフレームワークを読み込む
// → HTTPサーバーを簡単に作るためのライブラリ
const express = require("express");

// Expressアプリケーションのインスタンスを作成
const app = express();


// ミドルウェア設定
// → リクエストを処理する前に実行される共通処理

// JSON形式のリクエストボディを自動でパースする
// これがないと req.body が undefined になる
app.use(express.json());


// ==============================
// ログインAPI
// ==============================

// POSTリクエストを /login に対して受け付ける
app.post("/login", (req, res) => {

  // クライアント（Flutterなど）から送られてきた
  // JSONデータを取り出す
  const { email, password } = req.body;


  // ==========================
  // ダミー認証ロジック
  // ==========================

  // 入力されたメールとパスワードが
  // あらかじめ決めた値と一致するかチェック
  if (email === "test@example.com" && password === "1234") {

    // 認証成功の場合

    // 本来はJWTなどを発行するが、
    // 今回はダミーのトークンを返す
    return res.json({
      token: "dummy_token_123"
    });
  }


  // ==========================
  // 認証失敗
  // ==========================

  // HTTPステータス401（Unauthorized）を返す
  // → 認証失敗を意味する
  res.status(401).json({

    // クライアント側で表示するためのメッセージ
    message: "Invalid credentials"
  });
});


// ==============================
// サーバー起動
// ==============================

// ポート3000でHTTPサーバーを起動
app.listen(3000, () => {

  // 起動成功時にコンソールに表示
  console.log("Server running on http://localhost:3000");
});

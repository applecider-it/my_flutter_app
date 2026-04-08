/** ダミー認証 */
export const execAuth = (email, password) => {
    if (email === "test@example.com" && password === "1234") {
        // 認証成功の場合

        return "dummy_token_123";
    }

    return null;
}
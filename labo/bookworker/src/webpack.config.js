module.exports = {
    mode: 'development',
    entry: {
        "bitflyer": './bitflyer.js',
        "bitflyerfx": './bitflyerfx.js',
    },
    // 出力の設定
    output: {
        // 出力するファイル名
        filename: "[name].js",
        path: __dirname + '/../',
    }
}

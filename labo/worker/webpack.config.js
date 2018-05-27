module.exports = {
    mode: 'production',
    entry: {
        "cryptocompare": './cryptocompare.js',
        "bitmex": './bitmex.js',
        "bitflyer": './bitflyer.js'
    },
    // 出力の設定
    output: {
        // 出力するファイル名
        filename: "[name].js",
        path: __dirname + '/../'
    }
}

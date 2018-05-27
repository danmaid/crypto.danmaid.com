const io = require('socket.io-client');

// CryptoCompare の TRADE データを取得する
const socket = io('wss://streamer.cryptocompare.com', { transports: ["websocket"], forceNew: true })

// 初期接続待ち
let initialized = new Promise(resolve => {
    socket.on("connect", () => {
        resolve()
    });
})

// 通貨ペアを受け取って、取得開始
self.addEventListener('message', (message) => {
    console.log(message.data)
    initialized.then(() => {
        socket.emit('SubAdd', { subs: message.data })
    })
})

// データ受信したら加工して返す
socket.on('m', (e) => {
    let data = e.split('~')
    // '{SubscriptionId}~{ExchangeName}~{CurrencySymbol}~{CurrencySymbol}~{Flag}~{TradeId}~{TimeStamp}~{Quantity}~{Price}~{Total}'
    // Flag 1: Sell, 2: Buy, 4: Unknown
    if (data.length < 10) return
    let trade = {
        TimeStamp: data[6],
        Side: data[4] == 1 ? 'Sell' : data[4] == 2 ? 'Buy' : 'Unknown',
        Quantity: data[7],
        Price: data[8],
        Total: data[9],
        ExchangeName: data[1],
        fsym: data[2],
        tsym: data[3],
        TradeId: data[5]
    }
    // console.log(data, trade)
    self.postMessage(trade)
})

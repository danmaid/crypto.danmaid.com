// CryptoCompare の TRADE データを取得する
let wss = new WebSocket('wss://streamer.cryptocompare.com/socket.io/?EIO=3&transport=websocket')
let hb
wss.addEventListener('open', () => {
    hb = setInterval(() => { wss.send('2') }, 10000)
})
wss.addEventListener('close', () => {
    clearInterval(hb)
})

// 通貨ペアを受け取って、取得開始
self.addEventListener('message', (message) => {
    // console.log(message.data)
    if (wss.readyState == wss.OPEN) {
        wss.send(42 + JSON.stringify(["SubAdd", { "subs": [message.data] }]))
    } else {
        wss.addEventListener('open', () => {
            wss.send(42 + JSON.stringify(["SubAdd", { "subs": [message.data] }]))
        })
    }
})

wss.addEventListener('message', (e) => {
    if (e.data.substr(0, 2) != '42') return
    let event = JSON.parse(e.data.slice(2))
    if (event[0] != 'm') return
    let data = event[1].split('~')
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

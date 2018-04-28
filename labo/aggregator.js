// CryptoCompare の TRADE データを取得し、集約する
// 通貨ペアを受け取って、取得開始
self.addEventListener('message', (message) => {
    console.log(message.data)
    let exchanges = []
    let fsym = message.data.fsym
    let tsym = message.data.tsym
    let req = fetch('https://min-api.cryptocompare.com/data/subs?fsym=' + fsym + '&tsyms=' + tsym)
        .then(r => r.json())
        .then(data => {
            for (tsym of Object.keys(data)) {
                // console.log(tsym)
                if (data[tsym].TRADES) {
                    // console.log(data[tsym].TRADES)
                    exchanges = data[tsym].TRADES
                }
            }
            return exchanges
        })

    let wss = new WebSocket('wss://streamer.cryptocompare.com/socket.io/?EIO=3&transport=websocket')
    let hb
    wss.addEventListener('open', () => {
        // 42["SubAdd",{"subs":["0~Poloniex~BTC~USD"]}]
        // ["SubAdd",{"subs":["0~Poloniex~BTC~USD"]}]
        // wss.send(2)
        req.then(ex => {
            console.log(ex)
            wss.send(42 + JSON.stringify(["SubAdd", { "subs": ex }]))
        })
        // wss.send(42 + JSON.stringify(["SubAdd", { "subs": ["0~Poloniex~BTC~USD"] }]))
        hb = setInterval(() => { wss.send('2') }, 10000)
    })
    wss.addEventListener('close', () => {
        clearInterval(hb)
    })
    // wss.addEventListener('message', (e) => {
    //     console.log(e)
    // })
    wss.addEventListener('message', (e) => {
        if (e.data.substr(0, 2) != '42') return
        let event = JSON.parse(e.data.slice(2))
        if (event[0] != 'm') return
        let data = event[1].split('~')
        // '{SubscriptionId}~{ExchangeName}~{CurrencySymbol}~{CurrencySymbol}~{Flag}~{TradeId}~{TimeStamp}~{Quantity}~{Price}~{Total}'
        // Flag 1: Sell, 2: Buy, 4: Unknown
        if (data.length < 10) return
        let trade = {
            ExchangeName: data[1],
            fsym: data[2],
            tsym: data[3],
            Side: data[4] == 1 ? 'Sell' : data[4] == 2 ? 'Buy' : 'Unknown',
            TradeId: data[5],
            TimeStamp: data[6],
            Quantity: data[7],
            Price: data[8],
            Total: data[9]
        }
        // console.log(data, trade)
        self.postMessage(trade)
    })
    console.log(wss)
})
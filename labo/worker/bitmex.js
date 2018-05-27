const wss = new WebSocket('wss://www.bitmex.com/realtime')
wss.onopen = function () {
    wss.send(JSON.stringify({
        "op": "subscribe",
        "args": [
            "trade:XBTUSD"
        ]
    }))
}

// データ受信したら加工して返す
wss.onmessage = function (msg) {
    let data = JSON.parse(msg.data)
    if (data.table != "trade" || data.action != "insert") { return }

    data = data.data.map(elem => {
        elem.TimeStamp = parseInt((new Date(elem.timestamp)) / 1000)
        elem.Side = elem.side
        elem.Quantity = elem.homeNotional
        elem.Price = elem.price
        // elem.Total = foreignNotional
        elem.ExchangeName = "bitmex"
        elem.fsym = "BTC"
        elem.tsym = 'USD*'
        elem.TradeId = elem.trdMatchID
        return elem
    })
    data.forEach(elem => {
        self.postMessage(elem)
    })
}

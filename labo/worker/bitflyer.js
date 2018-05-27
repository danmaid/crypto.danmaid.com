const io = require('socket.io-client');

// bitFlyer の TRADE データを取得する
const socket = io('https://io.lightstream.bitflyer.com', { transports: ["websocket"], forceNew: true })

socket.on("connect", () => {
    socket.emit("subscribe", 'lightning_executions_FX_BTC_JPY')
})

// データ受信したら加工して返す
socket.on('lightning_executions_FX_BTC_JPY', (e) => {
    console.log(e)
    // [{"id":236267713,"side":"BUY","price":836450,"size":0.521,"exec_date":"2018-05-27T15:20:32.9656593Z","buy_child_order_acceptance_id":"JRF20180527-152025-793971","sell_child_order_acceptance_id":"JRF20180527-152022-385971"}]
    e = e.map(elem => {
        elem.TimeStamp = parseInt((new Date(elem.exec_date)) / 1000)
        elem.Side = elem.side == 'SELL' ? 'Sell' : elem.side == 'BUY' ? 'Buy' : 'Unknown',
            elem.Quantity = elem.size
        elem.Price = elem.price
        // elem.Total = foreignNotional
        elem.ExchangeName = "bitFlyerFX"
        elem.fsym = "BTC"
        elem.tsym = 'JPY*'
        elem.TradeId = elem.id
        return elem
    })
    e.forEach(elem => {
        self.postMessage(elem)
    })
})

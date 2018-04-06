/////
// {
//     price: Number, -- 約定価格
//     size: Number, -- 取引量
//     side: 'BUY' or 'SELL'
// }

///// bitflyer
// require pubnub.js
// <script src="https://cdn.pubnub.com/sdk/javascript/pubnub.4.20.2.js"></script>

///// bitfinex
// BTC_USD
export const bitfinex_BTC_USD = function () {
    let target = new EventTarget()
    let wss = new WebSocket('wss://api.bitfinex.com/ws/')
    wss.onopen = function () {
        wss.send(JSON.stringify({
            "event": "subscribe",
            "channel": "trades",
            "pair": "BTCUSD"
        }));
    };
    wss.onmessage = function (msg) {
        let data = JSON.parse(msg.data)
        if (data[1] != "tu") { return }

        let side = 'BUY';
        let volume = data[6];
        if (volume < 0) {
            side = 'SELL';
            volume = (- data[6]);
        }

        target.dispatchEvent(new CustomEvent('message', {
            detail: {
                price: data[5],
                volume: volume,
                side: side,
                date: new Date(data[4] * 1000),
                raw: msg.data
            }
        }))
    };
    return target
}()

///// bitmex
// BTC_USD
export const bitmex_BTC_USD = function () {
    let target = new EventTarget()
    let wss = new WebSocket('wss://www.bitmex.com/realtime')
    wss.onopen = function () {
        wss.send(JSON.stringify({
            "op": "subscribe",
            "args": [
                "trade:XBTUSD"
            ]
        }));
    };
    wss.onmessage = function (msg) {
        let data = JSON.parse(msg.data)
        if (data.table != "trade" || data.action != "insert") { return }

        data = data.data.map(elem => {
            elem.volume = elem.homeNotional;
            elem.side = elem.side.toUpperCase();
            elem.date = new Date(elem.timestamp);
            return elem
        })
        data.forEach(elem => {
            target.dispatchEvent(new CustomEvent('message', { detail: elem }))
        })

    };
    return target
}()

///// GDAX
// BTC_USD
export const gdax_BTC_USD = function () {
    let target = new EventTarget()
    let wss = new WebSocket('wss://ws-feed.gdax.com')
    wss.onopen = function () {
        wss.send(JSON.stringify({
            "type": "subscribe",
            "channels": [
                { "name": "matches", "product_ids": ["BTC-USD"] }
            ]
        }));
    };
    wss.onmessage = function (msg) {
        let data = JSON.parse(msg.data)
        if (data.type != "match") { return }

        data.price = parseFloat(data.price);
        data.volume = parseFloat(data.size);
        data.side = data.side.toUpperCase();
        data.date = new Date(data.time);

        target.dispatchEvent(new CustomEvent('message', { detail: data }))
    };
    return target
}()

///// OKCoin
// BTC_USD
export const okcoin_BTC_USD = function () {
    let target = new EventTarget()
    let wss = new WebSocket('wss://real.okcoin.com:10440/websocket')
    wss.onopen = function () {
        wss.send(JSON.stringify({
            "event": "addChannel",
            "channel": "ok_sub_spot_btc_usd_deals"
        }));
    };
    wss.onmessage = function (msg) {
        let data = JSON.parse(msg.data)[0]
        if (data.channel != "ok_sub_spot_btc_usd_deals") { return }

        data.data.forEach(elem => {
            let date = new Date()
            date.setUTCHours(parseInt(elem[3].split(':')[0]) - 8)
            date.setUTCMinutes(parseInt(elem[3].split(':')[1]))
            date.setUTCSeconds(parseInt(elem[3].split(':')[2]))
            target.dispatchEvent(new CustomEvent('message', {
                detail: {
                    price: parseFloat(elem[1]),
                    volume: parseFloat(elem[2]),
                    date: date,
                side: elem[4] == 'bid' ? 'BUY' : 'SELL',
                raw: elem
                }
            }))
})
    };
return target
}()

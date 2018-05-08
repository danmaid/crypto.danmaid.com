/////
// {
//     price: Number, -- 約定価格
//     size: Number, -- 取引量
//     side: 'BUY' or 'SELL'
// }

///// bitflyer
// require pubnub.js
// <script src="https://cdn.pubnub.com/sdk/javascript/pubnub.4.20.2.js"></script>
// BTC_JPY
export const bitflyer_BTC_JPY = function () {
    let target = new EventTarget()
    let pubnub = new PubNub({
        subscribeKey: 'sub-c-52a9ab50-291b-11e5-baaa-0619f8945a4f'
    });
    pubnub.addListener({
        message: (msg) => {
            msg.message.forEach(elem => {
                elem.date = new Date(elem.exec_date);
                elem.volume = elem.size;
                target.dispatchEvent(new CustomEvent('message', { detail: elem }));
            })
        }
    });
    pubnub.subscribe({
        channels: ['lightning_executions_BTC_JPY']
    });
    return target
}

// FX_BTC_JPY
export const bitflyer_FX_BTC_JPY = function () {
    let target = new EventTarget()
    let pubnub = new PubNub({
        subscribeKey: 'sub-c-52a9ab50-291b-11e5-baaa-0619f8945a4f'
    });
    pubnub.addListener({
        message: (msg) => {
            msg.message.forEach(elem => {
                elem.date = new Date(elem.exec_date);
                elem.volume = elem.size;
                target.dispatchEvent(new CustomEvent('message', { detail: elem }));
            })
        }
    });
    pubnub.subscribe({
        channels: ['lightning_executions_FX_BTC_JPY']
    });
    return target
}

// ETH_BTC
export const bitflyer_ETH_BTC = function () {
    let target = new EventTarget()
    let pubnub = new PubNub({
        subscribeKey: 'sub-c-52a9ab50-291b-11e5-baaa-0619f8945a4f'
    });
    pubnub.addListener({
        message: (msg) => {
            msg.message.forEach(elem => {
                elem.date = new Date(elem.exec_date);
                elem.volume = elem.size;
                target.dispatchEvent(new CustomEvent('message', { detail: elem }));
            })
        }
    });
    pubnub.subscribe({
        channels: ['lightning_executions_ETH_BTC']
    });
    return target
}

// BCH_BTC
export const bitflyer_BCH_BTC = function () {
    let target = new EventTarget()
    let pubnub = new PubNub({
        subscribeKey: 'sub-c-52a9ab50-291b-11e5-baaa-0619f8945a4f'
    });
    pubnub.addListener({
        message: (msg) => {
            msg.message.forEach(elem => {
                elem.date = new Date(elem.exec_date);
                elem.volume = elem.size;
                target.dispatchEvent(new CustomEvent('message', { detail: elem }));
            })
        }
    });
    pubnub.subscribe({
        channels: ['lightning_executions_BCH_BTC']
    });
    return target
}

///// Zaif
// BTC_JPY
export const zaif_BTC_JPY = function () {
    let target = new EventTarget()
    let wss = new WebSocket('wss://ws.zaif.jp/stream?currency_pair=btc_jpy')
    let tid = 0
    wss.onopen = function () {
    };
    wss.onmessage = function (msg) {
        let data = JSON.parse(msg.data)
        data = data.trades.filter(trade => tid < trade.tid)
        data = data.sort((a, b) => a.date - b.date)
        data.forEach(trade => {
            trade.volume = trade.amount
            trade.date = new Date(trade.date * 1000)
            trade.side = trade.trade_type == 'ask' ? 'SELL' : 'BUY'
            target.dispatchEvent(new CustomEvent('message', { detail: trade }))
            tid = trade.tid
        })
    };
    return target
}

// XEM/JPY
export const zaif_XEM_JPY = function () {
    let target = new EventTarget()
    let wss = new WebSocket('wss://ws.zaif.jp/stream?currency_pair=xem_jpy')
    let tid = 0
    wss.onopen = function () {
    };
    wss.onmessage = function (msg) {
        let data = JSON.parse(msg.data)
        data = data.trades.filter(trade => tid < trade.tid)
        data = data.sort((a, b) => a.date - b.date)
        data.forEach(trade => {
            trade.volume = trade.amount
            trade.date = new Date(trade.date * 1000)
            trade.side = trade.trade_type == 'ask' ? 'SELL' : 'BUY'
            target.dispatchEvent(new CustomEvent('message', { detail: trade }))
            tid = trade.tid
        })
    };
    return target
}

// XEM/BTC
export const zaif_XEM_BTC = function () {
    let target = new EventTarget()
    let wss = new WebSocket('wss://ws.zaif.jp/stream?currency_pair=xem_btc')
    let tid = 0
    wss.onopen = function () {
    };
    wss.onmessage = function (msg) {
        let data = JSON.parse(msg.data)
        data = data.trades.filter(trade => tid < trade.tid)
        data = data.sort((a, b) => a.date - b.date)
        data.forEach(trade => {
            trade.volume = trade.amount
            trade.date = new Date(trade.date * 1000)
            trade.side = trade.trade_type == 'ask' ? 'SELL' : 'BUY'
            target.dispatchEvent(new CustomEvent('message', { detail: trade }))
            tid = trade.tid
        })
    };
    return target
}

// MONA/JPY
export const zaif_MONA_JPY = function () {
    let target = new EventTarget()
    let wss = new WebSocket('wss://ws.zaif.jp/stream?currency_pair=mona_jpy')
    let tid = 0
    wss.onopen = function () {
    };
    wss.onmessage = function (msg) {
        let data = JSON.parse(msg.data)
        data = data.trades.filter(trade => tid < trade.tid)
        data = data.sort((a, b) => a.date - b.date)
        data.forEach(trade => {
            trade.volume = trade.amount
            trade.date = new Date(trade.date * 1000)
            trade.side = trade.trade_type == 'ask' ? 'SELL' : 'BUY'
            target.dispatchEvent(new CustomEvent('message', { detail: trade }))
            tid = trade.tid
        })
    };
    return target
}

///// bitbank
// BTC_JPY
export const bitbank_BTC_JPY = function () {
    let target = new EventTarget()
    let exec = new PubNub({
        subscribeKey: 'sub-c-e12e9174-dd60-11e6-806b-02ee2ddab7fe'
    });
    exec.addListener({
        message: (msg) => {
            msg = msg.message.data.transactions.sort((a, b) => a.executed_at - b.executed_at)
            msg.forEach(elem => {
                elem.date = new Date(elem.executed_at);
                elem.volume = parseFloat(elem.amount);
                elem.price = parseFloat(elem.price);
                elem.side = elem.side.toUpperCase();
                target.dispatchEvent(new CustomEvent('message', { detail: elem }));
            })
        }
    });
    exec.subscribe({
        channels: ['transactions_btc_jpy']
    });
    return target
}

///// coincheck
// BTC_JPY
export const coincheck_BTC_JPY = function () {
    let target = new EventTarget()
    let wss = new WebSocket('wss://ws-api.coincheck.com/')
    wss.onopen = function () {
        wss.send(JSON.stringify({
            "type": "subscribe",
            "channel": "btc_jpy-trades"
        }));
    };
    wss.onmessage = function (msg) {
        let data = JSON.parse(msg.data)
        target.dispatchEvent(new CustomEvent('message', {
            detail: {
                price: parseFloat(data[2]),
                volume: parseFloat(data[3]),
                side: data[4].toUpperCase(),
                date: new Date()
            }
        }))
    }
    return target
}


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
}

// ETH_USD
export const bitfinex_ETH_USD = function () {
    let target = new EventTarget()
    let wss = new WebSocket('wss://api.bitfinex.com/ws/')
    wss.onopen = function () {
        wss.send(JSON.stringify({
            "event": "subscribe",
            "channel": "trades",
            "pair": "ETHUSD"
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
}

// BTC_JPY
export const bitfinex_BTC_JPY = function () {
    let target = new EventTarget()
    let wss = new WebSocket('wss://api.bitfinex.com/ws/')
    wss.onopen = function () {
        wss.send(JSON.stringify({
            "event": "subscribe",
            "channel": "trades",
            "pair": "BTCJPY"
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
}

// BTC_EUR
export const bitfinex_BTC_EUR = function () {
    let target = new EventTarget()
    let wss = new WebSocket('wss://api.bitfinex.com/ws/')
    wss.onopen = function () {
        wss.send(JSON.stringify({
            "event": "subscribe",
            "channel": "trades",
            "pair": "BTCEUR"
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
}

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
}

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
}

// ETH_USD
export const gdax_ETH_USD = function () {
    let target = new EventTarget()
    let wss = new WebSocket('wss://ws-feed.gdax.com')
    wss.onopen = function () {
        wss.send(JSON.stringify({
            "type": "subscribe",
            "channels": [
                { "name": "matches", "product_ids": ["ETH-USD"] }
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
}

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
            if ((parseInt(elem[3].split(':')[0]) - 8) < 0) {
                date.setUTCDate(date.getUTCDate() + 1)
            }
            if (date > (new Date)) { return }
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
}

///// bitstamp
// BTC_USD
export const bitstamp_BTC_USD = function () {
    let target = new EventTarget();
    let pusher = new Pusher('de504dc5763aeef9ff52');
    let channel = pusher.subscribe('live_trades');
    channel.bind('trade', data => {
        data.volume = data.amount;
        data.side = data.type == 0 ? 'BUY' : 'SELL';
        data.date = new Date(data.timestamp * 1000);

        target.dispatchEvent(new CustomEvent('message', { detail: data }))
    });
    return target
}


///// binance
// BTC_USDT
export const binance_BTC_USDT = function () {
    let target = new EventTarget();
    let wss = new WebSocket('wss://stream.binance.com:9443/ws/btcusdt@trade')
    wss.onopen = function () {
    };
    wss.onmessage = function (msg) {
        let data = JSON.parse(msg.data)

        data.price = parseFloat(data.p);
        data.volume = parseFloat(data.q);
        data.side = data.m ? 'SELL' : 'BUY';
        data.date = new Date(data.T);

        target.dispatchEvent(new CustomEvent('message', { detail: data }))
    };
    return target
}

///// OKEx
// BTC_USDT
export const okex_BTC_USDT = function () {
    let target = new EventTarget()
    let wss = new WebSocket('wss://real.okex.com:10441/websocket')
    wss.onopen = function () {
        wss.send(JSON.stringify({
            "event": "addChannel",
            "channel": "ok_sub_spot_btc_usdt_deals"
        }));
    };
    wss.onmessage = function (msg) {
        let data = JSON.parse(msg.data)[0]
        if (data.channel != "ok_sub_spot_btc_usdt_deals") { return }

        data.data.forEach(elem => {
            let date = new Date()
            date.setUTCHours(parseInt(elem[3].split(':')[0]) - 8)
            date.setUTCMinutes(parseInt(elem[3].split(':')[1]))
            date.setUTCSeconds(parseInt(elem[3].split(':')[2]))
            if ((parseInt(elem[3].split(':')[0]) - 8) < 0) {
                date.setUTCDate(date.getUTCDate() + 1)
            }
            if (date > (new Date)) { return }
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
}

/////
// {
//     price: Number, -- 約定価格
//     size: Number, -- 取引量
//     side: 'BUY' or 'SELL'
// }

// require Rx.js
// <script src="https://unpkg.com/@reactivex/rxjs/dist/global/Rx.min.js"></script>

///// bitflyer
// require pubnub.js
// <script src="https://cdn.pubnub.com/sdk/javascript/pubnub.4.20.2.js"></script>

// BTC_JPY
export const bitflyer_BTC_JPY = Rx.Observable.create(observer => {
    const exec = new PubNub({
        subscribeKey: 'sub-c-52a9ab50-291b-11e5-baaa-0619f8945a4f'
    });
    exec.addListener({
        message: function (message) {
            observer.next(message.message);
        }
    });
    exec.subscribe({
        channels: ['lightning_executions_BTC_JPY']
    });
})
    .flatMap(msg => msg)
    .share();

// FX_BTC_JPY
export const bitflyer_FX_BTC_JPY = Rx.Observable.create(observer => {
    const exec = new PubNub({
        subscribeKey: 'sub-c-52a9ab50-291b-11e5-baaa-0619f8945a4f'
    });
    exec.addListener({
        message: function (message) {
            observer.next(message.message);
        }
    });
    exec.subscribe({
        channels: ['lightning_executions_FX_BTC_JPY']
    });
})
    .flatMap(msg => msg)
    .share();

///// bitfinex
// BTC_USD
export const bitfinex_BTC_USD = Rx.Observable.create(observer => {
    const wss = new WebSocket('wss://api.bitfinex.com/ws/')
    wss.onopen = function () {
        wss.send(JSON.stringify({
            "event": "subscribe",
            "channel": "trades",
            "pair": "BTCUSD"
        }));
    };
    wss.onmessage = function (msg) {
        this.next(msg.data);
    }.bind(observer);
})
    .map(x => JSON.parse(x))
    .filter(msg => msg[1] == "tu")
    .map(msg => {
        let side = 'BUY';
        let size = msg[6];
        if (size < 0) {
            side = 'SELL';
            size = (- msg[6]);
        }
        return {
            price: msg[5],
            size: size,
            side: side
        }
    })
    .share();

///// bitmex
// XBT_USD
export const bitmex_XBT_USD = Rx.Observable.create(observer => {
    const wss = new WebSocket('wss://www.bitmex.com/realtime')
    wss.onopen = function () {
        wss.send(JSON.stringify({
            "op": "subscribe",
            "args": [
                "trade:XBTUSD"
            ]
        }));
    };
    wss.onmessage = function (msg) {
        this.next(msg.data);
    }.bind(observer);
})
    .map(x => JSON.parse(x))
    .filter(msg => msg.table == 'trade' && msg.action == 'insert')
    .flatMap(msg => msg.data)
    .map(msg => {
        msg.side = msg.side.toUpperCase();
        return msg;
    })
    .share();

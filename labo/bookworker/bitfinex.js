let wss = new WebSocket('wss://api.bitfinex.com/ws/2')
wss.addEventListener('open', () => {
    wss.send(JSON.stringify({
        event: 'subscribe',
        channel: 'book',
        symbol: 'BTCUSD',
        prec: 'P2',
        freq: 'F0',
        len: 25
    }))
})
wss.addEventListener('message', (message) => {
    let data = JSON.parse(message.data)[1]
    // 単ページが来たときは複数ページと同じにして処理させる
    if (Array.isArray(data) && data.length == 3) {
        data = [data]
    }
    // 複数ページが来たとき（最初）
    if (Array.isArray(data)) {
        data.forEach(e => {
            self.postMessage({
                index: e[0],
                count: e[1],
                amount: e[2]
            })
        })
    } else {
        // その他はとりあえず
        console.log('other:', message.data)
    }
})

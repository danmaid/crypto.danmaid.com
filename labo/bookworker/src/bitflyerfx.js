const io = require('socket.io-client');
const socket = io('https://io.lightstream.bitflyer.com', { transports: ["websocket"] })

socket.on("connect", () => {
    socket.emit("subscribe", 'lightning_board_snapshot_FX_BTC_JPY')
    socket.emit("subscribe", 'lightning_board_FX_BTC_JPY')
})

let aggr = {}
let postAggr = (index) => {
    self.postMessage({
        index: index,
        count: aggr[index].count,
        amount: aggr[index].size
    })
}

let view = {}
let postView = (index) => {
    self.postMessage({
        index: index,
        count: view[index].count,
        amount: view[index].size
    })
}

let full = {}

let insert = (e) => {
    full[e.price] = e
    let index = e.index
    if (!aggr[index]) {
        aggr[index] = { size: 0, count: 0, index: index }
    }
    aggr[index].count++
    aggr[index].size += e.size
    // 新規追加分を送信
    let sorted = Object.keys(aggr).map(e => aggr[e]).sort((x, y) => x.index - y.index)
    let viewbook = sorted.filter(e => e.size < 0).slice(0, 25).concat(sorted.filter(e => e.size > 0).slice(-25))
    viewbook.forEach(e => {
        if (!view[e.index]) {
            view[e.index] = e
            postView(e.index)
        }
    })
    let viewprices = viewbook.map(e => e.index)
    for (index of Object.keys(view)) {
        if (!viewprices.includes(parseInt(index))) {
            delete view[index]
            self.postMessage({
                index: index,
                count: 0,
                amount: 0
            })
        }
    }
}

let update = (e) => {
    let index = e.index
    let diff = e.size - full[e.price].size
    aggr[index].size += diff
    full[e.price].size = e.size
    if (view[index]) {
        postView(index)
    }
}

let doDelete = (e) => {
    let index = e.index
    let old = full[e.price].size
    aggr[index].count--
    aggr[index].size -= old
    if (aggr[index].count <= 0) {
        console.log('aggr book delete:', aggr[index])
        delete aggr[index]
        if (view[index]) {
            delete view[index]
            self.postMessage({
                index: index,
                count: 0,
                amount: 0
            })

            // 削った分を追加
            let sorted = Object.keys(aggr).map(e => aggr[e]).sort((x, y) => x.index - y.index)
            sorted.filter(e => e.size < 0).slice(0, 25).forEach(e => {
                if (!view[e.index]) {
                    view[e.index] = e
                    postView(e.index)
                }
            })
            sorted.filter(e => e.size > 0).slice(-25).forEach(e => {
                if (!view[e.index]) {
                    view[e.index] = e
                    postView(e.index)
                }
            })
        }
    } else {
        if (view[index]) {
            postView(index)
        }
    }
    delete full[e.price]
}

let selector = msg => {
    msg.bids.concat(msg.asks.map(e => { e.size = - e.size; return e }))
        .map(e => { e.index = Math.floor(e.price / 1000) * 1000; return e })
        .forEach(e => {
            if (full[e.price]) {
                if (e.size == 0) doDelete(e)
                else update(e)
            } else if (e.size != 0) insert(e)
        })
}

socket.on('lightning_board_snapshot_FX_BTC_JPY', (msg) => {
    selector(msg)
})
socket.on('lightning_board_FX_BTC_JPY', selector)

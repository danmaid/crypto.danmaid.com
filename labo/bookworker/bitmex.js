let wss = new WebSocket('wss://www.bitmex.com/realtime')
let initialized = false

wss.addEventListener('open', () => {
    wss.send(JSON.stringify({
        op: 'subscribe',
        args: ['orderBookL2:XBTUSD']
    }))
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
    full[e.id] = e
    let index = Math.floor(e.price / 10) * 10
    full[e.id].index = index
    if (!aggr[index]) {
        aggr[index] = { size: 0, count: 0, index: index }
    }
    aggr[index].count++
    if (e.side == 'Sell') {
        aggr[index].size -= e.size
    } else if (e.side == 'Buy') {
        aggr[index].size += e.size
    }
}
let update = (e) => {
    let index = full[e.id].index
    let diff = e.size - full[e.id].size
    if (e.side == 'Sell') {
        aggr[index].size -= diff
    } else if (e.side == 'Buy') {
        aggr[index].size += diff
    }
    full[e.id].size = e.size
    if (view[index]) {
        postView(index)
    }
}
let doDelete = (e) => {
    let index = full[e.id].index
    let old = full[e.id].size
    if (e.side == 'Sell') {
        aggr[index].size += old
    } else if (e.side == 'Buy') {
        aggr[index].size -= old
    }
    aggr[index].count--
    if (aggr[index].count <= 0) {
        console.log('aggr book delete:', aggr[index])
        delete aggr[index]
        if (view[index]) {
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
    delete full[e.id]
}

wss.addEventListener('message', (message) => {
    let data = JSON.parse(message.data)
    if (initialized) {
        switch (data.action) {
            case 'update':
                // console.log('update', data)
                data.data.forEach(e => update(e))
                break;
            case 'delete':
                // console.log('delete', data)
                data.data.forEach(e => doDelete(e))
                break;
            case 'insert':
                // console.log('insert', data)
                data.data.forEach(e => insert(e))
                break;
        }
    }
    if (data.action == 'partial') {
        initialized = true
        console.log('partial', data)
        data.data.forEach(e => insert(e))

        // 上下25件分を取り出す
        let sorted = Object.keys(aggr).map(e => aggr[e]).sort((x, y) => x.index - y.index)
        sorted.filter(e => e.size < 0).slice(0, 25).forEach(e => {
            view[e.index] = e
            postView(e.index)
        })
        sorted.filter(e => e.size > 0).slice(-25).forEach(e => {
            view[e.index] = e
            postView(e.index)
        })

        console.log(view)
    }
})

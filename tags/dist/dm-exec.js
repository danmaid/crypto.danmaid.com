riot.tag2('dm-exec-mixed', '<dm-exec if="{data}" name="{opts.name}" buy="{Math.round(getMixedVolume(data, side.BUY) * round) / round }⁗ sell=⁗{ Math.round(getMixedVolume(data, side.SELL) * round) / round}" scale="{scale}"></dm-exec>', '', '', function(opts) {
        this.on('mount', () => {
            console.log(this)
            this.data = this.opts.data
            this.round = this.opts.round ? parseInt(this.opts.round) : 10000
            this.scale = this.opts.scale
            this.update()
        })
});

riot.tag2('dm-exec-list', '<dm-exec each="{v,k in data}" name="{k}" price="{Math.round(getLastPrice(v) * 100) / 100 }⁗ buy=⁗{ Math.round(getVolume(v, side.BUY) * round) / round}" sell="{Math.round(getVolume(v, side.SELL) * round) / round }⁗ scale=⁗{ scale }⁗></dm-exec>}', '', '', function(opts) {
        this.on('mount', () => {
            this.data = this.opts.data
            this.round = this.opts.round ? parseInt(this.opts.round) : 10000
            this.scale = this.opts.scale
            this.update()
        })
});

riot.tag2('dm-exec', '<div class="bar"> <div class="item buy" riot-style="{buyStyle}"></div> <div class="text">{opts.buy}</div> </div> <div class="bar reverse"> <div class="item sell" riot-style="{sellStyle}"></div> <div class="text">{opts.sell}</div> </div> <div class="title">{opts.name}</div> <div class="lastprice">{opts.price}</div>', 'dm-exec,[data-is="dm-exec"]{ font-size: 12px; display: flex; } dm-exec .bar,[data-is="dm-exec"] .bar{ height: 16px; width: 100px; border: 1px solid rgba(200, 200, 200, 0.8); display: flex; flex-direction: row-reverse; } dm-exec .bar.reverse,[data-is="dm-exec"] .bar.reverse{ flex-direction: row; } dm-exec .bar .item,[data-is="dm-exec"] .bar .item{ height: 100%; transition: all 0.5s; } dm-exec .bar .item.sell,[data-is="dm-exec"] .bar .item.sell{ background-color: red; } dm-exec .bar .item.buy,[data-is="dm-exec"] .bar .item.buy{ background-color: blue; } dm-exec .bar .text,[data-is="dm-exec"] .bar .text{ position: absolute; } dm-exec .title,[data-is="dm-exec"] .title{ width: 60px; overflow: hidden; } dm-exec .lastprice,[data-is="dm-exec"] .lastprice{ width: 50px; }', '', function(opts) {
        this.on('update', () => {
            this.buyStyle = {
                width: this.opts.buy / this.scale + '%'
            }
            this.sellStyle = {
                width: this.opts.sell / this.scale + '%'
            }
            console.log(this)
        })
        this.on('mount', () => {
            this.scale = this.opts.scale ? this.opts.scale : 1
            this.update()
        })
});
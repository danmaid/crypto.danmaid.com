<dm-exec-mixed>
    <dm-exec if="{ data }" name="{ opts.name }" buy="{ Math.round(getMixedVolume(data, 'BUY') * round) / round }"
        sell="{ Math.round(getMixedVolume(data, 'SELL') * round) / round }" scale="{ scale }"></dm-exec>

    <script>
        this.on('mount', () => {
            this.data = this.opts.data
            this.round = this.opts.round ? parseInt(this.opts.round) : 10000
            this.scale = this.opts.scale
            this.update()
        })
    </script>
</dm-exec-mixed>

<dm-exec-list>
    <dm-exec each="{ v,k in data }" name="{ k }" price="{ Math.round(getLastPrice(v) * 100) / 100 }" buy="{ Math.round(getVolume(v, 'BUY') * round) / round }"
        sell="{ Math.round(getVolume(v, 'SELL') * round) / round }" scale="{ scale }"></dm-exec>

    <script>
        this.on('mount', () => {
            this.data = this.opts.data
            this.round = this.opts.round ? parseInt(this.opts.round) : 10000
            this.scale = this.opts.scale
            this.update()
        })
    </script>
</dm-exec-list>

<dm-exec>
    <div class="bar">
        <div class="item buy" style="{ buyStyle }"></div>
        <div class="text">{ opts.buy }</div>
    </div>
    <div class="bar reverse">
        <div class="item sell" style="{ sellStyle }"></div>
        <div class="text">{ opts.sell }</div>
    </div>
    <div class="title">{ opts.name }</div>
    <div class="lastprice">{ opts.price }</div>

    <style>
        :scope {
            font-size: 12px;
            display: flex;
        }

        .bar {
            height: 16px;
            width: 100px;
            border: 1px solid rgba(200, 200, 200, 0.8);
            display: flex;
            flex-direction: row-reverse;
        }

        .bar.reverse {
            flex-direction: row;
        }

        .bar .item {
            height: 100%;
            transition: all 0.5s;
        }

        .bar .item.sell {
            background-color: red;
        }

        .bar .item.buy {
            background-color: blue;
        }

        .bar .text {
            position: absolute;
        }

        .title {
            width: 60px;
            overflow: hidden;
            /* border-bottom: 1px dashed; */
        }

        .lastprice {
            width: 50px;
        }
    </style>

    <script>
        this.on('update', () => {
            this.buyStyle = {
                width: this.opts.buy / this.scale + '%'
            }
            this.sellStyle = {
                width: this.opts.sell / this.scale + '%'
            }
        })
        this.on('mount', () => {
            this.scale = this.opts.scale ? this.opts.scale : 1
            this.update()
        })
    </script>
</dm-exec>
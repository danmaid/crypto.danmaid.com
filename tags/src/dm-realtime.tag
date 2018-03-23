<!-- リアルタイムに流れてくるデータを表示して指定時間で消すだけ。 -->
<!--
    args: {
        stream: Rx.Observable # ストリームデータ
    }
-->
<dm-realtime>
    <div>{ lastprice }</div>
    <style>
        .buy {
            color: blue;
        }

        .sell {
            color: red;
        }
    </style>
    <script>
        this.on('mount', () => {
            let stream = this.opts.stream
            let target = this.root
            let self = this
            stream.subscribe(msg => {
                // 表示して消す。
                let tag = document.createElement('div')
                tag.innerText = msg.price + ' ' + msg.size
                if (msg.side == 'BUY') { tag.classList.add('buy') }
                else if (msg.side == 'SELL') { tag.classList.add('sell') }
                target.appendChild(tag)
                setTimeout(function () { target.removeChild(tag) }, 2000)

                // 最終約定価格を更新。
                self.lastprice = msg.price
                self.update()
            })
        })
    </script>
</dm-realtime>
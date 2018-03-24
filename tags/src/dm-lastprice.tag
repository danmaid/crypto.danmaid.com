<!-- リアルタイムに流れてくるデータの最新取引価格を表示するだけ。 -->
<!--
    args: {
        stream: Rx.Observable # ストリームデータ
    }
-->
<dm-lastprice>
    <div>{ lastprice }</div>
    <script>
        this.on('mount', () => {
            let stream = this.opts.stream
            let self = this
            stream.subscribe(msg => {
                // 最終約定価格を更新。
                self.lastprice = msg.price
                self.update()
            })
        })
    </script>
</dm-lastprice>
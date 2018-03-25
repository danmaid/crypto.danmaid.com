<!-- リアルタイムに流れてくるデータの最新取引価格を表示するだけ。 -->
<!--
    args: {
        stream: Rx.Observable # ストリームデータ
    }
-->
<dm-lastprice>
    <virtual>{ lastprice }</virtual>
    <script>
        this.on('mount', () => {
            let stream = this.opts.stream
            let self = this
            self.subscription = stream.subscribe(msg => {
                // 最終約定価格を更新。
                self.lastprice = msg.price
                self.update()
            })
        })

        this.on('unmount', () => {
            let self = this
            self.subscription.unsubscribe()
        })
    </script>
</dm-lastprice>
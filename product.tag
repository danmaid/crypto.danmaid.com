<product>
    <p class="devel">現在開発中のため、予告なく仕様変更される場合があります。自分で使うために作っているものなので「だいたい」です。自己責任でご利用ください。</p>

    <h2>リアルタイムトレードストリーム</h2>
    <p>各取引所が提供している取引履歴(trade)の Realtime API を RxJS のストリーム(Observable)で提供するモジュール。</p>

    <h3>使い方</h3>
    <pre><code class="html">&lt;html&gt;
&lt;body&gt;
    &lt;script src="https://unpkg.com/@reactivex/rxjs/dist/global/Rx.min.js"&gt;&lt;/script&gt;
    &lt;script src="https://cdn.pubnub.com/sdk/javascript/pubnub.4.20.2.js"&gt;&lt;/script&gt;
    &lt;script type="module"&gt;
        import \{ bitflyer_FX_BTC_JPY \} from 'http://crypto.danmaid.com/modules/src/executions.js';
        bitflyer_FX_BTC_JPY.subscribe(data => \{
            console.log(data);
        \})
    &lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;
</code></pre>

    <h3>データモデル</h3>
    <pre><code class="json">\{
    price: Number,
    size: Number,
    side: "BUY" or "SELL"
    + おまけ
\}</code></pre>

    <h3>対応取引所</h3>
    <table>
        <thead>
            <th>取引所</th>
            <th>オリジナルAPI</th>
            <th>通貨ペア</th>
            <th>export</th>
        </thead>
        <tbody>
            <tr>
                <td>bitFlyer</td>
                <td>Pubnub</td>
                <td>BTC/JPY
                    <br/>BTC/JPY FX
                    <br/>ETH/BTC</td>
                <td>bitflyer_BTC_JPY
                    <br/>bitflyer_FX_BTC_JPY
                    <br/>bitflyer_ETH_BTC</td>
            </tr>
            <tr>
                <td>Zaif</td>
                <td>WebSocket</td>
                <td>BTC/JPY
                    <br/>XEM/JPY
                    <br/>XEM/BTC
                    <br/>MONA/JPY
                    <br/>MONA/BTC</td>
                <td>zaif_BTC_JPY
                    <br/>zaif_XEM_JPY
                    <br/>zaif_XEM_BTC
                    <br/>zaif_MONA_JPY
                    <br/>zaif_MONA_BTC</td>
            </tr>
            <tr>
                <td>fisco</td>
                <td>WebSocket</td>
                <td>BTC/JPY</td>
                <td>fisco_BTC_JPY</td>
            </tr>
            <tr>
                <td>bitbank.cc</td>
                <td>Pubnub</td>
                <td>BTC/JPY</td>
                <td>bitbankcc_BTC_JPY</td>
            </tr>
            <tr>
                <td>coincheck</td>
                <td>WebSocket</td>
                <td>BTC/JPY</td>
                <td>coincheck_BTC_JPY</td>
            </tr>
            <tr>
                <td>bitfinex</td>
                <td>WebSocket</td>
                <td>BTC/USD</td>
                <td>bitfinex_BTC_USD</td>
            </tr>
            <tr>
                <td>bitmex</td>
                <td>WebSocket</td>
                <td>XBT/USD</td>
                <td>bitmex_XBT_USD</td>
            </tr>
            <tr>
                <td>binance</td>
                <td>WebSocket</td>
                <td>BTC/USDT</td>
                <td>binance_BTC_USDT</td>
            </tr>
        </tbody>
    </table>


    <h2>最終取引価格</h2>
    <h2>取引履歴</h2>

    <style>
        :scope .devel {
            color: red;
        }
    </style>

    <script>
        this.on('mount', () => {
            this.root.querySelectorAll('pre code').forEach(block => hljs.highlightBlock(block))
        })
    </script>
</product>
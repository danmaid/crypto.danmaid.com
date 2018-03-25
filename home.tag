<!-- サイトメインコンテンツ -->
<home>
    <p>提供ツールの実装サンプルを掲載しています。</p>
    <h2>最終取引価格</h2>
    <div class="container-outer">
        <div>
            <h3>BTC/JPY</h3>
            <div class="container">
                <div class="ltp-item">
                    <div class="market">bitFlyer</div>
                    <dm-lastprice stream="{ opts.exec.bitflyer_BTC_JPY }" class="price"></dm-lastprice>
                </div>
                <div class="ltp-item">
                    <div class="market">bitbank.cc</div>
                    <dm-lastprice stream="{ opts.exec.bitbankcc_BTC_JPY }" class="price"></dm-lastprice>
                </div>
                <div class="ltp-item">
                    <div class="market">Zaif</div>
                    <dm-lastprice stream="{ opts.exec.zaif_BTC_JPY }" class="price"></dm-lastprice>
                </div>
                <div class="ltp-item">
                    <div class="market">fisco</div>
                    <dm-lastprice stream="{ opts.exec.fisco_BTC_JPY }" class="price"></dm-lastprice>
                </div>
                <div class="ltp-item">
                    <div class="market">coincheck</div>
                    <dm-lastprice stream="{ opts.exec.coincheck_BTC_JPY }" class="price"></dm-lastprice>
                </div>
            </div>
        </div>
        <div>
            <h3>BTC/JPY FX</h3>
            <div class="container">
                <div class="ltp-item">
                    <div class="market">bitFlyer</div>
                    <dm-lastprice stream="{ opts.exec.bitflyer_FX_BTC_JPY }" class="price"></dm-lastprice>
                </div>
            </div>
        </div>
        <div>
            <h3>BTC/USD</h3>
            <div class="container">
                <div class="ltp-item">
                    <div class="market">bitfinex</div>
                    <dm-lastprice stream="{ opts.exec.bitfinex_BTC_USD }" class="price"></dm-lastprice>
                </div>
            </div>
        </div>
        <div>
            <h3>BTC/USD FX</h3>
            <div class="container">
                <div class="ltp-item">
                    <div class="market">bitmex</div>
                    <dm-lastprice stream="{ opts.exec.bitmex_XBT_USD }" class="price"></dm-lastprice>
                </div>
            </div>
        </div>
        <div>
            <h3>BTC/USDT</h3>
            <div class="container">
                <div class="ltp-item">
                    <div class="market">binance</div>
                    <dm-lastprice stream="{ opts.exec.binance_BTC_USDT }" class="price"></dm-lastprice>
                </div>
            </div>
        </div>
    </div>

    <h2>取引履歴</h2>
    <div class="container-outer">
        <div>
            <h3>BTC/JPY</h3>
            <div class="container">
                <div class="trade-item">
                    <div class="market">bitFlyer</div>
                    <dm-realtime stream="{ opts.exec.bitflyer_BTC_JPY }"></dm-realtime>
                </div>
                <div class="trade-item">
                    <div class="market">bitbank.cc</div>
                    <dm-realtime stream="{ opts.exec.bitbankcc_BTC_JPY }"></dm-realtime>
                </div>
                <div class="trade-item">
                    <div class="market">Zaif</div>
                    <dm-realtime stream="{ opts.exec.zaif_BTC_JPY }"></dm-realtime>
                </div>
                <div class="trade-item">
                    <div class="market">fisco</div>
                    <dm-realtime stream="{ opts.exec.fisco_BTC_JPY }"></dm-realtime>
                </div>
                <div class="trade-item">
                    <div class="market">coincheck</div>
                    <dm-realtime stream="{ opts.exec.coincheck_BTC_JPY }"></dm-realtime>
                </div>
            </div>
        </div>
        <div>
            <h3>BTC/JPY FX</h3>
            <div class="container">
                <div class="trade-item">
                    <div class="market">bitFlyer</div>
                    <dm-realtime stream="{ opts.exec.bitflyer_FX_BTC_JPY }"></dm-realtime>
                </div>
            </div>
        </div>
        <div>
            <h3>BTC/USD</h3>
            <div class="container">
                <div class="trade-item">
                    <div class="market">bitfinex</div>
                    <dm-realtime stream="{ opts.exec.bitfinex_BTC_USD }"></dm-realtime>
                </div>
            </div>
        </div>
        <div>
            <h3>BTC/USD FX</h3>
            <div class="container">
                <div class="trade-item">
                    <div class="market">bitmex(XBT)</div>
                    <dm-realtime stream="{ opts.exec.bitmex_XBT_USD }"></dm-realtime>
                </div>
            </div>
        </div>
        <div>
            <h3>BTC/USDT</h3>
            <div class="container">
                <div class="trade-item">
                    <div class="market">binance</div>
                    <dm-realtime stream="{ opts.exec.binance_BTC_USDT }"></dm-realtime>
                </div>
            </div>
        </div>
    </div>


    <!-- <div class="container">
        <div>
            <div>zaif_XEM_JPY</div>
            <dm-lastprice stream="{ opts.exec.zaif_XEM_JPY }"></dm-lastprice>
            <dm-realtime stream="{ opts.exec.zaif_XEM_JPY }"></dm-realtime>
        </div>
        <div>
            <div>zaif_XEM_BTC</div>
            <dm-lastprice stream="{ opts.exec.zaif_XEM_BTC }"></dm-lastprice>
            <dm-realtime stream="{ opts.exec.zaif_XEM_BTC }"></dm-realtime>
        </div>
        <div>
            <div>zaif_MONA_JPY</div>
            <dm-lastprice stream="{ opts.exec.zaif_MONA_JPY }"></dm-lastprice>
            <dm-realtime stream="{ opts.exec.zaif_MONA_JPY }"></dm-realtime>
        </div>
        <div>
            <div>zaif_MONA_BTC</div>
            <dm-lastprice stream="{ opts.exec.zaif_MONA_BTC }"></dm-lastprice>
            <dm-realtime stream="{ opts.exec.zaif_MONA_BTC }"></dm-realtime>
        </div>
        <div>
            <div>bitflyer_ETH_BTC</div>
            <dm-lastprice stream="{ opts.exec.bitflyer_ETH_BTC }"></dm-lastprice>
            <dm-realtime stream="{ opts.exec.bitflyer_ETH_BTC }"></dm-realtime>
        </div>
    </div> -->

    <style>
        .container-outer {
            display: flex;
            flex-wrap: wrap;
        }

        .container {
            display: flex;
        }

        .container>div {
            margin: 0 0.5em;
        }

        .ltp-item {
            border: 1px solid;
            border-color: rgba(0, 0, 0, 0.25);
            padding: 0.5em 1.5em;
        }

        .ltp-item .price {
            font-size: 1.5em;
        }

        .trade-item {
            border: 1px solid;
            border-color: rgba(0, 0, 0, 0.25);
            width: 10em;
            height: 20em;
            padding: 0.5em 1em;
            white-space: nowrap;
            overflow-y: auto;
            overflow-x: hidden;
        }
    </style>
    <script>
    </script>
</home>
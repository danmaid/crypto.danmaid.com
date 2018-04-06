<!-- サイトメインコンテンツ -->
<home>
    <p>提供ツールの実装サンプルを掲載しています。</p>
    <h2>最終取引価格</h2>
    <div class="container-outer">
        <div>
            <h3>BTC/JPY</h3>
            <div class="container">
                <a href="https://bitflyer.jp?bf=shwrhqqs" target="_blank">
                    <div class="ltp-item">
                        <div class="market">bitFlyer</div>
                        <dm-lastprice stream="{ opts.exec.bitflyer_BTC_JPY }" class="price"></dm-lastprice>
                    </div>
                </a>
                <div class="ltp-item">
                    <div class="market">bitbank.cc</div>
                    <dm-lastprice stream="{ opts.exec.bitbankcc_BTC_JPY }" class="price"></dm-lastprice>
                </div>
                <a href="https://zaif.jp?ac=v1qklgobx2" target="_blank">
                    <div class="ltp-item">
                        <div class="market">Zaif</div>
                        <dm-lastprice stream="{ opts.exec.zaif_BTC_JPY }" class="price"></dm-lastprice>
                    </div>
                </a>
                <div class="ltp-item">
                    <div class="market">fisco</div>
                    <dm-lastprice stream="{ opts.exec.fisco_BTC_JPY }" class="price"></dm-lastprice>
                </div>
                <a href="https://coincheck.com/ja/?c=_Keu1VgjTDg" target="_blank">
                    <div class="ltp-item">
                        <div class="market">coincheck</div>
                        <dm-lastprice stream="{ opts.exec.coincheck_BTC_JPY }" class="price"></dm-lastprice>
                    </div>
                </a>
            </div>
        </div>
        <div>
            <h3>BTC/JPY FX</h3>
            <div class="container">
                <a href="https://bitflyer.jp/Lightning?bf=shwrhqqs" target="_blank">
                    <div class="ltp-item">
                        <div class="market">bitFlyer</div>
                        <dm-lastprice stream="{ opts.exec.bitflyer_FX_BTC_JPY }" class="price"></dm-lastprice>
                    </div>
                </a>
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
                <a href="https://www.bitmex.com/register/XprwfJ" target="_blank">
                    <div class="ltp-item">
                        <div class="market">bitmex</div>
                        <dm-lastprice stream="{ opts.exec.bitmex_XBT_USD }" class="price"></dm-lastprice>
                    </div>
                </a>
            </div>
        </div>
        <div>
            <h3>BTC/USDT</h3>
            <div class="container">
                <a href="https://www.binance.com/?ref=20863976" target="_blank">
                    <div class="ltp-item">
                        <div class="market">binance</div>
                        <dm-lastprice stream="{ opts.exec.binance_BTC_USDT }" class="price"></dm-lastprice>
                    </div>
                </a>
            </div>
        </div>
    </div>

    <h2>取引履歴</h2>
    <div class="container-outer">
        <div>
            <h3>BTC/JPY</h3>
            <div class="container">
                <a href="https://bitflyer.jp?bf=shwrhqqs" target="_blank">
                    <div class="trade-item">
                        <div class="market">bitFlyer</div>
                        <dm-realtime stream="{ opts.exec.bitflyer_BTC_JPY }"></dm-realtime>
                    </div>
                </a>
                <div class="trade-item">
                    <div class="market">bitbank.cc</div>
                    <dm-realtime stream="{ opts.exec.bitbankcc_BTC_JPY }"></dm-realtime>
                </div>
                <a href="https://zaif.jp?ac=v1qklgobx2" target="_blank">
                    <div class="trade-item">
                        <div class="market">Zaif</div>
                        <dm-realtime stream="{ opts.exec.zaif_BTC_JPY }"></dm-realtime>
                    </div>
                </a>
                <div class="trade-item">
                    <div class="market">fisco</div>
                    <dm-realtime stream="{ opts.exec.fisco_BTC_JPY }"></dm-realtime>
                </div>
                <a href="https://coincheck.com/ja/?c=_Keu1VgjTDg" target="_blank">
                    <div class="trade-item">
                        <div class="market">coincheck</div>
                        <dm-realtime stream="{ opts.exec.coincheck_BTC_JPY }"></dm-realtime>
                    </div>
                </a>
            </div>
        </div>
        <div>
            <h3>BTC/JPY FX</h3>
            <div class="container">
                <a href="https://bitflyer.jp/Lightning?bf=shwrhqqs" target="_blank">
                    <div class="trade-item">
                        <div class="market">bitFlyer</div>
                        <dm-realtime stream="{ opts.exec.bitflyer_FX_BTC_JPY }"></dm-realtime>
                    </div>
                </a>
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
                <a href="https://www.bitmex.com/register/XprwfJ" target="_blank">
                    <div class="trade-item">
                        <div class="market">bitmex(XBT)</div>
                        <dm-realtime stream="{ opts.exec.bitmex_XBT_USD }"></dm-realtime>
                    </div>
                </a>
            </div>
        </div>
        <div>
            <h3>BTC/USDT</h3>
            <div class="container">
                <a href="https://www.binance.com/?ref=20863976" target="_blank">
                    <div class="trade-item">
                        <div class="market">binance</div>
                        <dm-realtime stream="{ opts.exec.binance_BTC_USDT }"></dm-realtime>
                    </div>
                </a>
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
            border-color: rgb(190, 190, 210);
            padding: 0.5em 1.5em;
        }

        .ltp-item .price {
            font-size: 1.5em;
        }

        .trade-item {
            border: 1px solid;
            border-color: rgb(190, 190, 210);
            width: 10em;
            height: 20em;
            padding: 0.5em 1em;
            white-space: nowrap;
            overflow-y: auto;
            overflow-x: hidden;
        }

        :scope a:link {
            color: inherit
        }

        :scope a:visited {
            color: inherit
        }

        :scope a:hover {
            color: inherit
        }

        :scope a:active {
            color: inherit
        }

        :scope a {
            text-decoration: none
        }
    </style>
    <script>
    </script>
</home>
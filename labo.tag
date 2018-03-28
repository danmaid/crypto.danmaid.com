<labo>
    <p>ここは、Product としてパッケージングする前の雑多なテスト環境です。要望が多ければパッケージングするかもってやつ。</p>
    <nav class="mdc-tab-bar" data-mdc-auto-init="MDCTabBar">
        <a class="mdc-tab" href="/labo/multiprice">マルチ価格（仮）</a>
        <a class="mdc-tab" href="/labo/multivolume">マルチ取引量（仮）</a>
        <span class="mdc-tab-bar__indicator"></span>
    </nav>
    <contents></contents>

    <style>
        :scope {
            display: block;
        }

        contents {
            padding: 8px;
        }
    </style>

    <script>
        route('/labo/multiprice', () => {
            riot.mount('contents', 'labo-multiprice', { exec: this.opts.exec })
        })
        route('/labo/multivolume', () => {
            riot.mount('contents', 'labo-multivolume', { exec: this.opts.exec })
        })
    </script>
</labo>

<labo-multiprice>
    <div class="container">
        <div class="ltp-item">
            <div class="market">bitFlyer</div>
            <dm-lastprice stream="{ opts.exec.bitflyer_BTC_JPY }" class="price"></dm-lastprice>
        </div>
        <div class="ltp-item">
            <div class="market">Zaif</div>
            <dm-lastprice stream="{ opts.exec.zaif_BTC_JPY }" class="price"></dm-lastprice>
        </div>
        <div class="ltp-item">
            <div class="market">bitbank</div>
            <dm-lastprice stream="{ opts.exec.bitbankcc_BTC_JPY }" class="price"></dm-lastprice>
        </div>
        <div class="ltp-item">
            <div class="market">coincheck</div>
            <dm-lastprice stream="{ opts.exec.coincheck_BTC_JPY }" class="price"></dm-lastprice>
        </div>
    </div>
    <canvas id="myChart"></canvas>

    <style>
        :scope {
            display: block;
        }

        .ltp-item {
            border: 1px solid;
            border-color: rgba(0, 0, 0, 0.25);
            padding: 0.5em 1.5em;
        }

        .ltp-item .price {
            font-size: 1.5em;
        }

        .container {
            display: flex;
        }

        .container>div {
            margin: 0 0.5em;
        }
    </style>

    <script>
        let label = new Array(300);
        let bitflyer = new Array(300);
        let zaif = new Array(300);
        let bitbank = new Array(300);
        let coincheck = new Array(300);

        this.on('mount', () => {
            let exec = this.opts.exec
            let target = this.root
            let self = this

            let ctx = document.getElementById('myChart').getContext('2d');
            let chart = new Chart(ctx, {
                // The type of chart we want to create
                type: 'line',

                // The data for our dataset
                data: {
                    labels: label,
                    datasets: [{
                        label: "bitFlyer",
                        backgroundColor: 'rgb(255, 99, 132)',
                        borderColor: 'rgb(255, 99, 132)',
                        fill: false,
                        data: bitflyer,
                        yAxisID: "y-axis-1",
                        pointRadius: 0,
                    }, {
                        label: "Zaif",
                        backgroundColor: 'rgb(100, 100, 255)',
                        borderColor: 'rgb(100, 100, 255)',
                        fill: false,
                        data: zaif,
                        yAxisID: "y-axis-1",
                        pointRadius: 0,
                    }, {
                        label: "bitbank",
                        backgroundColor: 'rgb(100, 255, 100)',
                        borderColor: 'rgb(100, 255, 100)',
                        fill: false,
                        data: bitbank,
                        yAxisID: "y-axis-1",
                        pointRadius: 0,
                    }, {
                        label: "coincheck",
                        backgroundColor: 'rgb(255, 100, 50)',
                        borderColor: 'rgb(255, 100, 50)',
                        fill: false,
                        data: coincheck,
                        yAxisID: "y-axis-1",
                        pointRadius: 0,
                    }]
                },

                // Configuration options go here
                options: {
                    responsive: true,
                    hoverMode: 'index',
                    stacked: false,
                    scales: {
                        yAxes: [{
                            type: "linear",
                            display: true,
                            position: "right",
                            id: "y-axis-1",
                        }],
                    }
                }
            });

            self.subscription = Rx.Observable.interval(1000).timestamp()
                .withLatestFrom(
                    exec.bitflyer_BTC_JPY,
                    exec.zaif_BTC_JPY,
                    exec.bitbankcc_BTC_JPY,
                    exec.coincheck_BTC_JPY
                )
                .subscribe(x => {
                    label.push((new Date(x[0].timestamp)).toLocaleTimeString())
                    label.shift()
                    bitflyer.push(x[1].price)
                    bitflyer.shift()
                    zaif.push(x[2].price)
                    zaif.shift()
                    bitbank.push(x[3].price)
                    bitbank.shift()
                    coincheck.push(x[4].price)
                    coincheck.shift()
                    chart.update()
                })
        })

        this.on('unmount', () => {
            let self = this
            self.subscription.unsubscribe()
        })

    </script>

</labo-multiprice>

<labo-multivolume>
    <div class="container">
        <div class="ltp-item" each="{ market in ds }" style="border-color: { market.color }">
            <div class="market">{ market.label }</div>
            <dm-lastprice stream="{ market.datasource }" class="price"></dm-lastprice>
        </div>
    </div>
    <canvas id="myChart"></canvas>

    <style>
        :scope {
            display: block;
        }

        .ltp-item {
            border: 1px solid;
            border-color: rgba(0, 0, 0, 0.25);
            padding: 0.5em 1.5em;
        }

        .ltp-item .price {
            font-size: 1.5em;
        }

        .container {
            display: flex;
        }

        .container>div {
            margin: 0 0.5em;
        }
    </style>

    <script>
        let label = new Array(30)
        this.subscriptions = []

        this.on('mount', () => {
            let exec = this.opts.exec
            let target = this.root
            let self = this

            let o = [{
                datasource: exec.bitflyer_BTC_JPY,
                label: "bitFlyer",
                color: "#F44336",
                leverage: 1
            }, {
                datasource: exec.zaif_BTC_JPY,
                label: "Zaif",
                color: "#E91E63",
                leverage: 1
            }, {
                datasource: exec.bitbankcc_BTC_JPY,
                label: "bitbank",
                color: "#9C27B0",
                leverage: 1
            }, {
                datasource: exec.coincheck_BTC_JPY,
                label: "coincheck",
                color: "#673AB7",
                leverage: 1
            }, {
                datasource: exec.bitflyer_FX_BTC_JPY,
                label: "bitFlyerFX",
                color: "#3F51B5",
                leverage: 15
            }, {
                datasource: exec.bitfinex_BTC_USD,
                label: "bitfinex",
                color: "#2196F3",
                leverage: 1
            }, {
                datasource: exec.bitmex_XBT_USD.map(x => { x.size = x.homeNotional; return x }),
                label: "bitmex",
                color: "#03A9F4",
                leverage: 100
            }, {
                datasource: exec.binance_BTC_USDT,
                label: "binance",
                color: "#00BCD4",
                leverage: 1
            }]
            self.ds = o
            self.update()

            let buyset = []
            let sellset = []
            datasource = {}
            o.forEach(data => {
                datasource[data.label] = {
                    buy: (new Array(30)).fill(0),
                    sell: (new Array(30)).fill(0)
                }
                buyset.push({
                    label: data.label,
                    backgroundColor: data.color,
                    borderColor: data.color,
                    pointRadius: 0,
                    data: datasource[data.label].buy
                })
                sellset.push({
                    label: data.label,
                    backgroundColor: data.color,
                    borderColor: data.color,
                    pointRadius: 0,
                    data: datasource[data.label].sell
                })
            })

            self.subscriptions.push(
                Rx.Observable.interval(5000).timestamp()
                    .withLatestFrom(o.map(data => data.datasource))
                    .subscribe(x => {
                        Object.keys(datasource).forEach(key => {
                            datasource[key].buy.push(0)
                            datasource[key].buy.shift()
                            datasource[key].sell.push(0)
                            datasource[key].sell.shift()
                        })
                        label.push((new Date(x[0].timestamp)).toLocaleTimeString())
                        label.shift()
                    })
            )
            self.subscriptions.push(
                Rx.Observable.interval(500).timestamp()
                    .subscribe(x => {
                        chart.update()
                    })
            )

            o.forEach(data => {
                let source = data.datasource.share()
                self.subscriptions.push(
                    source.filter(x => x.side == 'BUY')
                        .subscribe(x => {
                            datasource[data.label].buy[29] += parseFloat(x.size)
                        })
                )
                self.subscriptions.push(
                    source.filter(x => x.side == 'SELL')
                        .subscribe(x => {
                            datasource[data.label].sell[29] -= parseFloat(x.size)
                        })
                )
            })

            let ctx = document.getElementById('myChart').getContext('2d');
            let chart = new Chart(ctx, {
                type: 'bar',

                data: {
                    labels: label,
                    datasets: buyset.concat(sellset)
                },

                options: {
                    responsive: true,
                    hoverMode: 'index',
                    scales: {
                        xAxes: [{
                            stacked: true
                        }],
                        yAxes: [{
                            stacked: true,
                            ticks: {
                                min: -120,
                                max: 120
                            }
                        }],
                    },
                    legend: {
                        display: false
                    }
                }
            })
        })

        this.on('unmount', () => {
            let self = this
            self.subscriptions.forEach(sub => sub.unsubscribe())
        })

    </script>

</labo-multivolume>
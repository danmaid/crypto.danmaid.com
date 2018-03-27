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
        let label = new Array(30)
        let bitflyerBuy = (new Array(30)).fill(0)
        let bitflyerSell = (new Array(30)).fill(0)
        let zaifBuy = (new Array(30)).fill(0)
        let zaifSell = (new Array(30)).fill(0)
        let bitbankBuy = (new Array(30)).fill(0)
        let bitbankSell = (new Array(30)).fill(0)
        let coincheckBuy = (new Array(30)).fill(0)
        let coincheckSell = (new Array(30)).fill(0)
        this.subscriptions = []

        this.on('mount', () => {
            let exec = this.opts.exec
            let target = this.root
            let self = this

            let ctx = document.getElementById('myChart').getContext('2d');
            let chart = new Chart(ctx, {
                // The type of chart we want to create
                type: 'bar',

                // The data for our dataset
                data: {
                    labels: label,
                    datasets: [{
                        label: "bitFlyer",
                        backgroundColor: 'rgb(255, 99, 132)',
                        borderColor: 'rgb(255, 99, 132)',
                        data: bitflyerBuy,
                        pointRadius: 0,
                    }, {
                        label: "Zaif",
                        backgroundColor: 'rgb(100, 100, 255)',
                        borderColor: 'rgb(100, 100, 255)',
                        data: zaifBuy,
                        pointRadius: 0,
                    }, {
                        label: "bitbank",
                        backgroundColor: 'rgb(100, 255, 100)',
                        borderColor: 'rgb(100, 255, 100)',
                        data: bitbankBuy,
                        pointRadius: 0,
                    }, {
                        label: "coincheck",
                        backgroundColor: 'rgb(255, 100, 50)',
                        borderColor: 'rgb(255, 100, 50)',
                        data: coincheckBuy,
                        pointRadius: 0,
                    }, {
                        label: "bitFlyer",
                        backgroundColor: 'rgb(255, 99, 132)',
                        borderColor: 'rgb(255, 99, 132)',
                        data: bitflyerSell,
                        pointRadius: 0,
                    }, {
                        label: "Zaif",
                        backgroundColor: 'rgb(100, 100, 255)',
                        borderColor: 'rgb(100, 100, 255)',
                        data: zaifSell,
                        pointRadius: 0,
                    }, {
                        label: "bitbank",
                        backgroundColor: 'rgb(100, 255, 100)',
                        borderColor: 'rgb(100, 255, 100)',
                        data: bitbankSell,
                        pointRadius: 0,
                    }, {
                        label: "coincheck",
                        backgroundColor: 'rgb(255, 100, 50)',
                        borderColor: 'rgb(255, 100, 50)',
                        data: coincheckSell,
                        pointRadius: 0,
                    }]
                },

                // Configuration options go here
                options: {
                    responsive: true,
                    hoverMode: 'index',
                    scales: {
                        xAxes: [{
                            stacked: true
                        }],
                        yAxes: [{
                            stacked: true
                        }],
                    },
                    legend: {
                        display: false
                    }
                }
            });

            self.subscriptions.push(
                Rx.Observable.interval(5000).timestamp()
                    .withLatestFrom(
                        exec.bitflyer_BTC_JPY,
                        exec.zaif_BTC_JPY,
                        exec.bitbankcc_BTC_JPY,
                        exec.coincheck_BTC_JPY
                    )
                    .subscribe(x => {
                        bitflyerBuy.push(0)
                        bitflyerBuy.shift()
                        bitflyerSell.push(0)
                        bitflyerSell.shift()
                        zaifBuy.push(0)
                        zaifBuy.shift()
                        zaifSell.push(0)
                        zaifSell.shift()
                        bitbankBuy.push(0)
                        bitbankBuy.shift()
                        bitbankSell.push(0)
                        bitbankSell.shift()
                        coincheckBuy.push(0)
                        coincheckBuy.shift()
                        coincheckSell.push(0)
                        coincheckSell.shift()
                        label.push((new Date(x[0].timestamp)).toLocaleTimeString())
                        label.shift()
                        chart.update()
                    })
            )

            let bitflyer = exec.bitflyer_BTC_JPY.share()
            self.subscriptions.push(
                bitflyer.filter(x => x.side == 'BUY')
                    .subscribe(x => {
                        bitflyerBuy[bitflyerBuy.length - 1] += x.size
                    })
            )
            self.subscriptions.push(
                bitflyer.filter(x => x.side == 'SELL')
                    .subscribe(x => {
                        bitflyerSell[bitflyerSell.length - 1] -= x.size
                    })
            )

            let zaif = exec.zaif_BTC_JPY.share()
            self.subscriptions.push(
                zaif.filter(x => x.side == 'BUY')
                    .subscribe(x => {
                        zaifBuy[zaifBuy.length - 1] += x.size
                    })
            )
            self.subscriptions.push(
                zaif.filter(x => x.side == 'SELL')
                    .subscribe(x => {
                        zaifSell[zaifSell.length - 1] -= x.size
                    })
            )

            let bitbank = exec.bitbankcc_BTC_JPY.share()
            self.subscriptions.push(
                bitbank.filter(x => x.side == 'BUY')
                    .subscribe(x => {
                        bitbankBuy[bitbankBuy.length - 1] += x.size
                    })
            )
            self.subscriptions.push(
                bitbank.filter(x => x.side == 'SELL')
                    .subscribe(x => {
                        bitbankSell[bitbankSell.length - 1] -= x.size
                    })
            )

            let coincheck = exec.coincheck_BTC_JPY.share()
            self.subscriptions.push(
                coincheck.filter(x => x.side == 'BUY')
                    .subscribe(x => {
                        coincheckBuy[coincheckBuy.length - 1] += x.size
                    })
            )
            self.subscriptions.push(
                coincheck.filter(x => x.side == 'SELL')
                    .subscribe(x => {
                        coincheckSell[coincheckSell.length - 1] -= x.size
                    })
            )
        })

        this.on('unmount', () => {
            let self = this
            self.subscriptions.forEach(sub => sub.unsubscribe())
        })

    </script>

</labo-multivolume>
<labo>
    <p>ここは、Product としてパッケージングする前の雑多なテスト環境です。要望が多ければパッケージングするかもってやつ。</p>
    <canvas id="myChart"></canvas>

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

</labo>
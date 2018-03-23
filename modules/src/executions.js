// require Rx.js
// <script src="https://unpkg.com/@reactivex/rxjs/dist/global/Rx.min.js"></script>

// bitflyer
// require pubnub.js
// <script src="https://cdn.pubnub.com/sdk/javascript/pubnub.4.20.2.js"></script>
export const bitflyer_BTC_JPY = Rx.Observable.create(observer => {
    let exec = new PubNub({
        subscribeKey: 'sub-c-52a9ab50-291b-11e5-baaa-0619f8945a4f'
    });
    exec.addListener({
        message: function (message) {
            observer.next(message.message);
        }
    });
    exec.subscribe({
        channels: ['lightning_executions_BTC_JPY']
    });
})
.flatMap(msg => msg)
.share();

export const bitflyer_FX_BTC_JPY = Rx.Observable.create(observer => {
    let exec = new PubNub({
        subscribeKey: 'sub-c-52a9ab50-291b-11e5-baaa-0619f8945a4f'
    });
    exec.addListener({
        message: function (message) {
            observer.next(message.message);
        }
    });
    exec.subscribe({
        channels: ['lightning_executions_FX_BTC_JPY']
    });
})
.flatMap(msg => msg)
.share();

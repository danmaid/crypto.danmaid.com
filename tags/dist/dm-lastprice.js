

riot.tag2('dm-lastprice', '<virtual>{lastprice}</virtual>', '', '', function(opts) {
        this.on('mount', () => {
            let stream = this.opts.stream
            let self = this
            self.subscription = stream.subscribe(msg => {

                self.lastprice = msg.price
                self.update()
            })
        })

        this.on('unmount', () => {
            let self = this
            self.subscription.unsubscribe()
        })
});
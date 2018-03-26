

riot.tag2('dm-realtime', '', 'dm-realtime .buy,[data-is="dm-realtime"] .buy{ color: blue; } dm-realtime .sell,[data-is="dm-realtime"] .sell{ color: red; }', '', function(opts) {
        this.on('mount', () => {
            let stream = this.opts.stream
            let target = this.root
            let self = this
            self.subscription = stream.subscribe(msg => {

                let tag = document.createElement('div')
                tag.innerText = msg.price + ' ' + msg.size
                if (msg.side == 'BUY') { tag.classList.add('buy') }
                else if (msg.side == 'SELL') { tag.classList.add('sell') }
                target.appendChild(tag)
                setTimeout(function () { target.removeChild(tag) }, 2000)
            })
        })

        this.on('unmount', () => {
            let self = this
            self.subscription.unsubscribe()
        })
});
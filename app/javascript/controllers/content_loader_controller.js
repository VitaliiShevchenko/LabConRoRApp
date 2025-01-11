import { Controller} from "@hotwired/stimulus"

export default class extends Controller {
    // static values = { url: String }
    // static intervalValues = { refresh: String}

    static values = { url: String, refreshInterval: Number }

    connect() {
        // console.log("connectStart")
        this.load()

        if (this.hasRefreshIntervalValue) {
            this.startRefreshing()
        }
        // console.log("connect")
    }

    load() {
        fetch(this.urlValue)
            .then(response => response.text())
            .then(html   => this.element.innerHTML = html)
    }

    startRefreshing(){
        this.refreshTimer = setInterval(()=>{
            this.load()
        }, this.refreshIntervalValue)
    }

    stopRefreshing(){
        if(this.refreshTimer){
            clearTimeout(this.refreshTimer)
        }
    }

    disconnect() {
        this.stopRefreshing()
    }
}
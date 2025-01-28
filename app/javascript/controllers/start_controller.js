import {Controller} from "@hotwired/stimulus"
import initCharts from "../packs/init_charts";

export default class extends Controller {
    static values = { intervalID: Number }
    connect(){
        this.intervalID = 0
        initCharts()
    }

    start(){
        if (!!this.intervalID) return // restricts more than one click on "Start" button

        const {sckElem, testIDElem, timeTrialElem, ledElem} = this.getElements()

        const start_url =
            `http://localhost:3000/examinations/start?time_trial=${timeTrialElem.value}&test_id=${testIDElem.value}`
        fetch(start_url, { method: `GET` });

    this.run_update(sckElem, timeTrialElem, ledElem)
    }

    continue(){
        if (!!this.intervalID) return // restricts more than one click on "Continue" button

        const {sckElem, testIDElem, timeTrialElem, ledElem} = this.getElements()

        const url = `http://localhost:3000/examinations/continue?time_trial=${timeTrialElem.value}&test_id=${testIDElem.value}&sck=${sckElem.value}`
        fetch(url, { method: `GET` });

        this.run_update(sckElem, timeTrialElem, ledElem)
    }

    finish(){
        clearInterval( this.intervalID )
        fetch('http://localhost:3000/examinations/finish', { method: 'GET' });
        this.intervalID = 0
    }

    run_update(sckElem, timeTrialElem, ledElem){
        this.intervalID =
            setInterval(() => {
                fetch('http://localhost:3000/examinations/chart_update', {method: 'GET'})
                    .then((response)=>{return response.json()})
                    .then((data)=>{
                        ledElem.textContent = data[0]-data[1]
                        console.log(ledElem)
                        ledElem.style.background = `rgb(${data[0] % 2 ? 0 : 255},${data[0] % 2 ? 255 : 0},0)`
                        if(sckElem.value >= Number(timeTrialElem.value)) ledElem.style.background = `linear-gradient(rgb(0,128,0),rgb(0,255,0)`
                    })

                if (sckElem.value++ >= Number(timeTrialElem.value)) {
                    clearInterval(this.intervalID)
                    this.intervalID = 0
                }
            }, 1000)
    }

    getElements(){
        const sckElem       = document.getElementById("test_sck")
        const testIDElem    = document.getElementById("test_id")
        const timeTrialElem = document.getElementById("test_total_time")
        const ledElem       = document.getElementById("led")

        return {sckElem, testIDElem, timeTrialElem, ledElem}
    }
}
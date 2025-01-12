import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "radio" ]

    toggle(event){
        const clickedRadio = event.target
        const radios = document.querySelectorAll("input[name='brands']:checked")

        radios.forEach((radio) => radio.checked = false )

        clickedRadio.checked = true
    }
}
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "radio" ]

    toggle(event){
        const clickedRadio = event.target
        const radios = document.querySelectorAll("input[name='brands']:checked")

        radios.forEach((radio) => radio.checked = false )

        clickedRadio.checked = true

        this.changeURL(clickedRadio)
    }

    changeURL (clickedRadio) {
        const selectorNextTable = ".form-btn-next-radio-toggle-controller"
        const formBtnNxt = document.querySelector(selectorNextTable).children[0]

        formBtnNxt.action = formBtnNxt.action.replace(/id=\d+/, `id=${clickedRadio.id}`)
    }
}
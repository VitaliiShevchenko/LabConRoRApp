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
        const divContainersSelector = ".form-btn-next-radio-toggle-controller"
        const nodeListDivs = document.querySelectorAll(divContainersSelector)

        nodeListDivs.forEach((div) => {
            let form = div.children[0]
            form.action = form.action.replace(/\d{1,}$/, `${clickedRadio.id}`)
        })
    }
}
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "radio" ]

    toggle(event){
        const clickedCheckBox = event.target
        const checkBoxes = document.querySelectorAll("input[name='checkBox']:checked")

        checkBoxes.forEach((checkBox) => checkBox.checked = false )

        clickedCheckBox.checked = true

        this.changeURL(clickedCheckBox)
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
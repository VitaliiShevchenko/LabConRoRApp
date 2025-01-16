import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "check" ]

    clickRow(event) {
        event.preventDefault()
        const clickedCheckBox = event.target.parentElement.children[0].children[0]
        if (clickedCheckBox) {

            this.allCheckBoxesOff()
            clickedCheckBox.checked = true

            this.changeURL(clickedCheckBox)
        }
    }

    allCheckBoxesOff(){
        const checkBoxes = document.querySelectorAll("input[name='checkBox']:checked")

        checkBoxes.forEach((checkBox) => checkBox.checked = false )
    }

    changeURL (clickedCheckBox) {
        const divContainersSelector = ".form-check-toggle-controller"
        const nodeListDivs = document.querySelectorAll(divContainersSelector)

        nodeListDivs.forEach((div) => {
            let form = div.children[0]
            form.action = form.action.replace(/\d{1,}$/, `${clickedCheckBox.id}`)
        })
    }
}
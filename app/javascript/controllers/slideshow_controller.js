import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "slide" ]
    // static values = { index : { type: Number, default: 2} }
    static values = { index: Number, effect: { type: String, default: "kenburns" } }
    // initialize(){
    //     this.index = 0
    //     this.showCurrentSlide()
    // }

    showCurrentSlide(){
        this.slideTargets.forEach((element, index) =>{
            element.hidden = index !== this.indexValue
        })
    }

    previous() {
        this.indexValue--
        // this.showCurrentSlide()
    }

    next(){
        this.indexValue++
        // this.showCurrentSlide()
    }

    indexValueChanged() {
        this.showCurrentSlide()
    }
}
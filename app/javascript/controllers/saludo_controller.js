import { Controller } from "@hotwired/stimulus"

// Conecta con data-controller="saludo"
export default class extends Controller {
  static targets = ["nombre"]

  saludar() {
    const nombre = this.nombreTarget.value
    alert(`Ey dut, ${nombre}!`)
  }
}

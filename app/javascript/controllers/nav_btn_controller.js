import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nav-btn"
export default class extends Controller {
  connect() {
    // console.log('hello');
  }

  default() {
    document.getElementById('n').classList.add('hidden');
    document.getElementById('n-swap').classList.remove('hidden');
  }

  swap() {
    document.getElementById('n').classList.remove('hidden');
    document.getElementById('n-swap').classList.add('hidden');
  }
}

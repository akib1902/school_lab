// script.js

window.addEventListener('DOMContentLoaded', () => {
    const dateInput = document.getElementById('event_date');
    if (dateInput) {
        // set min date to today
        const today = new Date().toISOString().split('T')[0];
        dateInput.setAttribute('min', today);
    }
});

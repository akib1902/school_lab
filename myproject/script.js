
const form = document.getElementById("form1");
const uname = document.getElementById("uname");
const fname = document.getElementById("fname");
const lname = document.getElementById("lname");
const email = document.getElementById("email");
const phone = document.getElementById("phnum");
const pass = document.getElementById("pass");
const euname = document.getElementById("euname");
const efname = document.getElementById("efname");
const elname = document.getElementById("elname");
const eemail = document.getElementById("eemail");
const ephone = document.getElementById("ephone");

const ec = document.getElementById("ec");
const el = document.getElementById("el");
const ed = document.getElementById("ed");
const es = document.getElementById("es");
function clearErrors() {
    euname.textContent = "";
    efname.textContent = "";
    elname.textContent = "";
    eemail.textContent = "";
    ephone.textContent = "";

    ec.textContent = "";
    el.textContent = "";
    ed.textContent = "";
    es.textContent = "";
}
function validateUsername() {
    const value = uname.value.trim();
    const regex = /^[a-zA-Z0-9_]{3,}$/;

    if (value === "") {
        euname.textContent = "Username is required.";
        return false;
    } else if (!regex.test(value)) {
        euname.textContent = "Username must be at least 3 characters, letters/numbers/underscore only.";
        return false;
    }
    return true;
}
function validateFirstName() {
    const value = fname.value.trim();
    const regex = /^[a-zA-Z\s]+$/;

    if (value === "") {
        efname.textContent = "First name is required.";
        return false;
    } else if (!regex.test(value)) {
        efname.textContent = "First name should contain letters only.";
        return false;
    }
    return true;
}

function validateLastName() {
    const value = lname.value.trim();
    const regex = /^[a-zA-Z\s]+$/;

    if (value === "") {
        elname.textContent = "Last name is required.";
        return false;
    } else if (!regex.test(value)) {
        elname.textContent = "Last name should contain letters only.";
        return false;
    }
    return true;
}
function validateEmail() {
    const value = email.value.trim();
    const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (value === "") {
        eemail.textContent = "Email is required.";
        return false;
    } else if (!regex.test(value)) {
        eemail.textContent = "Please enter a valid email address.";
        return false;
    }
    return true;
}
function validatePhone() {
    const value = phone.value.trim();
    const regex = /^[0-9]{10,15}$/;

    if (value === "") {
        ephone.textContent = "Mobile number is required.";
        return false;
    } else if (!regex.test(value)) {
        ephone.textContent = "Mobile number should be 10–15 digits.";
        return false;
    }
    return true;
}
function validatePassword() {
    const value = pass.value;

    let isValid = true;
    if (value.length < 8) {
        el.textContent = "Password must be at least 8 characters long.";
        isValid = false;
    } else {
        el.textContent = "";
    }
    if (!/[A-Z]/.test(value)) {
        ec.textContent = "Password must contain at least one uppercase letter.";
        isValid = false;
    } else {
        ec.textContent = "";
    }
    if (!/[0-9]/.test(value)) {
        ed.textContent = "Password must contain at least one digit.";
        isValid = false;
    } else {
        ed.textContent = "";
    }
    if (!/[!@#$%^&*(),.?":{}|<>]/.test(value)) {
        es.textContent = "Password must contain at least one special character.";
        isValid = false;
    } else {
        es.textContent = "";
    }

    return isValid;
}

pass.addEventListener("input", validatePassword);
form.addEventListener("submit", function (e) {
    clearErrors();

    let isFormValid = true;

    if (!validateUsername()) isFormValid = false;
    if (!validateFirstName()) isFormValid = false;
    if (!validateLastName()) isFormValid = false;
    if (!validateEmail()) isFormValid = false;
    if (!validatePhone()) isFormValid = false;
    if (!validatePassword()) isFormValid = false;

    if (!isFormValid) {
        e.preventDefault();
    } else {
        alert("Registration successful!");
    }
});

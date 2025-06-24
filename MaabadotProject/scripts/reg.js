function toggleForm() {
    if (document.getElementById('login-radio').checked) {
        document.getElementById('login-form').style.display = "block";
        document.getElementById('register-form').style.display = "none";
    } else if (document.getElementById('register-radio').checked) {
        document.getElementById('login-form').style.display = "none";
        document.getElementById('register-form').style.display = "block";
        document.body.style.background = 'linear-gradient(to bottom, #1976d2, #05264d)';
    }
}

function isDigit(ch) {
    if (ch >= "0" && ch <= "9") {
        return true;
    }
    return false;
}

function isLetter(ch) {
    if ((ch >= "a" && ch <= "z") || (ch >= "A" && ch <= "Z")) {
        return true;
    }
    return false;
}

function whatvalidate() {
    if (document.getElementById('register-radio').checked) {
        return regvalidateForm();
    }
    return logvalidate();
}

function regvalidateForm() {
    console.log('validateForm called');
    var res = true;
    res = userNameval() && res;
    res = passwordval() && res;
    res = confirmFun() && res;
    res = phonevalid() && res;
    res = mailvalid() && res;
    return res; 
}
function userNameval() {
    var userName = document.getElementById("name").value;
    var msgBox = document.getElementById("userNameMsg");

    if (userName.length == 0) {
        msgBox.innerHTML = "You must enter a username";
        return false;
    }
    else if (userName.length >= 50) {
        msgBox.innerHTML = "username must be less than 50 chars";
        return false;
    }
    if (!isLetter(userName[0])) {
        msgBox.innerHTML = "Username must start with a letter";
        return false;
    }
    msgBox.innerHTML = "";
    return true;
}

function passwordval() {
    var pass = document.getElementById("password").value;
    var msgBox = document.getElementById("passwordMsg");

    console.log("password validation", pass);
    if (pass.length < 7) {
        msgBox.innerHTML = "Password must contain at least 7 characters";
        return false;
    }

    var specialChar = /[@!#$%^&*()-+]/;
    if (!specialChar.test(pass)) {
        msgBox.innerHTML = "Password must contain at least one special character";
        return false;
    }

    msgBox.innerHTML = "";
    return true;
}
function confirmFun() {
    var pass = document.getElementById("password").value;
    var confirm = document.getElementById("passcon").value;
    var msgBox = document.getElementById("passconMsg");

    console.log("confirm password validation", pass, confirm);
    if (confirm.length == 0) {
        msgBox.innerHTML = "please confirm the password";
        return false;
    }
    if (pass != confirm) {
        msgBox.innerHTML = "Confirm password doesn't match password";
        return false;
    }
    msgBox.innerHTML = "";
    return true;
}
function phonevalid() {
    var phone = document.getElementById("phone").value;
    var msgBox = document.getElementById("phoneMsg");

    console.log("phone validation", phone);
    var reg = /^0{1}(2|3|4|6|8|9|5[2-8]|73)-[1-9]\d{6}$/;
    if (phone.length == 0) {
        msgBox.innerHTML = "Phone number is illegal";
        return false;
    }
    if (!reg.test(phone)) {
        msgBox.innerHTML = "Phone number is illegal";
        return false;
    }
    msgBox.innerHTML = "";
    return true;
}
function mailvalid() {
    var email = document.getElementById("email").value;
    var msgBox = document.getElementById("emailMsg");

    console.log("email validation", email);
    var reg = /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,4})+$/;
    if (email.length == 0) {
        msgBox.innerHTML = "enter email addres";
        return false; }
    if (!reg.test(email)) {
        msgBox.innerHTML = "Invalid email address";
        return false;
    }
    msgBox.innerHTML = "";
    return true;
}


function logvalidate() {
    console.log('validateForm called');
    var res = true;
    res = loguser() && res;
    res = logpass() && res;
    res = logmail() && res;
    return res;
}

function loguser() {
    var userName = document.getElementById("name-lg").value;
    var msgBox = document.getElementById("lognameMsg");
    if (userName.length == 0) {
        msgBox.innerHTML = "You must enter a username";
        return false;
    }
    msgBox.innerHTML = "";
    return true;
}

function logpass() {
    var pass = document.getElementById("password-lg").value;
    var msgBox = document.getElementById("logpassMsg");

    console.log("password validation", pass);
    if (pass.length ==0) {
        msgBox.innerHTML = "Enter the password";
        return false;
    }

    msgBox.innerHTML = "";
    return true;
}

function logmail() {
    var email = document.getElementById("email-lg").value;
    var msgBox = document.getElementById("logemailMsg");
    if (email.length == 0) {
        msgBox.innerHTML = "enter email addres";
        return false;
    }
    msgBox.innerHTML = "";
    return true;
}
<%@ Page Language="C#" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="register" %>

<!DOCTYPE html>
<html lang="he">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>הרשמה</title>
    <link href="stylesheets\register.css" rel="stylesheet" />
    <script src="scripts\reg.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const inputDate = document.getElementById('dateInput');
            const today = new Date().toISOString().split('T')[0]; // Get today's date in YYYY-MM-DD format
            inputDate.setAttribute('min', today); // Set the min attribute to today's date

        });

    </script>
</head>
<body>
        <div>
            <div class="header-wrapper">
                <h1>מעבדות בפיזיקה</h1>
                <a href="main.aspx"><img src="img/logo.png" alt="Logo" class="logo"></a>
            </div>
            <hr>
            <div class="container" >
            <input type="radio" name="toggle" id="login-radio" checked onclick="toggleForm('login')">
        <input type="radio" name="toggle" id="register-radio" onclick="toggleForm('register')">
    <label for="login-radio" class="btn">כניסה</label>
    <label for="register-radio" class="btn">הרשמה</label>
    <form method="post" runat="server" id="mainform" onsubmit="return whatvalidate()">
    <div class="form-wrapper">
        <div id="login-form">
            <h2>כניסה</h2>
            <label id="LBLEROR" class="error" runat="server"></label>
     
            <label id="lognameMsg" for="mail" class="error"></label>
            <input type="text" placeholder="שם משתמש"  name="lgname" id="name-lg" >
            <label id="logemailMsg" for="mail" class="error"></label>
            <input type="email" placeholder="אימייל"  name="lgemail" id="email-lg" >
            <label id="logpassMsg" for="mail" class="error"></label>
            <input type="password" placeholder="סיסמה"  id="password-lg" name="lgpassword">
            <input type="submit" name="login" value="התחבר" >
            <input type="reset" value="איפוס">
        </div>
       <div id="register-form" >
            <h2>הרשמה</h2>
            <label id="REGERROR" class="error" runat="server"></label>
            <label id="userNameMsg" for="username" class="error"></label>
            <input type="text" placeholder="שם משתמש"  name="name" onchange="userNameval()" id="name" >

            <label id="emailMsg" for="mail" class="error"></label>
            <input type="email" placeholder="אימייל"  name="email" id="email" onchange="mailvalid()">

            <label id="phoneMsg" for="phone" class="error"></label>
            <input type="text" name="phone" placeholder="טלפון" id="phone"  onchange="phonevalid()">
            
            <label id="passwordMsg" for="password" class="error"></label>
            <input type="password" id="password" placeholder="סיסמה" onchange="passwordval()" name="password" >

            <label id="passconMsg" for="passcon" class="error"></label>
            <input type="password" id="passcon" placeholder="אישור סיסמה" name="confirm-password">

            <label>עד איזה תעריך המנוי?</label>
            <input type="date" id="dateInput" placeholder="עד התעריך" name="subscription-date" >
            <input type="submit" name="register" value="הרשם">
            <input type="reset" value="איפוס">
        </div>
       </div>
    </form>
</div>

            <footer>כל הזכויות שמורות ל איתן רויזנגורט &copy;</footer>
        </div>
</body>
</html>

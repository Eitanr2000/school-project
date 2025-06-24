<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="main.aspx.cs" Inherits="main" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" href="stylesheets/index.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="wrapper">
    <div class="maabada">
        <img src="img/free_fall.jpg" class="maabada-img">
        <p class="maabada-text">נפילה חופשית</p>
        <button class="maabada-button" onclick="location.href='sites/freefall.aspx'" type="button"><span>ללמוד<br>נפילה חופשית!</span></button>
    </div>
    <div class="maabada">
        <img src="img/newton.jpg" class="maabada-img">
        <p class="maabada-text">חוק שני של ניוטון</p>
        <button class="maabada-button" onclick="location.href='sites/mewton.aspx'" type="button"><span>ללמוד<br>חוק שני של ניוטון!</span></button>
    </div>
    <div class="maabada">
        <img src="img/hashmal.jpg" class="maabada-img">
        <p class="maabada-text">כא"מ ומתח הדקים</p>
        <button class="maabada-button" onclick="location.href='sites/kaam.aspx'" type="button"><span>ללמוד<br>כא"מ ומתח הדקים!</span></button>
    </div>
    <div class="maabada">
        <img src="img/rehivim.jpg" class="maabada-img">
        <p class="maabada-text">אופיינים של רכיבים חשמליים</p>
        <button class="maabada-button" onclick="location.href='sites/rehivim.aspx'" type="button"><span>ללמוד<br>אופיינים של רכיבים חשמליים</span></button>
    </div>
    <div class="maabada">
        <img src="img/sadas.jpg" class="maabada-img">
        <p class="maabada-text">גלוונומטר טנגנטי</p>
        <button class="maabada-button" onclick="location.href='sites/tangent.aspx'" type="button"><span>ללמוד<br>גלוונומטר טנגנטי!</span></button>
    </div>
    <div class="maabada">
        <img src="img/images.jfif" class="maabada-img">
        <p class="maabada-text">חקירת העדשה</p>
        <button class="maabada-button" onclick="location.href='sites/adasha.aspx'" type="button"><span>ללמוד<br>חקירת העדשה!</span></button>
    </div>
</div>
</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="admin.aspx.cs" Inherits="sites_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <link href="..\stylesheets\other.css" rel="stylesheet" />
        <script src="scripts\reg.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--dropdownList הוא כמו select אבל הוא פועל על צד שרת ויש לו אירועים מובנים --%>
    <asp:Label ID="Label1" runat="server" Text="Sort by: "></asp:Label>
    <asp:DropDownList runat="server" ID="sorting" AutoPostBack="true" OnSelectedIndexChanged="Sorttable">
        <asp:ListItem Value="id" Selected="True">ID</asp:ListItem>
        <asp:ListItem Value="Username">Username</asp:ListItem>
        <asp:ListItem Value="password">Password</asp:ListItem>
        <asp:ListItem Value="email">Email</asp:ListItem>
        <asp:ListItem Value="phone">Phone</asp:ListItem>
        <asp:ListItem Value="date">Date</asp:ListItem>
        <asp:ListItem Value="admin">Admin</asp:ListItem>
    </asp:DropDownList>
  <br><br>
    <div id="admintable" runat="server"></div>
</asp:Content>


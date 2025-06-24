<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="private2.aspx.cs" Inherits="sites_private2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   <link href="..\stylesheets\other.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server" >
    <div style="display: flex; justify-content: center; align-items: center; height: 100%;">
        <iframe 
            src="https://phet.colorado.edu/sims/html/geometric-optics/latest/geometric-optics_en.html"
            width="1066"
            height="800"
            allowfullscreen="allowfullscreen">
        </iframe>
    </div>
</asp:Content>


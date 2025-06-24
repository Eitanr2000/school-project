<%@ Application Language="C#" %>

<script runat="server">

    protected void Application_Start(object sender, EventArgs e)
    {
        Application["TotalUsers"] = 0;
        Application["CurrentUsers"] = 0;

    }

    protected void Session_Start(object sender, EventArgs e)
    {
        Application.Lock();
        Application["TotalUsers"] = (int)Application["TotalUsers"] + 1;
        Application["CurrentUsers"] = (int)Application["CurrentUsers"] + 1;
        Application.UnLock();
        Session["userName"] = "Visitor";
        Session["logged"] = false;
        Session["admin"] = false;
    }

    protected void Application_BeginRequest(object sender, EventArgs e)
    {

    }

    protected void Application_AuthenticateRequest(object sender, EventArgs e)
    {

    }

    protected void Application_Error(object sender, EventArgs e)
    {

    }

    protected void Session_End(object sender, EventArgs e)
    {
        Application.Lock();
        Application["CurrentUsers"] = (int)Application["CurrentUsers"] - 1;
        Application.UnLock();
    }

    protected void Application_End(object sender, EventArgs e)
    {

    }

</script>

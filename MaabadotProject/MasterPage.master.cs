using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            curr.InnerText = Application["CurrentUsers"].ToString();
            total.InnerText = Application["TotalUsers"].ToString();
        }
        if ((bool)Session["logged"])
        {
            register.Visible = false;
            wellcome.Visible = true;
            log_out.Visible = true;
            
        }
        if ((bool)Session["admin"])
        {
            admin.Visible = true;
        }
        else
        {
            admin.Visible = false;
        }

    }

    protected void logout(object sender, EventArgs e) {
        Session["logged"] = false;
        Session["userName"] = "";
        Session["admin"]=false;
        register.Visible = true;
        wellcome.Visible = false ;
        log_out.Visible = false;
    }
}

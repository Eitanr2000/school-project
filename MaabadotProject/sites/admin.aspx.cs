using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;

public partial class sites_admin : System.Web.UI.Page
{
    string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Database.mdf;Integrated Security=True";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["admin"] == null || !(bool)Session["admin"])
        {
            Response.Redirect("../main.aspx");
            return;
        }

        if (Request.Form["addUserBtn"] != null)
        {
            AddUserFromForm();
            Response.Redirect(Request.RawUrl);
        }

        if (Request.Form["deleteUserBtn"] != null && int.TryParse(Request.Form["deleteUserBtn"], out int userId))//מחזיר אמת אם ישנו מספר ב deleteuserbtn
        { 
            DeleteUser(userId);
        }

        if (!IsPostBack || Request.Form["addUserBtn"] != null || Request.Form["deleteUserBtn"] != null || Request.Form["sorting"] != null)
        {
             BuildUserTable(GetUsers());
        }


    }

    protected void Sorttable(object sender, EventArgs e) {
        BuildUserTable(GetUsers());
    }

    public DataSet GetUsers()
    {
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string sqlstr = $"SELECT * FROM Users ORDER BY {sorting.SelectedValue};";
            SqlDataAdapter adapter = new SqlDataAdapter(sqlstr, con);
            DataSet ds = new DataSet();
            adapter.Fill(ds);
            return ds;
        }
    }

    public void BuildUserTable(DataSet ds)
    {
        if (ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
        {
            admintable.InnerHtml = "<p>No data</p>";
            return;
        }

        DataTable table = ds.Tables[0];
        string html = "<form method='post'><table border='1' style='border-collapse: collapse;'>";

        // Header row
        html += "<tr>";
        foreach (DataColumn column in table.Columns)
        {
            html += $"<th>{column.ColumnName}</th>";
        }
        html += "<th>Action</th></tr>";

        // Data rows
        foreach (DataRow row in table.Rows)
        {
            html += "<tr>";
            foreach (var item in row.ItemArray)
            {
                html += $"<td>{item.ToString()}</td>";
            }

            int id = Convert.ToInt32(row["id"]);
            html += $"<td><button type='submit' name='deleteUserBtn' value='{id}' onclick='return confirm(\"Remove user ID {id}?\")'>Remove</button></td>";
            html += "</tr>";
        }

        // New user input row
        html += "<tr>";
        foreach (DataColumn column in table.Columns)
        {
            string name = column.ColumnName.ToLower();
            string inputName = $"new_{column.ColumnName}";

            if (name == "id")
            {
                html += "<td></td>";
            }
            else if (name == "admin")
            {
                html += $"<td><input type='checkbox' name='{inputName}' /></td>";
            }
            else
            {
                html += $"<td><input type='text' name='{inputName}' style='width: 100%' /></td>";
            }
        }

        html += "<td><input type='submit' name='addUserBtn' value='Add User' /></td>";
        html += "</tr>";

        html += "</table></form>";
        admintable.InnerHtml = html;
    }

    private void AddUserFromForm()
    {
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "INSERT INTO Users (Username, Password, Email, Phone, date, admin) " +
                           "VALUES (@Username, @Password, @Email, @Phone, @Date, @Admin)";
            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@Username", Request.Form["new_Username"] ?? "");
            cmd.Parameters.AddWithValue("@Password", Request.Form["new_Password"] ?? "");
            cmd.Parameters.AddWithValue("@Email", Request.Form["new_Email"] ?? "");
            cmd.Parameters.AddWithValue("@Phone", Request.Form["new_Phone"] ?? "");

            DateTime parsedDate;
            if (!DateTime.TryParse(Request.Form["new_date"], out parsedDate))
            {
                parsedDate = DateTime.Now;
            }

            cmd.Parameters.AddWithValue("@Date", parsedDate);
            cmd.Parameters.AddWithValue("@Admin", Request.Form["new_admin"] == "on");

            con.Open();
            cmd.ExecuteNonQuery();
            
        }
    }

    private void DeleteUser(int id)
    {
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "DELETE FROM Users WHERE id = @id";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@id", id);
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }
}

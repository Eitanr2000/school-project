using System;
using System.Data.SqlClient;
using System.Web.UI;

public partial class register : System.Web.UI.Page
{
    string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Database.mdf;Integrated Security=True\r\n";
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["logged"] != null && Convert.ToBoolean(Session["logged"]))
        {
            Response.Redirect("main.aspx");
        }
        if (IsPostBack)
        {
            if (Request.Form["login"] != null)
            {
                loginUser();
            }
            else if (Request.Form["register"] != null)
            {
                RegisterUser();
            }
        }
    }

    protected void loginUser()
    {
        string username = Request.Form["lgname"];
        string email = Request.Form["lgemail"];
        string password = Request.Form["lgpassword"];
        int ans = ValidateUserCredentials(username, email, password);
        if (ans == 1)
        {
            Session["userName"] = username;
            Session["logged"] = true;
            Session["admin"] = checkAdmin(username);
            Console.WriteLine(Session["admin"]);
            Response.Redirect("main.aspx");
        }
        else if (ans == 0)
        {
            LBLEROR.InnerText = "שם המשתמש, אימייל או סיסמה אינם נכונים.";
            LBLEROR.Visible = true;
        }
        else {
            LBLEROR.InnerText = "המנוי פג תוקף אנא פנה למנהל";
            LBLEROR.Visible = true;
        }
    }

    protected bool checkAdmin(string username) {

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();

            string query = "SELECT admin FROM Users WHERE Username = @Username";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Username", username);
                return (bool)cmd.ExecuteScalar();
            }
        }
    }

    private int ValidateUserCredentials(string username, string email, string password)
    {

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();

            string query = "SELECT Password, date FROM Users WHERE Username = @Username AND Email = @Email";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Email", email);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        string storedPassword = reader["Password"].ToString();
                        DateTime date = Convert.ToDateTime(reader["date"]);

                        if (date > DateTime.Today)
                        {

                            if (password == storedPassword) { return 1; }
                            
                        }
                        else
                        {
                            return 2;
                        }
                    }
                }
            }
        }
        return 0;
    }


    protected void RegisterUser()
    {
        string username = Request.Form["name"];
        string email = Request.Form["email"];
        string phone = Request.Form["phone"];
        string password = Request.Form["password"];
        string subscriptionDate = Request.Form["subscription-date"];

        

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();

            string checkQuery = "SELECT COUNT(*) FROM Users WHERE Username = @Username OR Email = @Email";
            using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
            {
                checkCmd.Parameters.AddWithValue("@Username", username);
                checkCmd.Parameters.AddWithValue("@Email", email);

                int userExists = (int)checkCmd.ExecuteScalar();
                if (userExists > 0)
                {
                    REGERROR.InnerText = "שם משתמש או מייל כבר קיים במערכת";
                    return;
                }
            }
            System.Diagnostics.Debug.WriteLine($"Username: [{username}]");
            System.Diagnostics.Debug.WriteLine($"Email: [{email}]");

            string insertQuery = "INSERT INTO Users (Username, Email, Phone, Password, date) VALUES (@Username, @Email, @Phone, @Password, @SubscriptionDate)";
            using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
            {
                insertCmd.Parameters.AddWithValue("@Username", username);
                insertCmd.Parameters.AddWithValue("@Email", email);
                insertCmd.Parameters.AddWithValue("@Phone", phone);
                insertCmd.Parameters.AddWithValue("@Password", password); 
                insertCmd.Parameters.AddWithValue("@SubscriptionDate", subscriptionDate);

                insertCmd.ExecuteNonQuery();
            }
        }
        Session["userName"] = username;
        Session["logged"] = true;
        Response.Redirect("main.aspx");
    }
}

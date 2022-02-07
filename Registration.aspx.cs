using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.IO;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;

namespace _204805T_Ang_Wei_Wen_Assignment
{
    public partial class Registration : System.Web.UI.Page
    {
        string DBConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
        static string finalhash;
        static string salt;
        byte[] Key;
        byte[] IV;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void TextBox3_TextChanged(object sender, EventArgs e)
        {

        }
        public class MyObject
        {
            public string success { get; set; }
            public List<string> ErrorMessage { get; set; }
        }
        public bool ValidateCaptcha()
        {
            bool result = true;

            //When user submits the recaptcha form, the user gets a response POST parameter. 
            //captchaResponse consist of the user click pattern. Behaviour analytics! AI :) 
            string captchaResponse = Request.Form["g-recaptcha-response"];

            //To send a GET request to Google along with the response and Secret key.
            HttpWebRequest req = (HttpWebRequest)WebRequest.Create
           (" https://www.google.com/recaptcha/api/siteverify?secret= &response=" + captchaResponse);
            try
            {

                //Codes to receive the Response in JSON format from Google Server
                using (WebResponse wResponse = req.GetResponse())
                {
                    using (StreamReader readStream = new StreamReader(wResponse.GetResponseStream()))
                    {
                        //The response in JSON format
                        string jsonResponse = readStream.ReadToEnd();

                        JavaScriptSerializer js = new JavaScriptSerializer();

                        //Create jsonObject to handle the response e.g success or Error
                        //Deserialize Json
                        MyObject jsonObject = js.Deserialize<MyObject>(jsonResponse);

                        //Convert the string "False" to bool false or "True" to bool true
                        result = Convert.ToBoolean(jsonObject.success);//

                    }
                }

                return result;
            }
            catch (WebException ex)
            {
                throw ex;
            }
        }


        protected void register()
        {
            string path = Server.MapPath("Images/");
            if (photoupload.HasFile)
            {
                photoupload.SaveAs(path + photoupload.FileName);
                string name = "Images/" + photoupload.FileName;
                try
                {
                    using (SqlConnection con = new SqlConnection(DBConnectionString))
                    {
                        using (SqlCommand cmd = new SqlCommand("INSERT INTO Account VALUES(@firstname,@lastname,@cardnumber,@email,@password,@dateofbirth,@photo,@hash,@salt,@IV,@Key)"))
                        {
                            using (SqlDataAdapter sda = new SqlDataAdapter())
                            {
                                cmd.CommandType = CommandType.Text;
                                cmd.Parameters.AddWithValue("@firstname", tb_firstname.Text.Trim());
                                cmd.Parameters.AddWithValue("@lastname", tb_lastname.Text.Trim());
                                cmd.Parameters.AddWithValue("@cardnumber", Convert.ToBase64String(encryptData(tb_cardnumber.Text.Trim())));
                                cmd.Parameters.AddWithValue("@email", tbemail.Text);
                                cmd.Parameters.AddWithValue("@password", tbpassword.Text);
                                cmd.Parameters.AddWithValue("@dateofbirth", tbDOB.Text);
                                cmd.Parameters.AddWithValue("@photo", name);
                                cmd.Parameters.AddWithValue("@hash", finalhash);
                                cmd.Parameters.AddWithValue("@salt", salt);
                                cmd.Parameters.AddWithValue("@IV", Convert.ToBase64String(IV));
                                cmd.Parameters.AddWithValue("@Key", Convert.ToBase64String(Key));
                                cmd.Connection = con;
                                con.Open();
                                cmd.ExecuteNonQuery();
                                con.Close();
                            }
                        }
                    }

                }
                catch (Exception ex)
                {
                    throw new Exception(ex.ToString());
                }
            }
            
        }
    

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string pwd = tbpassword.Text.ToString().Trim();
            RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
            byte[] saltbyte = new byte[8];

            rng.GetBytes(saltbyte);
            salt = Convert.ToBase64String(saltbyte);

            SHA256Managed hashing = new SHA256Managed();

            string pwdwithsalt = pwd + salt;
            byte[] plainHash = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwd));
            byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdwithsalt));

            finalhash = Convert.ToBase64String(hashWithSalt);


            Rijndael cipher = new RijndaelManaged();
            cipher.GenerateKey();
            Key = cipher.Key;
            IV = cipher.IV;

            HttpUtility.HtmlEncode(tb_firstname);
            HttpUtility.HtmlEncode(tb_lastname);
            HttpUtility.HtmlEncode(tb_cardnumber);
            HttpUtility.HtmlEncode(tbemail);
            HttpUtility.HtmlEncode(tbpassword);
            HttpUtility.HtmlEncode(tbDOB);

            register();

            Response.Redirect("Login.aspx", false);
        }
        protected byte[] encryptData(string data)
        {
            byte[] cipherText = null;
            try
            {
                RijndaelManaged cipher = new RijndaelManaged();
                cipher.IV = IV;
                cipher.Key = Key;
                ICryptoTransform encryptTransform = cipher.CreateEncryptor();
                //ICryptoTransform decryptTransform = cipher.CreateDecryptor();
                byte[] plainText = Encoding.UTF8.GetBytes(data);
                cipherText = encryptTransform.TransformFinalBlock(plainText, 0, plainText.Length);

            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }

            finally { }
            return cipherText;
        }
    }
}
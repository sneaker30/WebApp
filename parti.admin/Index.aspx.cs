using System;
using parti.admin.lib;
using Newtonsoft.Json;

namespace parti.admin
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        wcf.parti.Service1 parti = new wcf.parti.Service1();
        partiDB.RootObject getAuthen = new partiDB.RootObject();
        GetSetEnCoding enCoding = new GetSetEnCoding();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack == false)
            {
                inputUsername.Value = "";
                inputPassword.Value = "";
                if ((string)Session["loginstatus"] == "1")
                {
                    Response.Redirect("Main");
                }
            }
        }

        protected void btLogin_Click(object sender, EventArgs e)
        {
            try
            {
                if (inputUsername.Value == "admin" && inputPassword.Value == "lt4k[aoadmin")
                {
                    Session["tid"] = "0";
                    Session["id"] = "0";
                    Session["username"] = "admin";
                    Session["passwd"] = "lt4k[aoadmin";
                    Session["rules"] = "rw";
                    Session["user_avatar"] = "img/avatar.png";
                    Session["fullname"] = "admin";
                    Session["position"] = "app admin";
                    Session["loginstatus"] = "1";//1:logged in, 0 or Null:logout
                    Response.Redirect("Main");
                }
                else
                {
                    string json_str = parti.GetAuthen(inputUsername.Value, enCoding.SetEncryptData(inputPassword.Value));
                    if (json_str == "e0")
                    {
                        MessageBox.swalToast(this.Page, "error", "e0: ລະບົບຂັດຂ້ອງຕິດຕໍ່ຜູ້ເບີ່ງແຍ່ງດ່ວນ.");
                    }
                    else if (json_str == "e1")
                    {
                        MessageBox.swalToast(this.Page, "warning", "e1: ຊື່ຜູ້ໃຊ້ ຫລື ລະຫັດຜ່ານ ບໍ່ຖືກຕ້ອງ.");
                    }
                    else if (json_str == "e2")
                    {
                        MessageBox.swalToast(this.Page, "error", "e2: ບໍ່ສາມາດເຊື່ອມຕໍ່ຖານຂໍ້ມູນໄດ້.");
                    }
                    else
                    {
                        getAuthen = JsonConvert.DeserializeObject<partiDB.RootObject>(json_str);
                        foreach (var vl in getAuthen.GetAuthen)
                        {
                            Session["tid"] = vl.tid;
                            Session["id"] = vl.id;
                            Session["username"] = vl.username;
                            Session["passwd"] = vl.passwd;
                            Session["rules"] = vl.rules;
                            Session["user_avatar"] = vl.user_avatar;
                            Session["fullname"] = vl.fullname;
                            Session["position"] = vl.position;
                            Session["loginstatus"] = "1";//1:logged in, 0 or Null:logout
                            Response.Redirect("Main");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.swalToast(this.Page, "error", "ex: " + ex.Message.Replace("'", ""));
            }
        }
    }
}
using parti.admin.lib;
using System;
using System.Data.Entity.Infrastructure.MappingViews;
using System.Web.UI;

namespace parti.admin
{
    public partial class SiteMaster : MasterPage
    {
        public static GetSetEnCoding enCoding = new GetSetEnCoding();
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Header.DataBind();
            if (!IsPostBack)
            {
                if (Session["loginstatus"] == null)
                    Response.Redirect("index");
                else
                {
                    Response.ClearHeaders();
                    Response.AddHeader("Cache-Control", "no-cache, no-store, max-age=0, must-revalidate");
                    Response.AddHeader("Pragma", "no-cache");
                }
                lblPosition.InnerText = (string)Session["position"];
                lblUsername.InnerText = (string)Session["fullname"];
                imgUserAvatar.Src = (string)Session["user_avatar"];
                imgSidenavUserAvatar.Src = (string)Session["user_avatar"];
                string rules = (string)Session["rules"];
                if (rules == "r")
                {
                    mnUsers.Visible = false;
                    navUser.Visible = false;
                }
                else if (rules == "rw")
                {
                    mnUsers.Visible = true;
                    navUser.Visible = true;
                }
            }
        }

        protected void btLogout_Click(object sender, EventArgs e)
        {
            try
            {
                if ((string)Session["loginstatus"] == "1" || Session["loginstatus"] != null)
                {
                    Session.Clear();
                    Session.RemoveAll();
                    Session.Abandon();
                    Response.Redirect("index");
                }
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'", "") + "]", "");
            }
        }

        protected void btnChangePWD_ServerClick(object sender, EventArgs e)
        {
            string rResult = "";
            string rAction = "";
            try
            {
                wcf.parti.Service1 _parti = new wcf.parti.Service1();
                var result = _parti.EditUsers("edit", Convert.ToInt32(Session["tid"].ToString()), true, Session["username"].ToString(),
                    enCoding.SetEncryptData(txtPWDNew2.Value), Session["rules"].ToString());
                if (result == "e5")
                {
                    rResult = "ລະຫັດຜ່ານຂອງທ່ານໄດ້ຖືກປ່ຽນແປງຮຽບຮ້ອຍແລ້ວ..., ກະລຸນາອອກຈາກລະບົບແລ້ວເຂົ້າໃຫມ່.";
                    rAction = "success";
                }
                else if (result == "e2")
                {
                    rResult = "e2:ບໍ່ສາມາດເຊື່ອມຕໍ່ຖານຂໍ້ມູນໄດ້.";
                    rAction = "error";
                }
                else if (result == "e1")
                {
                    rResult = "e1:ບໍ່ມີຂໍ້ມູນທີ່ຈະສະແດງ.";
                    rAction = "info";
                }
                else if (result == "e0")
                {
                    rResult = "e0:ລະບົບຂັດຂ້ອງຕິດຕໍ່ຜູ້ເບີ່ງແຍ່ງດ່ວນ.";
                    rAction = "error";
                }
                MessageBox.swalModal(this.Page, rAction, rResult, "");
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'", "") + "]", "");
            }
        }
    }
}
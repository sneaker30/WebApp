using parti.admin.lib;
using System;
using System.Web.Services;

namespace parti.admin
{
    public partial class Evaluation_Training : System.Web.UI.Page
    {
        GetSetEnCoding enCoding = new GetSetEnCoding();
        static string[] param = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            param = new string[] { enCoding.GetDecryptData(Request.QueryString["tid"]), enCoding.GetDecryptData(Request.QueryString["tname"]) };
        }

        [WebMethod]
        public static string[] GetTID()
        {
            return param;
        }
    }
}
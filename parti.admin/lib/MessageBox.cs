using System.Web.UI;

namespace parti.admin.lib
{
    public static class MessageBox
    {
        public static void Show(Page Page, string msg)
        {
            Page.ClientScript.RegisterClientScriptBlock(Page.GetType(), "OnLoad", 
                "<script>alert('" + msg + "');</script>");
        }

        public static void swalModal(Page Page, string action, string msg, string currentPage)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "pop", 
                "swalModal('" + action + "', '" + msg + "', '" + currentPage +"');", true);
        }

        public static void swalToast(Page Page, string action, string msg)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "pop", 
                "swalToast('" + action + "','" + msg + "');", true);
        }
    }
}
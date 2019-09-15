using parti.admin.lib;
using System;
using System.Web.Services;
using System.Web.UI;

namespace parti.admin
{
    public partial class Evaluation_Training : System.Web.UI.Page
    {
        GetSetEnCoding enCoding = new GetSetEnCoding();
        static string[] param = null;
        public static Page _Page = new Page();

        protected void Page_Load(object sender, EventArgs e)
        {
            param = new string[] { enCoding.GetDecryptData(Request.QueryString["tid"]), enCoding.GetDecryptData(Request.QueryString["tname"]) };
        }

        [WebMethod]
        public static string[] GetTID()
        {
            return param;
        }

        [WebMethod]
        public static string EditUAnswer(string u_id, string t_id, string q_id, string a_id)
        {
            string result = null;
            string json_str = null;
            string action = "add";
            try
            {
                wcf.parti.Service1 _parti = new wcf.parti.Service1();
                json_str = _parti.GetUAnswer(u_id, t_id, q_id);
                if (json_str == "e0")//code error
                {
                    result = "e0:ລະບົບຂັດຂ້ອງຕິດຕໍ່ຜູ້ເບີ່ງແຍ່ງດ່ວນ.";
                }
                else if (json_str == "e1" && action == "add")//no data found
                {
                    json_str = _parti.EditUAnswer(action, u_id, t_id, q_id, a_id);
                    if (json_str == "e0")//code error
                    {
                        result = "e0:ລະບົບຂັດຂ້ອງຕິດຕໍ່ຜູ້ເບີ່ງແຍ່ງດ່ວນ.";
                    }
                    else if (json_str == "e1")//no data found
                    {
                        result = "e1:ບໍ່ມີຂໍ້ມູນທີ່ຈະສະແດງ.";
                    }
                    else if (json_str == "e2")//can't connect databbase
                    {
                        result = "e2:ບໍ່ສາມາດເຊື່ອມຕໍ່ຖານຂໍ້ມູນໄດ້.";
                    }
                    else if (json_str == "e5")
                    {
                        result = "e5:ຈັດການຂໍ້ມູນສຳເລັດແລ້ວ.";
                    }
                }
                else if (json_str == "e2")//can't connect databbase
                {
                    result = "e2:ບໍ່ສາມາດເຊື່ອມຕໍ່ຖານຂໍ້ມູນໄດ້.";
                }
                else if (json_str == "e3")
                {
                    action = "edit";
                    if (action == "add")
                    {
                        result = "e3:ຄຳຕອບນີ້ມີໃນຖານຂໍ້ມູນແລ້ວ.";
                    }
                    else if (action == "edit")
                    {
                        json_str = _parti.EditUAnswer(action, u_id, t_id, q_id, a_id);
                        if (json_str == "e0")//code error
                        {
                            result = "e0:ລະບົບຂັດຂ້ອງຕິດຕໍ່ຜູ້ເບີ່ງແຍ່ງດ່ວນ.";
                        }
                        else if (json_str == "e1")//no data found
                        {
                            result = "e1:ບໍ່ມີຂໍ້ມູນທີ່ຈະສະແດງ.";
                        }
                        else if (json_str == "e2")//can't connect databbase
                        {
                            result = "e2:ບໍ່ສາມາດເຊື່ອມຕໍ່ຖານຂໍ້ມູນໄດ້.";
                        }
                        else if (json_str == "e5")
                        {
                            result = "e5:ຈັດການຂໍ້ມູນສຳເລັດແລ້ວ.";
                        }
                    }
                }
            }
            catch(Exception e)
            {
                result = "e0:" + e.Message;
            }

            return result;
        }
    }
}
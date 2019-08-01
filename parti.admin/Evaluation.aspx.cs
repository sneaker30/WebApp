using Newtonsoft.Json;
using parti.admin.lib;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace parti.admin
{
    public partial class Evaluation : System.Web.UI.Page
    {
        public static List<GetTrainingIDName> GetTrainingIdNames = new List<GetTrainingIDName>();
        public static Page _Page = new Page();

        public class GetTrainingIDName
        {
            public string id { get; set; }
            public string title { get; set; }

            public GetTrainingIDName(string _id, string _title)
            {
                id = _id;
                title = _title;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static List<GetTrainingIDName> getTrainingId(string id, string title)
        {
            GetTrainingIdNames.Clear();
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            partiDB.RootObject rootObject = new partiDB.RootObject();
            if (GetTrainingIdNames.Count == 0)
            {
                string json_str = _parti.GetTrainingIdNames(id, title);
                if (json_str == "e0")//code error
                {
                    MessageBox.swalModal(_Page, "error", "e0:ລະບົບຂັດຂ້ອງຕິດຕໍ່ຜູ້ເບີ່ງແຍ່ງດ່ວນ.", "");
                }
                else if (json_str == "e1")//no data found
                {
                    MessageBox.swalModal(_Page, "info", "e1:ບໍ່ມີຂໍ້ມູນທີ່ຈະສະແດງ.", "");
                }
                else if (json_str == "e2")//can't connect databbase
                {
                    MessageBox.swalModal(_Page, "warning", "e2:ບໍ່ສາມາດເຊື່ອມຕໍ່ຖານຂໍ້ມູນໄດ້.", "");
                }
                else
                {
                    rootObject = JsonConvert.DeserializeObject<partiDB.RootObject>(json_str);
                    foreach (var vl in rootObject.GetTrainingIDName)
                    {
                        GetTrainingIdNames.Add(new GetTrainingIDName(vl.id, vl.title));
                    }
                }
            }
            return GetTrainingIdNames;
        }

        [WebMethod]
        public static string EditQTitle(string action, string t_id, string title_name, string training_id, string created_date)
        {
            string result = null;
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            string json_str = _parti.EditQTitle(action, t_id, title_name, training_id, created_date, "");
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
                result = "e5";
            }

            return result;
        }

        [WebMethod]
        public static string EditQQuestions(string action, string q_id, string question_text, string t_id)
        {
            string result = null;
            wcf.parti.Service1 _parti = new wcf.parti.Service1();

            string json_str;
            json_str = _parti.GetQuestion(q_id, t_id);

            if (json_str == "e0")//code error
            {
                result = "e0:ລະບົບຂັດຂ້ອງຕິດຕໍ່ຜູ້ເບີ່ງແຍ່ງດ່ວນ.";
            }
            else if (json_str == "e1")//no data found
            {
                json_str = _parti.EditQuestions(action, q_id, question_text, t_id, "");
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
                    result = "e5";
                }
            }
            else if (json_str == "e2")//can't connect databbase
            {
                result = "e2:ບໍ່ສາມາດເຊື່ອມຕໍ່ຖານຂໍ້ມູນໄດ້.";
            }
            else if (json_str == "e3")
            {
                if (action != "del")
                {
                    action = "edit";
                }
                json_str = _parti.EditQuestions(action, q_id, question_text, t_id, "");
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
                    result = "e5";
                }
            }

            return result;
        }

        [WebMethod]
        public static string EditQAnswers(string action, string a_id, string answer_text, string q_id, string t_id, string status)
        {
            string result = null;
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            string json_str;
            json_str = _parti.GetAnswer(a_id, q_id, t_id);
            if (json_str == "e0")//code error
            {
                result = "e0:ລະບົບຂັດຂ້ອງຕິດຕໍ່ຜູ້ເບີ່ງແຍ່ງດ່ວນ.";
            }
            else if (json_str == "e1" && action == "add")//no data found
            {
                json_str = _parti.EditQAnswers(action, a_id, answer_text, q_id, t_id, status);
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
                    result = "e5";
                }
            }
            else if (json_str == "e2")//can't connect databbase
            {
                result = "e2:ບໍ່ສາມາດເຊື່ອມຕໍ່ຖານຂໍ້ມູນໄດ້.";
            }
            else if (json_str == "e3")
            {
                if (action == "add")
                {
                    result = "e3:ຄຳຕອບນີ້ມີໃນຖານຂໍ້ມູນແລ້ວ.";
                }
                else if (action == "del")
                {
                    json_str = _parti.EditQAnswers(action, a_id, answer_text, q_id, t_id, status);
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
                        result = "e5";
                    }
                }
            }

            return result;
        }
    }
}
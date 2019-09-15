using Newtonsoft.Json;
using parti.admin.lib;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;

namespace parti.admin
{
    public partial class Evaluation : System.Web.UI.Page
    {
        public static List<GetTrainingIDName> GetTrainingIdNames = new List<GetTrainingIDName>();
        public static List<GetQTitle> listGetQTitle = new List<GetQTitle>();
        public static List<GetQAnswer> listGetQAnswer = new List<GetQAnswer>();
        public static List<GetQQuestion> listGetQQuestion = new List<GetQQuestion>();
        public static Page _Page = new Page();
        public static Control _Control = new Control();
        public static GetSetEnCoding _EnCoding = new GetSetEnCoding();

        public class GetQQuestion
        {
            public string q_id { get; set; }
            public string question_text { get; set; }
            public string t_id { get; set; }
            public string date_of_modified_date { get; set; }

            public GetQQuestion(string q_id, string question_text, string t_id, string date_of_modified_date)
            {
                this.q_id = q_id;
                this.question_text = question_text;
                this.t_id = t_id;
                this.date_of_modified_date = date_of_modified_date;
            }
        }

        public class GetQAnswer
        {
            public string a_id { get; set; }
            public string answer_text { get; set; }
            public string q_id { get; set; }
            public string t_id { get; set; }
            public string status { get; set; }
            public string date_of_modified_date { get; set; }

            public GetQAnswer(string a_id, string answer_text, string q_id, string t_id, string status, string date_of_modified_date)
            {
                this.a_id = a_id;
                this.answer_text = answer_text;
                this.q_id = q_id;
                this.t_id = t_id;
                this.status = status;
                this.date_of_modified_date = date_of_modified_date;
            }
        }

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

        public class GetQTitle
        {
            public string t_id { get; set; }
            public string title_name { get; set; }
            public string training_id { get; set; }
            public string date_of_modified_data { get; set; }
            public string q_type { get; set; }

            public GetQTitle(string t_id, string title_name, string training_id, DateTime date_of_modified_data, string q_type)
            {
                this.t_id = t_id;
                this.title_name = title_name;
                this.training_id = training_id;
                this.date_of_modified_data = date_of_modified_data.ToString("yyyy-MM-dd HH:mm:ss");
                this.q_type = q_type;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            GetQTitleList("");
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
        public static string EditQTitle(string action, string t_id, string title_name, string training_id, string created_date, string q_type)
        {
            string result = null;
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            string json_str = _parti.EditQTitle(action, t_id, title_name, training_id, created_date, q_type, "");
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

        private List<GetQTitle> GetQTitleList(string t_id)
        {
            listGetQTitle.Clear();
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            partiDB.RootObject rootObject = new partiDB.RootObject();
            if (listGetQTitle.Count == 0)
            {
                string json_str = _parti.GetQTitle(t_id);
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
                    var i = 1;
                    rootObject = JsonConvert.DeserializeObject<partiDB.RootObject>(json_str);
                    foreach (var vl in rootObject.GetQTitle)
                    {
                        listGetQTitle.Add(new GetQTitle(vl.t_id, vl.title_name, vl.training_id, vl.date_of_modified_data, vl.q_type));
                        HtmlElement _tbody = new HtmlElement();
                        var QType = "";

                        if (vl.q_type == "b")
                        {
                            QType = "ຄຳຖາມກ່ອນຝຶກ";
                        }
                        else if (vl.q_type == "a")
                        {
                            QType = "ຄຳຖາມຫຼັງຝຶກ";
                        }

                        _tbody.InnerHtml = "<tr class='evalist'><td class='col s1 m1 l1'>" + i + "</td>" +
                            "<td class='col s2 m2 l2'>" + vl.t_id + "</td>" +
                            "<td class='col s4 m4 l4'>" + vl.title_name + "</td>" +
                            "<td class='col s2 m2 l2'>" + QType + " </td>" +
                            "<td class='col s3 m3 l3 center'><div class='row right'><div class='col'>" +
                            "<a class='btn-floating waves-effect tooltipped hvr-grow-shadow' data-position='left' data-tooltip='ແກ້ໄຂ' " +
                            "id='btnEdit" + i + "' name='" + vl.t_id + "' onclick='GetQInfo(" + (i - 1) + ", this.name)'><i class='material-icons right'>edit</i>" +
                            "</a></div><div class='col'><a class='btn-floating waves-effect tooltipped hvr-grow-shadow' data-position='top' " +
                            "data-tooltip='ເປີດຫນ້າແບບຟອມສຳລັບຜູ້ຝຶກ' id='btnEvaLink" + i + "' name='" + vl.t_id + "' onclick='GenLink(this.name, " + i + ")'>" +
                            "<i class='material-icons right'>open_in_new</i></a></div><div class='col'><a class='btn-floating waves-effect tooltipped hvr-grow-shadow modal-trigger' data-position='right' " + 
                            "data-tooltip='ສ້າງ QR Code ສຳລັບແບບຟອມນີ້' id='btnQRGent" + i + "' name='" + vl.t_id + "' onclick='GenQRCode(this.name, " + i + ")'><i class='fas fa-qrcode'></i></a></div></div></td></tr>";
                        tbody.Controls.Add(_tbody);
                        i++;
                    }
                }
            }
            return listGetQTitle;
        }

        [WebMethod]
        public static GetQTitle GetQTitleID(int index)
        {
            GetQTitle getQTitle;
            getQTitle = listGetQTitle[index];
            return getQTitle;
        }

        [WebMethod]
        public static List<GetQQuestion> GetQQuestionID(string t_id)
        {
            listGetQQuestion.Clear();
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            partiDB.RootObject rootObject = new partiDB.RootObject();
            if (listGetQQuestion.Count == 0)
            {
                string json_str = _parti.GetQQuestion(t_id);
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
                    foreach (var vl in rootObject.GetQQuestion)
                    {
                        listGetQQuestion.Add(new GetQQuestion(vl.q_id, vl.question_text, vl.t_id, vl.date_of_modified_date));
                    }
                }
            }
            return listGetQQuestion;
        }

        [WebMethod]
        public static List<GetQAnswer> GetQAnswerID(string t_id, string q_id)
        {
            listGetQAnswer.Clear();
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            partiDB.RootObject rootObject = new partiDB.RootObject();
            if (listGetQAnswer.Count == 0)
            {
                string json_str = _parti.GetQAnswer(t_id, q_id);
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
                    var i = 1;
                    rootObject = JsonConvert.DeserializeObject<partiDB.RootObject>(json_str);
                    foreach (var vl in rootObject.GetQAnswer)
                    {
                        listGetQAnswer.Add(new GetQAnswer(vl.a_id, vl.answer_text, vl.q_id, vl.t_id, vl.status, vl.date_of_modified_date));
                    }
                }
            }
            return listGetQAnswer;
        }

        [WebMethod]
        public static string SetEvaluationTraining(string t_id, string index)
        {
            var param1 = "?tid=";
            param1 += _EnCoding.SetEncryptData(t_id);
            var param2 = "&tname=";
            param2 += _EnCoding.SetEncryptData(index);
            string authority = HttpContext.Current.Request.Url.Authority;
            var url = ("http://" + authority + "/Evaluation_Training" + param1 + param2);

            return url;
        }
    }
}
using Newtonsoft.Json;
using parti.admin.lib;
using System;
using System.Collections.Generic;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using static parti.admin.Course;
using static parti.admin.YearPlans;

namespace parti.admin
{
    public partial class tcrpt03 : System.Web.UI.Page
    {
        public static List<Course.GetCourse> gridDataCourses = new List<Course.GetCourse>();
        public static Page _Page = new Page();
        public static List<GetCompareYearPlan> planByTimeRanges = new List<GetCompareYearPlan>();
        public static List<GetAllQuestionList> questionLists = new List<GetAllQuestionList>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                RenderSelectCourse();
            }
        }

        private void RenderSelectCourse()
        {
            gridDataCourses = GetgridData();
            selCourse2.Items.Clear();
            selCourse2.Items.Add(new ListItem("ທັງຫມົດ", "0"));
            foreach (var vl in gridDataCourses)
            {
                selCourse2.Items.Add(new ListItem(vl.name, vl.id.ToString()));
            }
        }

        [WebMethod]
        public static List<GetAllQuestionList> getAllQuestionLists(string course_id, string sdate, string edate)
        {
            questionLists.Clear();
            try
            {
                wcf.parti.Service1 _parti = new wcf.parti.Service1();
                partiDB.RootObject rootObject = new partiDB.RootObject();
                if (questionLists.Count == 0)
                {
                    if (course_id == "0")
                    {
                        foreach (var i in gridDataCourses)
                        {
                            if (i.id == 0)
                            {
                                goto Line1;
                            }
                            else
                            {
                                string json_str = _parti.GetAllQuestionList(i.id.ToString(), sdate, edate);
                                if (json_str == "e0")//code error
                                {
                                    MessageBox.swalModal(_Page, "error", "e0:ລະບົບຂັດຂ້ອງຕິດຕໍ່ຜູ້ເບີ່ງແຍ່ງດ່ວນ.", "");
                                }
                                else if (json_str == "e1")//no data found
                                {
                                    MessageBox.swalModal(_Page, "info", "e1:ບໍ່ມີຂໍ້ມູນທີ່ຈະສະແດງ.", "");
                                }
                                else if (json_str == "e2")//can't connect database
                                {
                                    MessageBox.swalModal(_Page, "warning", "e2:ບໍ່ສາມາດເຊື່ອມຕໍ່ຖານຂໍ້ມູນໄດ້.", "");
                                }
                                else
                                {
                                    rootObject = JsonConvert.DeserializeObject<partiDB.RootObject>(json_str);
                                    foreach (var vl in rootObject.GetAllQuestionList)
                                    {
                                        questionLists.Add(new GetAllQuestionList(vl.t_id, vl.title, vl.course_name, vl.training_address, vl.org, vl.sdate, vl.edate));
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        string json_str = _parti.GetAllQuestionList(course_id, sdate, edate);
                        if (json_str == "e0")//code error
                        {
                            MessageBox.swalModal(_Page, "error", "e0:ລະບົບຂັດຂ້ອງຕິດຕໍ່ຜູ້ເບີ່ງແຍ່ງດ່ວນ.", "");
                        }
                        else if (json_str == "e1")//no data found
                        {
                            MessageBox.swalModal(_Page, "info", "e1:ບໍ່ມີຂໍ້ມູນທີ່ຈະສະແດງ.", "");
                        }
                        else if (json_str == "e2")//can't connect database
                        {
                            MessageBox.swalModal(_Page, "warning", "e2:ບໍ່ສາມາດເຊື່ອມຕໍ່ຖານຂໍ້ມູນໄດ້.", "");
                        }
                        else
                        {
                            rootObject = JsonConvert.DeserializeObject<partiDB.RootObject>(json_str);
                            foreach (var vl in rootObject.GetAllQuestionList)
                            {
                                questionLists.Add(new GetAllQuestionList(vl.t_id, vl.title, vl.course_name, vl.training_address, vl.org, vl.sdate, vl.edate));
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(_Page, "error", "e0:" + ex.Message, "");
            }
            Line1:
            return questionLists;
        }

        [WebMethod]
        public static string getCountUserAnswer(string q_type, string t_id, string q_id, string a_id)
        {
            string uan = null;
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            partiDB.RootObject rootObject = new partiDB.RootObject();
            try
            {
                string json_str = _parti.GetCountUserAnswer(q_type, t_id, q_id, a_id);
                if (json_str == "e0")//code error
                {
                    MessageBox.swalModal(_Page, "error", "e0:ລະບົບຂັດຂ້ອງຕິດຕໍ່ຜູ້ເບີ່ງແຍ່ງດ່ວນ.", "");
                }
                else if (json_str == "e1")//no data found
                {
                    MessageBox.swalModal(_Page, "info", "e1:ບໍ່ມີຂໍ້ມູນທີ່ຈະສະແດງ.", "");
                }
                else if (json_str == "e2")//can't connect database
                {
                    MessageBox.swalModal(_Page, "warning", "e2:ບໍ່ສາມາດເຊື່ອມຕໍ່ຖານຂໍ້ມູນໄດ້.", "");
                }
                else
                {
                    uan = json_str;
                }
            }
            catch(Exception ex)
            {
                MessageBox.swalModal(_Page, "error", "e0:" + ex.Message, "");
            }
            return uan;
        }

        public class GetAllQuestionList
        {
            public string t_id { get; set; }
            public string title { get; set; }
            public string course_name { get; set; }
            public string training_address { get; set; }
            public string org { get; set; }
            public string sdate { get; set; }
            public string edate { get; set; }

            public GetAllQuestionList(string t_id, string title, string course_name, string training_address, string org, DateTime sdate, DateTime edate)
            {
                this.t_id = t_id;
                this.title = title;
                this.course_name = course_name;
                this.training_address = training_address;
                this.org = org;
                this.sdate = sdate.ToString("yyyy-MM-dd");
                this.edate = edate.ToString("yyyy-MM-dd");
            }
        }
    }
}
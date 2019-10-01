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
    public partial class tcrpt02 : System.Web.UI.Page
    {
        public static List<Course.GetCourse> gridDataCourses = new List<Course.GetCourse>();
        public static Page _Page = new Page();
        public static List<GetCompareYearPlan> planByTimeRanges = new List<GetCompareYearPlan>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                RenderSelectCourse();
            }
        }

        [WebMethod]
        public static List<GetCompareYearPlan> yearPlanByTimeRanges(string courseID, string times_range, string QOrY)
        {
            planByTimeRanges.Clear();
            try
            {
                wcf.parti.Service1 _parti = new wcf.parti.Service1();
                partiDB.RootObject rootObject = new partiDB.RootObject();
                if (planByTimeRanges.Count == 0)
                {
                    if (courseID == "0")
                    {
                        foreach (var i in gridDataCourses)
                        {
                            if (i.id == 0)
                            {
                                goto Line1;
                            }
                            else
                            {
                                string json_str = _parti.GetCompareYearPlan(i.id.ToString(), times_range, QOrY);
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
                                    foreach (var vl in rootObject.GetCompareYearPlan)
                                    {
                                        planByTimeRanges.Add(new GetCompareYearPlan("", i.id.ToString(), vl.CourseName, vl.Targets, vl.DoneTarget));
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        string json_str = _parti.GetCompareYearPlan(courseID, times_range, QOrY);
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
                            foreach (var vl in rootObject.GetCompareYearPlan)
                            {
                                planByTimeRanges.Add(new GetCompareYearPlan("", vl.CourseID, vl.CourseName, vl.Targets, vl.DoneTarget));
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
            return planByTimeRanges;
        }

        public class GetCompareYearPlanByTimeRange
        {
            public string CourseID { get; set; }
            public string CourseName { get; set; }
            public string Targets { get; set; }
            public string DoneTarget { get; set; }

            public GetCompareYearPlanByTimeRange(string CourseID, string CourseName, string Targets, string DoneTarget)
            {
                this.CourseID = CourseID;
                this.CourseName = CourseName;
                this.Targets = Targets;
                this.DoneTarget = DoneTarget;
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
    }
}
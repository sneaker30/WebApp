using System;
using System.Collections.Generic;
using System.Web.UI;
using parti.admin.lib;
using Newtonsoft.Json;
using static parti.admin.YearPlans;
using static parti.admin.Course;
using System.Threading.Tasks;

namespace parti.admin
{
    public partial class _Default : Page
    {
        public static List<Course.GetCourse> gridDataCourses = new List<Course.GetCourse>();
        public static Page _Page = new Page();
        public static List<GetCompareYearPlan> planByTimeRanges = new List<GetCompareYearPlan>();
        public string thisyear = DateTime.Now.ToString("yyyy");

        protected void Page_Load(object sender, EventArgs e)
        {
            pieChart.DataSource = GetpieChart();
            pieChart.DataBind();
            columnChart.DataSource = SumYearPlanThisyear();
            columnChart.DataBind();
        }

        public List<SumYearlyCourse> GetpieChart()
        {
            List<@SumYearlyCourse> chartData = new List<@SumYearlyCourse>();
            try
            {
                wcf.parti.Service1 _parti = new wcf.parti.Service1();
                partiDB.RootObject rootObject = new partiDB.RootObject();

                string json_str = _parti.SumYearlyCourse();
                rootObject = JsonConvert.DeserializeObject<partiDB.RootObject>(json_str);
                foreach (var vl in rootObject.SumYearlyCourse)
                {
                    chartData.Add(new SumYearlyCourse(vl.course, vl.total, vl.course + ", " + vl.total.ToString("N")));
                }
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'", "") + "]", "");
            }
            return chartData;
        }

        public List<GetCompareYearPlan> SumYearPlanThisyear()
        {
            planByTimeRanges.Clear();
            try
            {
                wcf.parti.Service1 _parti = new wcf.parti.Service1();
                partiDB.RootObject rootObject = new partiDB.RootObject();
                gridDataCourses = GetgridData();
                if (planByTimeRanges.Count == 0)
                {
                    foreach (var i in gridDataCourses)
                    {
                        if (i.id == 0)
                        {
                            goto Line1;
                        }
                        else
                        {
                            string json_str = _parti.GetCompareYearPlan(i.id.ToString(), thisyear, "Y");
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
                                    planByTimeRanges.Add(new GetCompareYearPlan(thisyear, i.id.ToString(), vl.CourseName, vl.Targets, vl.DoneTarget));
                                }
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

        public class @SumYearlyCourse
        {
            public string Course;
            public int Total;
            public string Text;

            public SumYearlyCourse(string course, int total, string text)
            {
                this.Course = course;
                this.Total = total;
                this.Text = text;
            }
        }
    }
}
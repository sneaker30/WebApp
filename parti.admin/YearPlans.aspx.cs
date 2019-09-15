using Newtonsoft.Json;
using parti.admin.lib;
using Syncfusion.JavaScript.Web;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.WebControls;
using static parti.admin.Course;

namespace parti.admin
{
    public partial class YearPlans : System.Web.UI.Page
    {
        public static List<Course.GetCourse> gridDataCourses = new List<Course.GetCourse>();
        public static List<GetYearPlan> gridDataYearPlans = new List<GetYearPlan>();
        public static List<GetCompareYearPlan> chartCompareYearPlans = new List<GetCompareYearPlan>();
        public static Page _Page = new Page();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                RenderSelectCourse();
            }
            YearPlansGrid.DataSource = null;
            YearPlansGrid.DataSource = GetgridDataYearPlans();
            YearPlansGrid.DataBind();
        }

        private List<GetCompareYearPlan> GetCompareYear(string courseID, string QorY, string times_range)
        {
            try
            {
                chartCompareYearPlans.Clear();
                wcf.parti.Service1 _parti = new wcf.parti.Service1();
                partiDB.RootObject rootObject = new partiDB.RootObject();
                if (chartCompareYearPlans.Count == 0)
                {
                    string json_str = _parti.GetCompareYearPlan(courseID, times_range, QorY);
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
                        int tg = 0;
                        int dtg = 0;
                        rootObject = JsonConvert.DeserializeObject<partiDB.RootObject>(json_str);
                        foreach (var vl in rootObject.GetCompareYearPlan)
                        {
                            chartCompareYearPlans.Add(new GetCompareYearPlan(vl.PlanType, vl.CourseID, vl.CourseName, vl.Targets, vl.DoneTarget));
                            lblYearPlan.InnerText = vl.PlanType;
                            lblCourseName.InnerText = vl.CourseName;
                            lblTargets.InnerText = vl.Targets;
                            tg = Convert.ToInt16(vl.Targets);
                            lblDoneTarget.InnerText = vl.DoneTarget;
                            dtg = Convert.ToInt16(vl.DoneTarget);
                        }
                        if (dtg > tg)
                        {
                            dtg = (dtg * 100) / tg;
                            lblDetails.InnerText = "ປະຕິບັດໄດ້ລື່ນຄາດຫມາຍຄິດໄລ່ເປັນ " + dtg + " ສ່ວນຮ້ອຍຂອງໂຕເລກຄາດຫມາຍ.";
                        }
                        else if (dtg < tg)
                        {
                            dtg = (dtg * 100) / tg;
                            lblDetails.InnerText = "ປະຕິບັດໄດ້ລຸດຄາດຫມາຍຄິດໄລ່ເປັນ " + dtg + " ສ່ວນຮ້ອຍຂອງໂຕເລກຄາດຫມາຍ.";
                        }
                        else if (dtg == tg)
                        {
                            dtg = (dtg * 100) / tg;
                            lblDetails.InnerText = "ປະຕິບັດໄດ້ຕາມຄາດຫມາຍຄິດໄລ່ເປັນ " + dtg + " ສ່ວນຮ້ອຍຂອງໂຕເລກຄາດຫມາຍ.";
                        }
                    }
                }
            }
            catch (Exception)
            {
                chartCompareYearPlans = null;
            }
            return chartCompareYearPlans;
        }

        private void RenderChartYearPlan()
        {
            string timesrange = null;

            if (selYearPlan.Value == "Q")
            {
                timesrange = txtQuarter.Value;
            }
            else if (selYearPlan.Value == "Y")
            {
                timesrange = txtYear.Value;
            }
            ChartYearPlans.DataSource = null;
            ChartYearPlans.DataSource = null;
            ChartYearPlans.DataSource = GetCompareYear(selCourse2.Value, selYearPlan.Value, timesrange);
            ChartYearPlans.DataBind();
        }

        private void RenderSelectCourse()
        {
            gridDataCourses = GetgridData();
            selCourse2.Items.Clear();
            course_id.Items.Clear();
            foreach (var vl in gridDataCourses)
            {
                selCourse2.Items.Add(new ListItem(vl.name, vl.id.ToString()));
                course_id.Items.Add(new ListItem(vl.name, vl.id.ToString()));
            }
        }

        public static List<GetYearPlan> GetgridDataYearPlans()
        {
            try
            {
                gridDataYearPlans.Clear();
                wcf.parti.Service1 _parti = new wcf.parti.Service1();
                partiDB.RootObject rootObject = new partiDB.RootObject();
                if (gridDataYearPlans.Count == 0)
                {
                    string json_str = _parti.GetYearPlans("");
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
                        foreach (var vl in rootObject.GetYearPlans)
                        {
                            gridDataYearPlans.Add(new GetYearPlan(vl.id, vl.year_plan, vl.course_id, vl.target));
                        }
                    }
                }
            }
            catch (Exception)
            {
                gridDataYearPlans = null;
            }
            return gridDataYearPlans;
        }

        private void ReloadData(string result)
        {
            if (result == "e5")
            {
                //reload grid
                YearPlansGrid.DataSource = null;
                YearPlansGrid.DataSource = GetgridDataYearPlans();
                YearPlansGrid.DataBind();
            }
            else if (result == "e2")
            {
                MessageBox.swalModal(this.Page, "warning", "e2:ບໍ່ສາມາດເຊື່ອມຕໍ່ຖານຂໍ້ມູນໄດ້.", "");
            }
            else if (result == "e1")
            {
                MessageBox.swalModal(this.Page, "info", "e1:ບໍ່ມີຂໍ້ມູນທີ່ຈະສະແດງ.", "");
            }
            else if (result == "e0")
            {
                MessageBox.swalModal(this.Page, "error", "e0:ລະບົບຂັດຂ້ອງຕິດຕໍ່ຜູ້ເບີ່ງແຍ່ງດ່ວນ.", "");
            }
        }

        [Serializable]
        public class GetCompareYearPlan
        {
            public string PlanType { get; set; }
            public string CourseID { get; set; }
            public string CourseName { get; set; }
            public string Targets { get; set; }
            public string DoneTarget { get; set; }

            public GetCompareYearPlan(string planType, string courseId, string courseName, string targets, string doneTarget)
            {
                this.PlanType = planType;
                this.CourseID = courseId;
                this.CourseName = courseName;
                this.Targets = targets;
                this.DoneTarget = doneTarget;
            }
        }

        [Serializable]
        public class GetYearPlan
        {
            public int id { get; set; }
            public string year_plan { get; set; }
            public string course_id { get; set; }
            public int target { get; set; }

            public GetYearPlan(int _id, string _year_plan, string _course_id, int _target)
            {
                id = _id;
                year_plan = _year_plan;
                course_id = _course_id;
                target = _target;
            }
        }

        protected void YearPlansGrid_OnServerAddRow(object sender, GridEventArgs e)
        {
            try
            {
                EditAction(e.EventType, e.Arguments["data"]);
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'", "") + "]", "");
            }
        }

        protected void YearPlansGrid_OnServerDeleteRow(object sender, GridEventArgs e)
        {
            try
            {
                EditAction(e.EventType, e.Arguments["data"]);
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'", "") + "]", "");
            }
        }

        protected void YearPlansGrid_OnServerEditRow(object sender, GridEventArgs e)
        {
            try
            {
                EditAction(e.EventType, e.Arguments["data"]);
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'", "") + "]", "");
            }
        }

        protected void EditAction(string eventType, object record)
        {
            try
            {
                partiDB.GetYearPlan claYearPlan = new partiDB.GetYearPlan();
                Dictionary<string, object> KeyVal = record as Dictionary<string, object>;
                //foreach (KeyValuePair<string, object> key in KeyVal)
                //{

                //}

                if (eventType == "endAdd")
                {
                    Parallel.ForEach(KeyVal, key =>
                    {
                        if (key.Key == "year_plan")
                        {
                            claYearPlan.year_plan = (string)key.Value;
                        }
                        else if (key.Key.Contains("course_id"))
                        {
                            claYearPlan.course_id = key.Value.ToString();
                        }
                        else if (key.Key == "target")
                        {
                            claYearPlan.target = (int)key.Value;
                        }
                    });
                    //wcf add users
                    wcf.parti.Service1 _parti = new wcf.parti.Service1();
                    var result = _parti.EditYearPlans("add", claYearPlan.id, true, claYearPlan.year_plan,
                        claYearPlan.course_id, claYearPlan.target, true);
                    ReloadData(result);
                }
                else if (eventType == "endEdit")
                {
                    Parallel.ForEach(KeyVal, key =>
                    {
                        if (key.Key == "id")
                        {
                            claYearPlan.id = (int)key.Value;
                        }
                        else if (key.Key == "year_plan")
                        {
                            claYearPlan.year_plan = (string)key.Value;
                        }
                        else if (key.Key.Contains("course_id"))
                        {
                            claYearPlan.course_id = key.Value.ToString();
                        }
                        else if (key.Key == "target")
                        {
                            claYearPlan.target = (int)key.Value;
                        }
                    });
                    //wcf update data
                    wcf.parti.Service1 _parti = new wcf.parti.Service1();
                    var result = _parti.EditYearPlans("edit", claYearPlan.id, true, claYearPlan.year_plan,
                        claYearPlan.course_id, claYearPlan.target, true);
                    ReloadData(result);
                }
                else if (eventType == "endDelete")
                {
                    Parallel.ForEach(KeyVal, key =>
                    {
                        if (key.Key == "id")
                        {
                            claYearPlan.id = (int)key.Value;
                        }
                        else if (key.Key == "year_plan")
                        {
                            claYearPlan.year_plan = (string)key.Value;
                        }
                        else if (key.Key.Contains("course_id"))
                        {
                            claYearPlan.course_id = key.Value.ToString();
                        }
                        else if (key.Key == "target")
                        {
                            claYearPlan.target = (int)key.Value;
                        }
                    });
                    //wcf delete data
                    wcf.parti.Service1 _parti = new wcf.parti.Service1();
                    var result = _parti.EditYearPlans("del", claYearPlan.id, true, claYearPlan.year_plan,
                        claYearPlan.course_id, claYearPlan.target, true);
                    ReloadData(result);
                }
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'", "") + "]", "");
            }
        }

        protected void btnCompare_OnServerClick(object sender, EventArgs e)
        {
            RenderChartYearPlan();
            Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", "<script>ScrollDownCompare();</script>", false);
        }
    }
}
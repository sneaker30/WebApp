using System;
using System.Collections.Generic;
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
    }
}
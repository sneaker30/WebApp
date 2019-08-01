using System;
using System.Collections.Generic;
using System.Web.UI;
using parti.admin.lib;
using Newtonsoft.Json;

namespace parti.admin
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            pieChart.DataSource = GetpieChart();
            pieChart.DataBind();
            columnChart.DataSource = GetpieChart();
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
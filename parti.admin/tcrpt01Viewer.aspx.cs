using Newtonsoft.Json;
using parti.admin.lib;
using Syncfusion.JavaScript.Web;
using System;
using System.Collections.Generic;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;

namespace parti.admin
{
    public partial class tcrpt01Viewer : System.Web.UI.Page
    {
        public static List<trainingrpt01> listTrainingrpt01s = new List<trainingrpt01>();
        public static Page _Page = new Page();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static List<trainingrpt01> GetRPT01Info(string type, string sdate, string edate)
        {
            listTrainingrpt01s.Clear();
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            partiDB.RootObject rootObject = new partiDB.RootObject();
            if (listTrainingrpt01s.Count == 0)
            {
                string json_str = _parti.GetTrainingRPT01(type, sdate, edate);
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
                    foreach (var vl in rootObject.trainingrpt01)
                    {
                        listTrainingrpt01s.Add(new trainingrpt01(vl.course_id, vl.course_name, vl.training_id, vl.title,
                                vl.total_trainee, vl.date_range, vl.organizer, vl.total_event, vl.training_address, vl.total_trainee_fmale));
                    }
                }
            }

            return listTrainingrpt01s;
        }

        public class trainingrpt01
        {
             public string course_id { get; set; }
            public string course_name { get; set; }
            public string training_id { get; set; }
            public string title { get; set; }
            public string total_trainee { get; set; }
            public string date_range { get; set; }
            public string organizer { get; set; }
            public string total_event { get; set; }
            public string training_address { get; set; }
            public string total_trainee_fmale { get; set; }

            public trainingrpt01(string course_id, string course_name, string training_id, string title, string total_trainee,
                string date_range, string organizer, string total_event, string training_address, string total_trainee_fmale)
            {
                this.course_id = course_id;
                this.course_name = course_name;
                this.training_id = training_id;
                this.title = title;
                this.total_trainee = total_trainee;
                this.date_range = date_range;
                this.organizer = organizer;
                this.total_event = total_event;
                this.training_address = training_address;
                this.total_trainee_fmale = total_trainee_fmale;
            }
        }
    }
}
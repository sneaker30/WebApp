using Newtonsoft.Json;
using parti.admin.lib;
using Syncfusion.EJ.Export;
using Syncfusion.XlsIO;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.UI;

namespace parti.admin
{
    public partial class Course : System.Web.UI.Page
    {
        public static List<GetCourse> gridData = new List<GetCourse>();
        public static Page _Page = new Page();

        [Serializable]
        public class GetCourse
        {
            public int id { get; set; }
            public string name { get; set; }
            public string description { get; set; }

            public GetCourse(int _id, string _name, string _description)
            {
                this.id = _id;
                this.name = _name;
                this.description = _description;
            }
        }

        public static List<GetCourse> GetgridData()
        {
            gridData.Clear();
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            partiDB.RootObject rootObject = new partiDB.RootObject();
            if (gridData.Count == 0)
            {
                string json_str = _parti.GetCourse();
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
                    foreach (var vl in rootObject.GetCourse)
                    {
                        gridData.Add(new GetCourse(vl.id, vl.name, vl.description));
                    }
                }
            }
            return gridData;
        }

        private void ReloadData(string result)
        {
            if (result == "e5")
            {
                //reload grid
                courseGrid.DataSource = null;
                courseGrid.DataSource = GetgridData();
                courseGrid.DataBind();
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

        protected void EditAction(string eventType, object record)
        {
            try
            {
                partiDB.GetCourse claCourse = new partiDB.GetCourse();
                Dictionary<string, object> KeyVal = record as Dictionary<string, object>;

                Parallel.ForEach(KeyVal, key =>
                {
                    if (key.Key == "id")
                    {
                        claCourse.id = (int)key.Value;
                    }
                    else if (key.Key == "name")
                    {
                        claCourse.name = (string)key.Value;
                    }
                    else if (key.Key == "description")
                    {
                        claCourse.description = (string)key.Value;
                    }
                });

                if (eventType == "endAdd")
                {
                    //wcf add users
                    wcf.parti.Service1 _parti = new wcf.parti.Service1();
                    var result = _parti.EditCourse("add", claCourse.id, true, claCourse.name, claCourse.description);
                    ReloadData(result);
                    _parti.LoggingAsync("set", "Course", "user: " + Session["username"].ToString() + " had add new Course: " + 
                        claCourse.name + " to system", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"), "");
                }
                else if (eventType == "endEdit")
                {
                    //wcf update data
                    wcf.parti.Service1 _parti = new wcf.parti.Service1();
                    var result = _parti.EditCourse("edit", claCourse.id, true, claCourse.name, claCourse.description);
                    ReloadData(result);
                    _parti.LoggingAsync("set", "Course", "user: " + Session["username"].ToString() + " had edit a Course: " +
                        claCourse.name + " on system", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"), "");
                }
                else if (eventType == "endDelete")
                {
                    //wcf delete data
                    wcf.parti.Service1 _parti = new wcf.parti.Service1();
                    var result = _parti.EditCourse("del", claCourse.id, true, claCourse.name, claCourse.description);
                    ReloadData(result);
                    _parti.LoggingAsync("set", "Course", "user: " + Session["username"].ToString() + " had delete a Course: " +
                        claCourse.name + " from system", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"), "");
                }
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'","") + "]", "");
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            courseGrid.DataSource = null;
            courseGrid.DataSource = GetgridData();
            courseGrid.DataBind();
        }

        protected void courseGrid_ServerAddRow(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)
        {
            try
            {
                EditAction(e.EventType, e.Arguments["data"]);
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'","") + "]", "");
            }
        }

        protected void courseGrid_ServerEditRow(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)
        {
            try
            {
                EditAction(e.EventType, e.Arguments["data"]);
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'","") + "]", "");
            }
        }

        protected void courseGrid_ServerDeleteRow(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)
        {
            try
            {
                EditAction(e.EventType, e.Arguments["data"]);
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'","") + "]", "");
            }
        }

        protected void courseGrid_ServerExcelExporting(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)
        {
            try
            {
                ExcelExport exp = new ExcelExport();
                exp.Export(courseGrid.Model, (IEnumerable)courseGrid.DataSource, "Export.xlsx", ExcelVersion.Excel2010, true, true, "flat-lime");
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'","") + "]", "");
            }
        }

        protected void courseGrid_ServerPdfExporting(object sender, Syncfusion.JavaScript.Web.GridEventArgs e)
        {
            try
            {
                PdfExport exp = new PdfExport();
                exp.Export(courseGrid.Model, (IEnumerable)courseGrid.DataSource, "Export.pdf", false, false, true, "flat-lime");
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'","") + "]", "");
            }
        }
    }
}
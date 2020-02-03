using Newtonsoft.Json;
using parti.admin.lib;
using Syncfusion.EJ.Export;
using Syncfusion.JavaScript.Web;
using Syncfusion.XlsIO;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Web.UI;

namespace parti.admin
{
    public partial class Logs : System.Web.UI.Page
    {
        public static List<GetLogs> gridData = new List<GetLogs>();
        public static Page _Page = new Page();

        protected void Page_Load(object sender, EventArgs e)
        {
            LogsGrid.DataSource = null;
            LogsGrid.DataSource = GetgridData("", "", "");
            LogsGrid.DataBind();
        }

        public static List<GetLogs> GetgridData(string searchtxt, string date1, string date2)
        {
            gridData.Clear();
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            partiDB.RootObject rootObject = new partiDB.RootObject();

            string json_str = _parti.LoggingAsync("get", "Logs", searchtxt, date1, date2);
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
                foreach (var vl in rootObject.GetLogs)
                {
                    gridData.Add(new GetLogs(vl.id, vl.method, vl.log_txt, vl.date_time));
                }
            }

            return gridData;
        }

        [Serializable]
        public class GetLogs
        {
            public int id { get; set; }
            public string method { get; set; }
            public string log_txt { get; set; }
            public string date_time { get; set; }

            public GetLogs(int id, string method, string log_txt, string date_time)
            {
                this.id = id;
                this.method = method;
                this.log_txt = log_txt;
                this.date_time = date_time;
            }
        }

        protected void usersGrid_ServerExcelExporting(object sender, GridEventArgs e)
        {
            try
            {
                ExcelExport exp = new ExcelExport();
                GridExcelExport excelExport = new GridExcelExport();
                excelExport.FileName = "Export.xlsx";
                excelExport.IsTemplateColumnIncluded = true;
                excelExport.IsHideColumnIncude = true;
                excelExport.Excelversion = ExcelVersion.Excel2010;
                excelExport.Theme = "flat-lime";
                exp.Export(LogsGrid.Model, (IEnumerable)LogsGrid.DataSource, excelExport);
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'", "") + "]", "");
            }
        }

        protected void usersGrid_ServerPdfExporting(object sender, GridEventArgs e)
        {
            try
            {
                PdfExport exp = new PdfExport();
                exp.Export(LogsGrid.Model, (IEnumerable)LogsGrid.DataSource, "Export.pdf", false, false, true, "flat-lime");
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'", "") + "]", "");
            }
        }
    }
}
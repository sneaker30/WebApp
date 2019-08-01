using Newtonsoft.Json;
using parti.admin.lib;
using Syncfusion.EJ.Export;
using Syncfusion.JavaScript.Web;
using Syncfusion.XlsIO;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.UI;

namespace parti.admin
{
    public partial class Users : Page
    {
        public static List<GetUsers> gridData = new List<GetUsers>();
        public static GetSetEnCoding enCoding = new GetSetEnCoding();
        public static Page _Page = new Page();

        protected void Page_Load(object sender, EventArgs e)
        {
            usersGrid.DataSource = null;
            usersGrid.DataSource = GetgridData();
            usersGrid.DataBind();
        }

        public static List<GetUsers> GetgridData()
        {
            gridData.Clear();
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            partiDB.RootObject rootObject = new partiDB.RootObject();

            string json_str = _parti.GetUsers("");
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
                foreach (var vl in rootObject.GetUsers)
                {
                    gridData.Add(new GetUsers(vl.id, vl.username, enCoding.GetDecryptData(vl.passwd), vl.rules));
                }
            }

            return gridData;
        }

        [Serializable]
        public class GetUsers
        {
            public int id { get; set; }
            public string username { get; set; }
            public string passwd { get; set; }
            public string rules { get; set; }

            public GetUsers(int _id, string _username, string _passwd, string _rules)
            {
                this.id = _id;
                this.username = _username;
                this.passwd = _passwd;
                this.rules = _rules;
            }
        }

        protected void usersGrid_ServerAddRow(object sender, GridEventArgs e)
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

        protected void usersGrid_ServerEditRow(object sender, GridEventArgs e)
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

        protected void usersGrid_ServerDeleteRow(object sender, GridEventArgs e)
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

        protected void EditAction(string eventType, object record)
        {
            try
            {
                partiDB.GetUsers claUsers = new partiDB.GetUsers();
                Dictionary<string, object> KeyVal = record as Dictionary<string, object>;

                Parallel.ForEach(KeyVal, key =>
                {
                    if (key.Key == "id")
                    {
                        claUsers.id = (int) key.Value;
                    }
                    else if (key.Key == "username")
                    {
                        claUsers.username = (string) key.Value;
                    }
                    else if (key.Key == "passwd")
                    {
                        claUsers.passwd = (string) key.Value;
                    }
                    else if (key.Key == "rules")
                    {
                        claUsers.rules = (string) key.Value;
                    }
                });

                if (eventType == "endAdd")
                {
                    //wcf add users
                    wcf.parti.Service1 _parti = new wcf.parti.Service1();
                    var result = _parti.EditUsers("add", claUsers.id, true, claUsers.username, enCoding.SetEncryptData(claUsers.passwd), claUsers.rules);
                    ReloadData(result);
                }
                else if (eventType == "endEdit")
                {
                    //wcf update data
                    wcf.parti.Service1 _parti = new wcf.parti.Service1();
                    var result = _parti.EditUsers("edit", claUsers.id, true, claUsers.username, enCoding.SetEncryptData(claUsers.passwd), claUsers.rules);
                    ReloadData(result);
                }
                else if (eventType == "endDelete")
                {
                    //delete data
                    wcf.parti.Service1 _parti = new wcf.parti.Service1();
                    var result = _parti.EditUsers("del", claUsers.id, true, claUsers.username, enCoding.SetEncryptData(claUsers.passwd), claUsers.rules);
                    ReloadData(result);
                }
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'","") + "]", "");
            }
        }

        private void ReloadData(string result)
        {
            if (result == "e5")
            {
                //reload grid
                usersGrid.DataSource = null;
                usersGrid.DataSource = GetgridData();
                usersGrid.DataBind();
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
                exp.Export(usersGrid.Model, (IEnumerable)usersGrid.DataSource, excelExport);
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'","") + "]", "");
            }
        }

        protected void usersGrid_ServerPdfExporting(object sender, GridEventArgs e)
        {
            try
            {
                PdfExport exp = new PdfExport();
                exp.Export(usersGrid.Model, (IEnumerable)usersGrid.DataSource, "Export.pdf", false, false, true, "flat-lime");
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'","") + "]", "");
            }
        }
    }
}
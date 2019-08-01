using Newtonsoft.Json;
using parti.admin.lib;
using System;
using System.Collections.Generic;
using System.IO;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;

namespace parti.admin
{
    public partial class Trainee : System.Web.UI.Page
    {
        public static List<GetTraineeList> TraineeLists = new List<GetTraineeList>();
        public static Page _Page = new Page();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                GetTraineeLists();
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'", "") + "]", "");
            }
        }

        [WebMethod]
        public static GetTraineeList GetTraineeInfo(int TraineeID)
        {
            GetTraineeList getTrainee;
            getTrainee = TraineeLists[TraineeID];

            return getTrainee;
        }

        public List<GetTraineeList> GetTraineeLists()
        {
            TraineeLists.Clear();
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            partiDB.RootObject rootObject = new partiDB.RootObject();

            string json_str = _parti.GetTraineeList("");
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
                int i = 1;
                rootObject = JsonConvert.DeserializeObject<partiDB.RootObject>(json_str);
                foreach (var vl in rootObject.GetTraineeList)
                {
                    TraineeLists.Add(new GetTraineeList(vl.id, vl.name, vl.faminame, vl.date_of_birth, vl.sex, vl.work_place,
                        vl.position, vl.date_of_modified_data, vl.doc_url));
                    //Render Table
                    HtmlElement _tbody = new HtmlElement();
                    _tbody.InnerHtml = "<tr id='" + i + "' class='search_result'>" +
                                       "<td>" + i + "</td>" +
                                       "<td>" + vl.name + " " + vl.faminame + "</td>" +
                                       "<td>" + vl.work_place + "</td>" +
                                       "<td><div class='row'><div class='col'>" +
                                       "<button type='button' class='btn-small z-depth-3 teal darken-2 tooltipped hvr-grow-shadow modal-trigger' " +
                                       "href='#modalTrainee' data-position='left' data-tooltip='ແກ້ໄຂຂໍ້ມູນ' id='" + (i - 1) + "' " +
                                       "onclick='SetTraineeInfo(this.id)'><i class='material-icons'>edit</i></button>" +
                                       "</div>&nbsp;<div class='col'></div></div></td></tr>";
                    tbBody.Controls.Add(_tbody);
                    i++;
                }
                lblTotalTrainer.InnerText = (i - 1).ToString();
            }
            return TraineeLists;
        }

        public class GetTraineeList
        {
            public string id { get; set; }
            public string name { get; set; }
            public string faminame { get; set; }
            public string date_of_birth { get; set; }
            public string sex { get; set; }
            public string work_place { get; set; }
            public string position { get; set; }
            public string date_of_modified_data { get; set; }
            public string doc_url { get; set; }

            public GetTraineeList(string id, string name, string faminame, DateTime date_of_birth, string sex, string work_place, string position, DateTime date_of_modified_data, string doc_url)
            {
                this.id = id;
                this.name = name;
                this.faminame = faminame;
                this.date_of_birth = date_of_birth.ToString("MM/dd/yyyy");
                this.sex = sex;
                this.work_place = work_place;
                this.position = position;
                this.date_of_modified_data = date_of_modified_data.ToString("MM/dd/yyyy");
                this.doc_url = doc_url;
            }

        }

        protected void btnDel_OnClick(object sender, EventArgs e)
        {
            try
            {
                wcf.parti.Service1 _parti = new wcf.parti.Service1();
                string action = "del";
                string sex = null;
                string picture_url = null;
                string renamePath = Server.MapPath(txtReferDocHidd.Value);

                string result = _parti.EditTrainee(action, txtIDHid.Value, txtName.Value, txtfaminame.Value, dtpBD.Value, sex, 
                    txtworkPlace.Value, txtPosition.Value, picture_url);

                if (result == "e3")
                {
                    MessageBox.swalModal(this.Page, "info", "e3: ມີລະຫັດນີ້ໃນຖານຂໍ້ມູນແລ້ວ ລອງໃສ່ລະຫັດໃຫມ່...", "");
                }
                else if (result == "e0")
                {
                    MessageBox.swalModal(this.Page, "error", "en:internal error", "");
                }
                else if (result == "e2")
                {
                    MessageBox.swalModal(this.Page, "warning", "e2:connection to dbs error...", "");
                }
                else if (result == "e5")
                {
                    if (txtReferDocHidd.Value != "")
                    {
                        File.Delete(renamePath);
                    }
                    string currentPage = Request.RawUrl;
                    MessageBox.swalModal(this.Page, "success", "ຈັດການຂໍ້ມູນສຳເລັດ...", currentPage);
                }
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'", "") + "]", "");
            }
        }

        protected void btnSave_OnClick(object sender, EventArgs e)
        {
            try
            {
                wcf.parti.Service1 parti = new wcf.parti.Service1();
                var action = btnState.Value.ToString();
                string sex = null;
                string picture_url = null;
                string txtid = null;
                if (string.IsNullOrEmpty(txtReferDoc.PostedFile.FileName) == false)
                {
                    var imgfile = Path.GetFileName(txtReferDoc.PostedFile.FileName);
                    var imgfilePath = Server.MapPath("traineedocs/") + imgfile;
                    var extension = Path.GetExtension(imgfilePath);
                    var renamePath = Server.MapPath("traineedocs/") + txtIDHid.Value + extension;
                    picture_url = "traineedocs/" + txtIDHid.Value + extension;
                    txtReferDoc.SaveAs(imgfilePath);
                    if (File.Exists(renamePath))
                    {
                        File.Delete(renamePath);
                    }
                    File.Move(imgfilePath, renamePath);
                }
                else
                {
                    picture_url = txtReferDocHidd.Value;
                }

                if (rdMale.Checked)
                {
                    sex = "m";
                }
                else if (rdFamale.Checked)
                {
                    sex = "f";
                }

                txtid = txtIDHid.Value;
                var result = parti.EditTrainee(action, txtid, txtName.Value, txtfaminame.Value, dtpBD.Value, sex, txtworkPlace.Value,
                    txtPosition.Value, picture_url);

                if (result == "e3")
                {
                    MessageBox.swalModal(this.Page, "info", "e3: ມີ ລະຫັດ/ຊື່ຜູ້ໃຊ້ ນີ້ໃນຖານຂໍ້ມູນແລ້ວ ລອງໃສ່ ລະຫັດ/ຊື່ຜູ້ໃຊ້ ໃຫມ່...", "");
                }
                else if (result == "e0")
                {
                    MessageBox.swalModal(this.Page, "error", "en:internal error", "");
                }
                else if (result == "e2")
                {
                    MessageBox.swalModal(this.Page, "warning", "e2:connection to dbs error...", "");
                }
                else if (result == "e5")
                {
                    MessageBox.swalModal(this.Page, "success", "ຈັດການຂໍ້ມູນສຳເລັດ...", Request.RawUrl);
                }
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'", "") + "]", "");
            }
        }
    }
}
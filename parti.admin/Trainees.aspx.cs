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
                    TraineeLists.Add(new GetTraineeList(vl.id, vl.fullname_la, vl.fullname_eng, vl.date_of_birth, vl.sex, vl.status, vl.village, vl.district,
                        vl.province, vl.work_place, vl.department, vl.position, vl.date_of_govermented, vl.office_tel, vl.mobile_tel, vl.email, vl.avatar_url,
                        vl.approval_id, vl.doc1_url, vl.doc2_url, vl.doc3_url, vl.doc4_url, vl.doc5_url, vl.date_of_modified_data));
                    //Render Table
                    HtmlElement _tbody = new HtmlElement();
                    //_tbody.InnerHtml = "<tr id='" + i + "' class='search_result'>" +
                    //                   "<td>" + i + "</td>" +
                    //                   "<td>" + vl.name + " " + vl.faminame + "</td>" +
                    //                   "<td>" + vl.work_place + "</td>" +
                    //                   "<td><div class='row'><div class='col'>" +
                    //                   "<button type='button' class='btn-small z-depth-3 teal darken-2 tooltipped hvr-grow-shadow modal-trigger' " +
                    //                   "href='#modalTrainee' data-position='left' data-tooltip='ແກ້ໄຂຂໍ້ມູນ' id='" + (i - 1) + "' " +
                    //                   "onclick='SetTraineeInfo(this.id)'><i class='material-icons'>edit</i></button>" +
                    //                   "</div>&nbsp;<div class='col'></div></div></td></tr>";

                    _tbody.InnerHtml = "<tr id='" + i + "' class='search_result'>" +
                                       "<td>" + i + "</td>" +
                                       "<td><img class='materialboxed circle z-depth-3' width='50' " +
                                       "height='50' src='" + vl.avatar_url + "'></td>" +
                                       "<td>" + vl.id + "</td>" +
                                       "<td>" + vl.fullname_la + "</td>" +
                                       "<td>" + vl.work_place + "</td>" +
                                       "<td><div class='row'><div class='col'><button type='button' " +
                                       "class='btn-small z-depth-3 teal darken-2 tooltipped hvr-grow-shadow modal-trigger' " +
                                       "href='#modalTrainee' data-position='left' data-tooltip='ແກ້ໄຂຂໍ້ມູນ' " +
                                       "id='" + (i - 1) + "' onclick='SetTraineeInfo(this.id)'>" +
                                       "<i class='material-icons'>edit</i></button></div></div></td></tr>";

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
            public string fullname_la { get; set; }
            public string fullname_eng { get; set; }
            public DateTime date_of_birth { get; set; }
            public string sex { get; set; }
            public string status { get; set; }
            public string village { get; set; }
            public string district { get; set; }
            public string province { get; set; }
            public string work_place { get; set; }
            public string department { get; set; }
            public string position { get; set; }
            public DateTime date_of_govermented { get; set; }
            public string office_tel { get; set; }
            public string mobile_tel { get; set; }
            public string email { get; set; }
            public string avatar_url { get; set; }
            public string approval_id { get; set; }
            public string doc1_url { get; set; }
            public string doc2_url { get; set; }
            public string doc3_url { get; set; }
            public string doc4_url { get; set; }
            public string doc5_url { get; set; }
            public string appr_fullname { get; set; }
            public string appr_position_name { get; set; }
            public string appr_position_major { get; set; }
            public string appr_relationship_trainee { get; set; }
            public string appr_office_name { get; set; }
            public string appr_office_tel { get; set; }
            public string appr_mobile_tel { get; set; }
            public string appr_email { get; set; }

            public GetTraineeList(string id, string fullname_la, string fullname_eng, DateTime date_of_birth, string sex, string status, string village,
                string district, string province, string work_place, string department, string position, DateTime date_of_govermented, string office_tel,
                string mobile_tel, string email, string avatar_url, string approval_id, string doc1_url, string doc2_url, string doc3_url, string doc4_url,
                string doc5_url, DateTime date_of_modified_data, string appr_fullname, string appr_position_name, string appr_position_major
                string appr_relationship_trainee, string appr_office_name, string appr_office_tel, string appr_mobile_tel, string appr_email)
            {
                this.id = id;
                this.fullname_la = fullname_la;
                this.fullname_eng = fullname_eng;
                this.date_of_birth = date_of_birth;
                this.sex = sex;
                this.status = status;
                this.village = village;
                this.district = district;
                this.province = province;
                this.work_place = work_place;
                this.department = department;
                this.position = position;
                this.date_of_govermented = date_of_govermented;
                this.office_tel = office_tel;
                this.mobile_tel = mobile_tel;
                this.email = email;
                this.avatar_url = avatar_url;
                this.approval_id = approval_id;
                this.doc1_url = doc1_url;
                this.doc2_url = doc2_url;
                this.doc3_url = doc3_url;
                this.doc4_url = doc4_url;
                this.doc5_url = doc5_url;
                this.appr_fullname = appr_fullname;
                this.appr_position_name = appr_position_name;
                this.appr_position_major = appr_position_major;
                this.appr_relationship_trainee = appr_relationship_trainee;
                this.appr_office_name = appr_office_name;
                this.appr_office_tel = appr_office_tel;
                this.appr_mobile_tel = appr_mobile_tel;
                this.appr_email = appr_email;
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
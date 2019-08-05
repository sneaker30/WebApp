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
                        vl.approval_id, vl.doc1_url, vl.doc2_url, vl.doc3_url, vl.doc4_url, vl.doc5_url, vl.appr_id, vl.appr_fullname, vl.appr_position_name, vl.appr_position_major,
                        vl.appr_relationship_trainee, vl.appr_office_name, vl.appr_office_tel, vl.appr_mobile_tel, vl.appr_email, vl.education_level, vl.education_major,
                        vl.education_country, vl.education_year, vl.education_name));
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
            public string appr_id { get; set; }
            public string appr_fullname { get; set; }
            public string appr_position_name { get; set; }
            public string appr_position_major { get; set; }
            public string appr_relationship_trainee { get; set; }
            public string appr_office_name { get; set; }
            public string appr_office_tel { get; set; }
            public string appr_mobile_tel { get; set; }
            public string appr_email { get; set; }
            public string education_level { get; set; }
            public string education_major { get; set; }
            public string education_country { get; set; }
            public string education_year { get; set; }
            public string education_name { get; set; }


            public GetTraineeList(string _id, string _fullname_la, string _fullname_eng, DateTime _date_of_birth, string _sex, string _status, string _village,
                string _district, string _province, string _work_place, string _department, string _position, DateTime _date_of_govermented, string _office_tel,
                string _mobile_tel, string _email, string _avatar_url, string _approval_id, string _doc1_url, string _doc2_url, string _doc3_url, string _doc4_url,
                string _doc5_url, string _appr_id, string _appr_fullname, string _appr_position_name, string _appr_position_major,
                string _appr_relationship_trainee, string _appr_office_name, string _appr_office_tel, string _appr_mobile_tel, string _appr_email, string _education_level,
                string _education_major, string _education_country, string _education_year, string _education_name)
            {
                this.id = _id;
                this.fullname_la = _fullname_la;
                this.fullname_eng = _fullname_eng;
                this.date_of_birth = _date_of_birth;
                this.sex = _sex;
                this.status = _status;
                this.village = _village;
                this.district = _district;
                this.province = _province;
                this.work_place = _work_place;
                this.department = _department;
                this.position = _position;
                this.date_of_govermented = _date_of_govermented;
                this.office_tel = _office_tel;
                this.mobile_tel = _mobile_tel;
                this.email = _email;
                this.avatar_url = _avatar_url;
                this.approval_id = _approval_id;
                this.doc1_url = _doc1_url;
                this.doc2_url = _doc2_url;
                this.doc3_url = _doc3_url;
                this.doc4_url = _doc4_url;
                this.doc5_url = _doc5_url;
                this.appr_id = _appr_id;
                this.appr_fullname = _appr_fullname;
                this.appr_position_name = _appr_position_name;
                this.appr_position_major = _appr_position_major;
                this.appr_relationship_trainee = _appr_relationship_trainee;
                this.appr_office_name = _appr_office_name;
                this.appr_office_tel = _appr_office_tel;
                this.appr_mobile_tel = _appr_mobile_tel;
                this.appr_email = _appr_email;
                this.education_level = _education_level;
                this.education_major = _education_major;
                this.education_country = _education_country;
                this.education_year = _education_year;
                this.education_name = _education_name;
            }
        }

        protected void btnDel_OnClick(object sender, EventArgs e)
        {
            try
            {
                wcf.parti.Service1 _parti = new wcf.parti.Service1();
                string action = "del";
                string sex = null;
                string status = null;
                string picture_url = null;
                string renamePath = Server.MapPath(txtAvatarHidd.Value);

                string result = _parti.EditTrainee(action, txtID.Value, txtNameLA.Value, txtNameEng.Value, dtpBD.Value, sex,
                    status, txtVillage.Value, txtDistrict.Value, txtProvince.Value,
                    txtWork_place.Value, txtDepartment.Value, txtPosition.Value, txtDate_of_govermented.Value,
                    txtOffice_tel.Value, txtMobile_tel.Value, txtEmail.Value, txtAvatarHidd.Value,
                    txtID.Value, txtReferDoc1Hidd.Value, txtReferDoc2Hidd.Value, txtReferDoc3Hidd.Value,
                    txtReferDoc4Hidd.Value, txtReferDoc5Hidd.Value);

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
                    if (txtAvatarHidd.Value != "")
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
                string status = null;
                string picture_url = null;
                string txtid = null;
                if (string.IsNullOrEmpty(txtAvatar.PostedFile.FileName) == false)
                {
                    var imgfile = Path.GetFileName(txtAvatar.PostedFile.FileName);
                    var imgfilePath = Server.MapPath("avatar/") + imgfile;
                    var extension = Path.GetExtension(imgfilePath);
                    var renamePath = Server.MapPath("avatar/") + txtID.Value + extension;
                    picture_url = "avatar/" + txtID.Value + extension;
                    txtAvatar.SaveAs(imgfilePath);
                    if (File.Exists(renamePath))
                    {
                        File.Delete(renamePath);
                    }
                    File.Move(imgfilePath, renamePath);
                }
                else
                {
                    picture_url = txtAvatarHidd.Value;
                }

                if (rdMale.Checked)
                {
                    sex = "m";
                }
                else if (rdFamale.Checked)
                {
                    sex = "f";
                }

                if (rdDivorce.Checked)
                {
                    status = "d";
                }
                else if (rdMarried.Checked)
                {
                    status = "m";
                }
                else if (rdSingle.Checked)
                {
                    status = "s";
                }

                SavedFileUpload(txtReferDoc1Hidd.Value, "1");
                SavedFileUpload(txtReferDoc2Hidd.Value, "2");
                SavedFileUpload(txtReferDoc3Hidd.Value, "3");
                SavedFileUpload(txtReferDoc4Hidd.Value, "4");
                SavedFileUpload(txtReferDoc5Hidd.Value, "5");

                txtid = txtID.Value;
                var result = parti.EditTrainee(action, txtid, txtNameLA.Value, txtNameEng.Value, dtpBD.Value, sex,
                    status, txtVillage.Value, txtDistrict.Value, txtProvince.Value,
                    txtWork_place.Value, txtDepartment.Value, txtPosition.Value, txtDate_of_govermented.Value,
                    txtOffice_tel.Value, txtMobile_tel.Value, txtEmail.Value, txtAvatarHidd.Value,
                    txtid, txtReferDoc1Hidd.Value, txtReferDoc2Hidd.Value, txtReferDoc3Hidd.Value,
                    txtReferDoc4Hidd.Value, txtReferDoc5Hidd.Value);

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
                    EditApproval();
                    EditEducation();
                    MessageBox.swalModal(this.Page, "success", "ຈັດການຂໍ້ມູນສຳເລັດ...", Request.RawUrl);
                }
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'", "") + "]", "");
            }
        }

        private void SavedFileUpload(string imgFile, string index)
        {
            string result = null;
            try
            {
                if (string.IsNullOrEmpty(imgFile) == false)
                {
                    var imgfile = Path.GetFileName(imgFile);
                    var imgfilePath = Server.MapPath("traineedocs/") + index + "_" + imgfile;
                    var extension = Path.GetExtension(imgfilePath);
                    var renamePath = Server.MapPath("traineedocs/") + index + "_" + txtID.Value + extension;

                    txtAvatar.SaveAs(imgfilePath);
                    if (File.Exists(renamePath))
                    {
                        File.Delete(renamePath);
                    }
                    File.Move(imgfilePath, renamePath);
                    result = "traineedocs/" + index + "_" + txtID.Value + extension;
                }
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'", "") + "]", "");
            }
        }

        private void EditApproval()
        {
            wcf.parti.Service1 parti = new wcf.parti.Service1();
            var action = btnState.Value.ToString();
            try
            {
                var result = parti.EditApproval(action, txtID.Value, txtAppr_Fullname.Value, txtAppr_Position_name.Value, txtAppr_Position_major.Value,
                    txtAppr_Relationship_trainee.Value, txtAppr_Office_name.Value, txtAppr_Office_tel.Value, txtAppr_Mobile_tel.Value, txtAppr_Email.Value);
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

        private void EditEducation()
        {
            wcf.parti.Service1 parti = new wcf.parti.Service1();
            var action = btnState.Value.ToString();
            string country = null;

            if (rdEduIn.Checked)
            {
                country = "in";
            }
            else if (rdEduOut.Checked)
            {
                country = "out";
            }

            try
            {
                var result = parti.EditEducation(action, txtID.Value, txtEducation_level.Value,
                    txtEducation_major.Value, country, txtEducated_year.Value, txtEducation_Name.Value);
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
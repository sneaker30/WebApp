using Newtonsoft.Json;
using parti.admin.lib;
using System;
using System.Collections.Generic;
using System.IO;
using System.Web.UI;

namespace parti.admin
{
    public partial class UserProfile : System.Web.UI.Page
    {
        public static List<GetUserProfile> getUserProfile = new List<GetUserProfile>();
        public static Page _Page = new Page();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    Binding();
                }
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'", "") + "]", "");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                wcf.parti.Service1 parti = new wcf.parti.Service1();
                var action = "edit";
                string sex = null;
                string picture_url = null;
                string txtid = null;
                string status = null;

                if (string.IsNullOrEmpty(imageUpload.PostedFile.FileName) == false)
                {
                    var imgfile = Path.GetFileName(imageUpload.PostedFile.FileName);
                    var imgfilePath = Server.MapPath("avatar/") + imgfile;
                    var extension = Path.GetExtension(imgfilePath);
                    var renamePath = Server.MapPath("avatar/") + txtUsername.Value + extension;
                    picture_url = "~/avatar/" + txtUsername.Value + extension;
                    imageUpload.SaveAs(imgfilePath);
                    if (File.Exists(renamePath))
                    {
                        File.Delete(renamePath);
                    }
                    File.Move(imgfilePath, renamePath);
                    txtAvatarHidd_I.Value = picture_url;
                }
                if (string.IsNullOrEmpty(txtReferDoc1.PostedFile.FileName) == false)
                {
                    var imgfile = Path.GetFileName(txtReferDoc1.PostedFile.FileName);
                    var imgfilePath = Server.MapPath("trainerdocs/") + "1_" + imgfile;
                    var extension = Path.GetExtension(imgfilePath);
                    var renamePath = Server.MapPath("trainerdocs/") + "1_" + txtUsername.Value + extension;
                    picture_url = "trainerdocs/" + "1_" + txtUsername.Value + extension;
                    txtReferDoc1.SaveAs(imgfilePath);
                    if (File.Exists(renamePath))
                    {
                        File.Delete(renamePath);
                    }
                    File.Move(imgfilePath, renamePath);
                    txtReferDoc1Hidd.InnerText = picture_url;
                    txtReferDoc1Hidd_I.Value = picture_url;
                }
                if (string.IsNullOrEmpty(txtReferDoc2.PostedFile.FileName) == false)
                {
                    var imgfile = Path.GetFileName(txtReferDoc2.PostedFile.FileName);
                    var imgfilePath = Server.MapPath("trainerdocs/") + "2_" + imgfile;
                    var extension = Path.GetExtension(imgfilePath);
                    var renamePath = Server.MapPath("trainerdocs/") + "2_" + txtUsername.Value + extension;
                    picture_url = "trainerdocs/" + "2_" + txtUsername.Value + extension;
                    txtReferDoc2.SaveAs(imgfilePath);
                    if (File.Exists(renamePath))
                    {
                        File.Delete(renamePath);
                    }
                    File.Move(imgfilePath, renamePath);
                    txtReferDoc2Hidd.InnerText = picture_url;
                    txtReferDoc2Hidd_I.Value = picture_url;
                }
                if (string.IsNullOrEmpty(txtReferDoc3.PostedFile.FileName) == false)
                {
                    var imgfile = Path.GetFileName(txtReferDoc3.PostedFile.FileName);
                    var imgfilePath = Server.MapPath("trainerdocs/") + "3_" + imgfile;
                    var extension = Path.GetExtension(imgfilePath);
                    var renamePath = Server.MapPath("trainerdocs/") + "3_" + txtUsername.Value + extension;
                    picture_url = "trainerdocs/" + "3_" + txtUsername.Value + extension;
                    txtReferDoc3.SaveAs(imgfilePath);
                    if (File.Exists(renamePath))
                    {
                        File.Delete(renamePath);
                    }
                    File.Move(imgfilePath, renamePath);
                    txtReferDoc3Hidd.InnerText = picture_url;
                    txtReferDoc3Hidd_I.Value = picture_url;
                }
                if (string.IsNullOrEmpty(txtReferDoc4.PostedFile.FileName) == false)
                {
                    var imgfile = Path.GetFileName(txtReferDoc4.PostedFile.FileName);
                    var imgfilePath = Server.MapPath("trainerdocs/") + "4_" + imgfile;
                    var extension = Path.GetExtension(imgfilePath);
                    var renamePath = Server.MapPath("trainerdocs/") + "4_" + txtUsername.Value + extension;
                    picture_url = "trainerdocs/" + "4_" + txtUsername.Value + extension;
                    txtReferDoc4.SaveAs(imgfilePath);
                    if (File.Exists(renamePath))
                    {
                        File.Delete(renamePath);
                    }
                    File.Move(imgfilePath, renamePath);
                    txtReferDoc4Hidd.InnerText = picture_url;
                    txtReferDoc4Hidd_I.Value = picture_url;
                }
                if (string.IsNullOrEmpty(txtReferDoc5.PostedFile.FileName) == false)
                {
                    var imgfile = Path.GetFileName(txtReferDoc5.PostedFile.FileName);
                    var imgfilePath = Server.MapPath("trainerdocs/") + "5_" + imgfile;
                    var extension = Path.GetExtension(imgfilePath);
                    var renamePath = Server.MapPath("trainerdocs/") + "5_" + txtUsername.Value + extension;
                    picture_url = "trainerdocs/" + "5_" + txtUsername.Value + extension;
                    txtReferDoc5.SaveAs(imgfilePath);
                    if (File.Exists(renamePath))
                    {
                        File.Delete(renamePath);
                    }
                    File.Move(imgfilePath, renamePath);
                    txtReferDoc5Hidd.InnerText = picture_url;
                    txtReferDoc5Hidd_I.Value = picture_url;
                }

                if (rdMale.Checked)
                {
                    sex = "m";
                }
                else if (rdFamale.Checked)
                {
                    sex = "f";
                }

                if (action == "add")
                {
                    txtid = txtID.Value;
                }
                else if (action == "edit")
                {
                    txtid = txtIDHidden.Value;
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

                txtid = txtIDHidden.Value;
                var result = parti.EditTrainer(action, txtid, txtNameLa.Value, txtNameEng.Value, dtpBD.Value, sex, status, txtVillage.Value,
                    txtDistrict.Value, txtProvince.Value, txtWork_place.Value, txtDepartment.Value, txtPosition.Value, txtDate_of_govermented.Value,
                    txtOffice_tel.Value, txtMobile_tel.Value, txtEmail.Value, txtAvatarHidd_I.Value, txtReferDoc1Hidd_I.Value, txtReferDoc2Hidd_I.Value,
                    txtReferDoc3Hidd_I.Value, txtReferDoc4Hidd_I.Value, txtReferDoc5Hidd_I.Value, txtUsername.Value);

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
                    EditEducation(action);
                    MessageBox.swalModal(this.Page, "success", "ຈັດການຂໍ້ມູນສຳເລັດ...", Request.RawUrl);
                }
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'", "") + "]", "");
            }
        }

        public class GetUserProfile
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
            public string workplace { get; set; }
            public string department { get; set; }
            public string position { get; set; }
            public DateTime date_of_govermented { get; set; }
            public string office_tel { get; set; }
            public string mobile_tel { get; set; }
            public string email { get; set; }
            public string avatar_url { get; set; }
            public string doc1_url { get; set; }
            public string doc2_url { get; set; }
            public string doc3_url { get; set; }
            public string doc4_url { get; set; }
            public string doc5_url { get; set; }
            public string username { get; set; }
            public string education_level { get; set; }
            public string education_major { get; set; }
            public string education_country { get; set; }
            public string education_year { get; set; }
            public string education_name { get; set; }

            public GetUserProfile(string id, string fullname_la, string fullname_eng, DateTime date_of_birth, string sex, string status, string village,
                string district, string province, string workplace, string department, string position, DateTime date_of_govermented, string office_tel, string mobile_tel,
                string email, string avatar_url, string doc1_url, string doc2_url, string doc3_url, string doc4_url, string doc5_url, string userame,
                string education_level, string education_major, string education_country, string education_year, string education_name)
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
                this.workplace = workplace;
                this.department = department;
                this.position = position;
                this.date_of_govermented = date_of_govermented;
                this.office_tel = office_tel;
                this.mobile_tel = mobile_tel;
                this.email = email;
                this.avatar_url = avatar_url;
                this.doc1_url = doc1_url;
                this.doc2_url = doc2_url;
                this.doc3_url = doc3_url;
                this.doc4_url = doc4_url;
                this.doc5_url = doc5_url;
                this.username = userame;
                this.education_level = education_level;
                this.education_major = education_major;
                this.education_country = education_country;
                this.education_year = education_year;
                this.education_name = education_name;
            }
        }

        public static List<GetUserProfile> GetUserProfileInfo(string id)
        {
            getUserProfile.Clear();
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            partiDB.RootObject rootObject = new partiDB.RootObject();

            string json_str = _parti.GetTrainerList(id);
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
                foreach (var vl in rootObject.GetTrainerList)
                {
                    getUserProfile.Add(new GetUserProfile(vl.id, vl.fullname_la, vl.fullname_eng, vl.date_of_birth, vl.sex, vl.status, vl.village, vl.district,
                        vl.province, vl.work_place, vl.department, vl.position, vl.date_of_govermented, vl.office_tel, vl.mobile_tel, vl.email,
                        vl.avatar_url, vl.doc1_url, vl.doc2_url, vl.doc3_url, vl.doc4_url, vl.doc5_url, vl.username, vl.education_level, vl.education_major,
                        vl.education_country, vl.educated_year, vl.education_name));
                }
            }
            return getUserProfile;
        }

        private void Binding()
        {
            string id = Session["id"].ToString();
            GetUserProfile _userProfile;
            GetUserProfileInfo(id);
            _userProfile = getUserProfile[0];

            uid.Value = _userProfile.id;
            txtID.Value = _userProfile.id;
            txtIDHidden.Value = _userProfile.id;
            txtID.Attributes.Add("disabled", "disabled");
            txtNameLa.Value = _userProfile.fullname_la;
            txtNameEng.Value = _userProfile.fullname_eng;
            dtpBD.Value = _userProfile.date_of_birth.ToString("yyyy-MM-dd");
            txtWork_place.Value = _userProfile.workplace;
            txtPosition.Value = _userProfile.position;
            lblPicUrlPath.InnerText = _userProfile.avatar_url;
            avartaUrl.Value = _userProfile.avatar_url;
            txtAvatarHidd_I.Value = _userProfile.avatar_url;
            txtUsername.Value = _userProfile.username;
            profileImage.Src = _userProfile.avatar_url.Replace("~", "");
            if (_userProfile.sex == "m")
            {
                rdMale.Attributes.Add("checked", "checked");
            }
            else if (_userProfile.sex == "f")
            {
                rdFamale.Attributes.Add("checked", "checked");
            }

            if (_userProfile.status == "s")
            {
                rdSingle.Attributes.Add("checked", "checked");
            }
            else if (_userProfile.status == "m")
            {
                rdMarried.Attributes.Add("checked", "checked");
            }
            else if (_userProfile.status == "d")
            {
                rdDivorce.Attributes.Add("checked", "checked");
            }

            txtVillage.Value = _userProfile.village;
            txtDistrict.Value = _userProfile.district;
            txtProvince.Value = _userProfile.province;
            txtDepartment.Value = _userProfile.department;
            txtDate_of_govermented.Value = _userProfile.date_of_govermented.ToString("yyyy-MM-dd");
            txtOffice_tel.Value = _userProfile.office_tel;
            txtMobile_tel.Value = _userProfile.mobile_tel;
            txtEmail.Value = _userProfile.email;
            txtReferDoc1Hidd_I.Value = _userProfile.doc1_url;
            txtReferDoc1Hidd.InnerText = _userProfile.doc1_url;
            txtReferDoc2Hidd_I.Value = _userProfile.doc2_url;
            txtReferDoc2Hidd.InnerText = _userProfile.doc2_url;
            txtReferDoc3Hidd_I.Value = _userProfile.doc3_url;
            txtReferDoc3Hidd.InnerText = _userProfile.doc3_url;
            txtReferDoc4Hidd_I.Value = _userProfile.doc4_url;
            txtReferDoc4Hidd.InnerText = _userProfile.doc4_url;
            txtReferDoc5Hidd_I.Value = _userProfile.doc5_url;
            txtReferDoc5Hidd.InnerText = _userProfile.doc5_url;
            txtEducation_level.Value = _userProfile.education_level;
            txtEducation_major.Value = _userProfile.education_major;
            txtEducated_year.Value = _userProfile.education_year;
            txtEducation_Name.Value = _userProfile.education_name;
            if (_userProfile.education_country == "in")
            {
                rdEduIn.Attributes.Add("checked", "checked");
            }
            else if (_userProfile.education_country == "out")
            {
                rdEduOut.Attributes.Add("checked", "checked");
            }
            txtUsername.Value = _userProfile.username;
        }

        private void EditEducation(string action)
        {
            wcf.parti.Service1 parti = new wcf.parti.Service1();
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
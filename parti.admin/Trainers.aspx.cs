using System;
using System.Collections.Generic;
using System.IO;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using Newtonsoft.Json;
using parti.admin.lib;

namespace parti.admin
{
    public partial class Trainers : System.Web.UI.Page
    {
        public static List<GetTrainerList> TrainerLists = new List<GetTrainerList>();
        public static GetSetEnCoding enCoding = new GetSetEnCoding();
        public static Page _Page = new Page();
        public static List<GetExperience> listGetExperiance = new List<GetExperience>();
        public static List<GetTrainingExperience_Trainer> listTrainingExperiences_Trainer = new List<GetTrainingExperience_Trainer>();

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                GetTrainerLists();
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'", "") + "]", "");
            }
        }

        private List<GetTrainerList> GetTrainerLists()
        {
            TrainerLists.Clear();
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            partiDB.RootObject rootObject = new partiDB.RootObject();

            string json_str = _parti.GetTrainerList("");
            if (json_str == "e0") //code error
            {
                MessageBox.swalModal(_Page, "error", "e0:ລະບົບຂັດຂ້ອງຕິດຕໍ່ຜູ້ເບີ່ງແຍ່ງດ່ວນ.", "");
            }
            else if (json_str == "e1") //no data found
            {
                MessageBox.swalModal(_Page, "info", "e1:ບໍ່ມີຂໍ້ມູນທີ່ຈະສະແດງ.", "");
            }
            else if (json_str == "e2") //can't connect databbase
            {
                MessageBox.swalModal(_Page, "warning", "e2:ບໍ່ສາມາດເຊື່ອມຕໍ່ຖານຂໍ້ມູນໄດ້.", "");
            }
            else
            {
                int i = 0;
                rootObject = JsonConvert.DeserializeObject<partiDB.RootObject>(json_str);
                foreach (var vl in rootObject.GetTrainerList)
                {
                    TrainerLists.Add(new GetTrainerList(vl.id, vl.fullname_la, vl.fullname_eng, vl.date_of_birth, vl.sex, vl.status, vl.village, vl.district,
                        vl.province, vl.work_place, vl.department, vl.position, vl.date_of_govermented, vl.office_tel, vl.mobile_tel, vl.email,
                        vl.avatar_url, vl.doc1_url, vl.doc2_url, vl.doc3_url, vl.doc4_url, vl.doc5_url, vl.username, vl.education_level, vl.education_major,
                        vl.education_country, vl.educated_year, vl.education_name));
                    //Render Carousel
                    HtmlElement carouselItem = new HtmlElement();
                    carouselItem.InnerHtml = "<div class='card card-profiler laotxt hvr-grow-shadow' data-cindex='" + i + "'>" +
                        "<div class='card-image'>" +
                        "<a href='#'><img class='img' src='" + vl.avatar_url.Replace("~", "") + "'></a>" +
                        "</div>" +
                        "<div class='table center'>" +
                        "<p>" + vl.fullname_la + "</p>" +
                        "<h6>" + vl.position + "</h6>" +
                        "<button id='btn" + i + "' value='" + i + "' onclick='SetTrainerInfo(this.value); return false;' type='button' " +
                        "class='btn-floating btn-small waves-effect waves-light red darken-3 tooltipped modal-trigger' href='#modalTrainer' data-position='top' " +
                        "data-tooltip='ຂໍ້ມູນເພີ່ມຕື່ມ'><i class='material-icons'>keyboard_arrow_down</i></button>" +
                        "</div></div>";
                    crsTrainerList.Controls.AddAt(i, carouselItem);
                    i++;
                }
                lblTotalTrainer.InnerText = i.ToString();
            }
            return TrainerLists;
        }

        public class GetExperience
        {
            public string id { get; set; }
            public string experience_id { get; set; }
            public string responsibility { get; set; }
            public string office { get; set; }
            public string years { get; set; }

            public GetExperience(string id, string experience_id, string responsibility, string office, string years)
            {
                this.id = id;
                this.experience_id = experience_id;
                this.responsibility = responsibility;
                this.office = office;
                this.years = years;
            }
        }

        public class GetTrainerList
        {
            public string id { get; set; }
            public string fullname_la { get; set; }
            public string fullname_eng { get; set; }
            public string date_of_birth { get; set; }
            public string sex { get; set; }
            public string status { get; set; }
            public string village { get; set; }
            public string district { get; set; }
            public string province { get; set; }
            public string work_place { get; set; }
            public string department { get; set; }
            public string position { get; set; }
            public string date_of_govermented { get; set; }
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
            public string educated_year { get; set; }
            public string education_name { get; set; }

            public GetTrainerList(string id, string fullname_la, string fullname_eng, DateTime date_of_birth, string sex, string status, string village,
                string district, string province, string work_place, string department, string position, DateTime date_of_govermented, string office_tel, string mobile_tel,
                string email, string avatar_url, string doc1_url, string doc2_url, string doc3_url, string doc4_url, string doc5_url, string userame,
                string education_level, string education_major, string education_country, string educated_year, string education_name)
            {
                this.id = id;
                this.fullname_la = fullname_la;
                this.fullname_eng = fullname_eng;
                this.date_of_birth = date_of_birth.ToString("yyyy-MM-dd");
                this.sex = sex;
                this.status = status;
                this.village = village;
                this.district = district;
                this.province = province;
                this.work_place = work_place;
                this.department = department;
                this.position = position;
                this.date_of_govermented = date_of_govermented.ToString("yyyy-MM-dd");
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
                this.educated_year = educated_year;
                this.education_name = education_name;
            }
        }

        [WebMethod]
        public static GetTrainerList GetTrainerInfo(int TrainerID)
        {
            GetTrainerList getTrainer;
            getTrainer = TrainerLists[TrainerID];

            return getTrainer;
        }

        [WebMethod]
        public static List<GetExperience> GetExperianceInfo(string exper_id)
        {
            listGetExperiance.Clear();
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            partiDB.RootObject rootObject = new partiDB.RootObject();
            if (listGetExperiance.Count == 0)
            {
                string json_str = _parti.GetExperience(exper_id);
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
                    foreach (var vl in rootObject.GetExperience)
                    {
                        listGetExperiance.Add(new GetExperience(vl.id, vl.experience_id, vl.responsibility, vl.office, vl.years));
                    }
                }
            }
            return listGetExperiance;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                wcf.parti.Service1 parti = new wcf.parti.Service1();
                var action = btnState.Value.ToString();
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

        protected void btnDel_Click(object sender, EventArgs e)
        {
            try
            {
                wcf.parti.Service1 _parti = new wcf.parti.Service1();
                string action = "del";
                string sex = null;
                string status = null;
                string renamePath = Server.MapPath(txtAvatarHidd_I.Value);

                string result = _parti.EditTrainer(action, txtIDHidden.Value, txtNameLa.Value, txtNameEng.Value, dtpBD.Value, sex, status, txtVillage.Value,
                    txtDistrict.Value, txtProvince.Value, txtWork_place.Value, txtDepartment.Value, txtPosition.Value, txtDate_of_govermented.Value,
                    txtOffice_tel.Value, txtMobile_tel.Value, txtEmail.Value, lblPicUrlPath.InnerText, txtReferDoc1Hidd_I.Value, txtReferDoc2Hidd_I.Value,
                    txtReferDoc3Hidd_I.Value, txtReferDoc4Hidd_I.Value, txtReferDoc5Hidd_I.Value, txtUsername.Value);
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
                    if (avartaUrl.Value != "~/img/avatar.png")
                    {
                        File.Delete(renamePath);
                    }
                    EditEducation(action);
                    string currentPage = Request.RawUrl;
                    MessageBox.swalModal(this.Page, "success", "ຈັດການຂໍ້ມູນສຳເລັດ...", currentPage);
                }
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'", "") + "]", "");
            }
        }

        [WebMethod]
        public static string EditExperiance(string action, string id, string experience_id, string responsibility, string office, string years)
        {
            string result = null;
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            if ((experience_id != "" && responsibility != "" && office != "" && years != "") || (action == "del"))
            {
                string json_str = _parti.EditExperience(action, id, experience_id, responsibility, office, years);
                if (json_str == "e0")//code error
                {
                    result = "e0:ລະບົບຂັດຂ້ອງຕິດຕໍ່ຜູ້ເບີ່ງແຍ່ງດ່ວນ.";
                }
                else if (json_str == "e1")//no data found
                {
                    result = "e1:ບໍ່ມີຂໍ້ມູນທີ່ຈະສະແດງ.";
                }
                else if (json_str == "e2")//can't connect databbase
                {
                    result = "e2:ບໍ່ສາມາດເຊື່ອມຕໍ່ຖານຂໍ້ມູນໄດ້.";
                }
                else if (json_str == "e5")
                {
                    result = "e5";
                }
                else if (json_str == "e3")
                {
                    result = "e3";
                }
            }
            return result;
        }

        public class GetTrainingExperience_Trainer
        {
            public string training_id { get; set; }
            public string title { get; set; }
            public string int_or_ext { get; set; }
            public string address { get; set; }
            public string training_date { get; set; }
            public string trainer_id { get; set; }

            public GetTrainingExperience_Trainer(string trainingId, string title, string intOrExt, string address, DateTime trainingDate, string trainerId)
            {
                training_id = trainingId;
                this.title = title;
                int_or_ext = intOrExt;
                this.address = address;
                training_date = trainingDate.ToString("yyyy-MM-dd");
                trainer_id = trainerId;
            }
        }

        [WebMethod]
        public static List<GetTrainingExperience_Trainer> GetTrainingExperiences_Trainer(string id)
        {
            listTrainingExperiences_Trainer.Clear();
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            partiDB.RootObject rootObject = new partiDB.RootObject();
            if (listTrainingExperiences_Trainer.Count == 0)
            {
                string json_str = _parti.GetTrainingExperience_Trainer(id);
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
                    foreach (var vl in rootObject.GetTrainingExperience_Trainer)
                    {
                        listTrainingExperiences_Trainer.Add(new GetTrainingExperience_Trainer(vl.training_id,
                            vl.title, vl.int_or_ext, vl.address, vl.training_date, vl.trainer_id));
                    }
                }
            }
            return listTrainingExperiences_Trainer;
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
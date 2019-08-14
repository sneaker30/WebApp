using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using parti.admin.lib;
using static parti.admin.Course;

namespace parti.admin
{
    public partial class Training : System.Web.UI.Page
    {
        public static List<GetTrainingList> TrainingLists = new List<GetTrainingList>();
        public static Page _Page = new Page();
        public static List<Trainee.GetTraineeList> TraineeLists = new List<Trainee.GetTraineeList>();
        public static List<Trainers.GetTrainerList> TrainerLists = new List<Trainers.GetTrainerList>();
        public static List<GetTraineeByTraining> TraineeByTrainings = new List<GetTraineeByTraining>();
        public static List<GetTrainerByTraining> TrainerByTrainings = new List<GetTrainerByTraining>();
        public static List<Course.GetCourse> gridData = new List<Course.GetCourse>();
        public static List<GetDistrict> listDistrict = new List<GetDistrict>();
        public static List<GetProvince> listProvince = new List<GetProvince>();

        public class GetTrainingList
        {
            public string id { get; set; }
            public string title { get; set; }
            public int course_id { get; set; }
            public string course_name { get; set; }
            public string int_or_ext { get; set; }
            public string training_address { get; set; }
            public string training_district { get; set; }
            public string training_province { get; set; }
            public int training_days { get; set; }
            public string training_date { get; set; }
            public string description { get; set; }
            public DateTime date_of_modified_date { get; set; }

            public GetTrainingList(string id, string title, int courseId, string courseName, string intOrExt, string trainingAddress,
                string trainingDistrict, string trainingProvince, int trainingDays,
                DateTime trainingDate, string description,
                DateTime dateOfModifiedDate)
            {
                this.id = id;
                this.title = title;
                course_id = courseId;
                course_name = courseName;
                int_or_ext = intOrExt;
                training_address = trainingAddress;
                training_district = trainingDistrict;
                training_province = trainingProvince;
                training_days = trainingDays;
                training_date = trainingDate.ToString("MM/dd/yyyy");
                this.description = description;
                date_of_modified_date = dateOfModifiedDate;
            }
        }

        public class GetTraineeByTraining
        {
            public string training_id { get; set; }
            public string trainee_id { get; set; }
            public string fullname { get; set; }
            public string work_place { get; set; }

            public GetTraineeByTraining(string training_id, string traineeId, string fullname, string workPlace)
            {
                this.training_id = training_id;
                this.trainee_id = traineeId;
                this.fullname = fullname;
                this.work_place = workPlace;
            }
        }

        public class GetTrainerByTraining
        {
            public string training_id { get; set; }
            public string trainer_id { get; set; }
            public string fullname { get; set; }
            public string work_place { get; set; }

            public GetTrainerByTraining(string training_id, string trainerId, string fullname, string workPlace)
            {
                this.training_id = training_id;
                this.trainer_id = trainerId;
                this.fullname = fullname;
                this.work_place = workPlace;
            }
        }

        public class GetDistrict
        {
            public string d_id { get; set; }
            public string d_name { get; set; }
            public string p_id { get; set; }

            public GetDistrict(string id, string name, string p_id)
            {
                d_id = id;
                d_name = name;
                this.p_id = p_id;
            }
        }

        public class GetProvince
        {
            public string p_id { get; set; }
            public string p_name { get; set; }

            public GetProvince(string id, string name)
            {
                p_id = id;
                p_name = name;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                GetTrainingLists();
                GetTrainerLists();
                GetTraineeLists();
                RenderSelectCourse();
            }
            catch (Exception ex)
            {
                MessageBox.swalModal(this.Page, "error", "en:internal error[" + ex.Message.Replace("'", "") + "]", "");
            }
        }

        public List<GetTrainingList> GetTrainingLists()
        {
            TrainingLists.Clear();
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            partiDB.RootObject rootObject = new partiDB.RootObject();

            string json_str = _parti.GetTrainingList("");
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
                Parallel.ForEach(rootObject.GetTrainingList, vl =>
                {

                });
                foreach (var vl in rootObject.GetTrainingList)
                {
                    TrainingLists.Add(new GetTrainingList(vl.id, vl.title, vl.course_id, vl.course_name, vl.int_or_ext,
                        vl.training_address, vl.training_district, vl.training_province, vl.training_days, vl.training_date, 
                        vl.description, vl.date_of_modified_date));
                    //Render Card Training Main
                    var MMMM = vl.training_date.ToString("MMMM");
                    var ddyyyy = vl.training_date.ToString(" dd, yyyy");
                    var TningDate = "";
                    switch (MMMM)
                    {
                        case "January":
                            TningDate = "ມັງກອນ" + ddyyyy;
                            break;
                        case "February":
                            TningDate = "ກຸມພາ" + ddyyyy;
                            break;
                        case "March":
                            TningDate = "ມີນາ" + ddyyyy;
                            break;
                        case "April":
                            TningDate = "ເມສາ" + ddyyyy;
                            break;
                        case "May":
                            TningDate = "ພຶດສະພາ" + ddyyyy;
                            break;
                        case "June":
                            TningDate = "ມິຖຸນາ" + ddyyyy;
                            break;
                        case "July":
                            TningDate = "ກໍລະກົດ" + ddyyyy;
                            break;
                        case "August":
                            TningDate = "ສິງຫາ" + ddyyyy;
                            break;
                        case "September":
                            TningDate = "ກັນຍາ" + ddyyyy;
                            break;
                        case "October":
                            TningDate = "ຕຸລາ" + ddyyyy;
                            break;
                        case "November":
                            TningDate = "ພະຈິກ" + ddyyyy;
                            break;
                        case "December":
                            TningDate = "ທັນວາ" + ddyyyy;
                            break;
                    }

                    HtmlElement _tbody = new HtmlElement();
                    _tbody.InnerHtml = "<div class='card hvr-grow-shadow' id='" + vl.id + "'>" +
                                       "<div class='card-image'>" +
                                       "<img src = 'img/" + vl.course_id + ".jpg' class='img'>" +
                                       "<a class='btn-floating halfway-fab waves-effect waves-light red accent-1 " +
                                       "tooltipped' data-position='right' data-tooltip='ລາຍລະອຽດ' id='" + (i - 1) + "' name='" + vl.id + "' onclick='SetTrainingInfo(this.id, this.name)'>" +
                                       "<i class='small material-icons'>more_vert</i></a>" +
                                       "</div>" +
                                       "<div class='card-content grey lighten-3'>" +
                                       "<b class='card-title black-text'>" + TningDate + "</b>" +
                                       "<p>" + vl.title + "</p>" +
                                       "<p>" + vl.training_address + "</p>" +
                                       "<a class='tooltipped' " +
                                       "data-position='right' data-tooltip='ລົບ' name='" + vl.id + "' id='" + vl.training_date.ToString("yyyy-MM-dd") + "' " +
                                       "onclick='DelTraining(this.name, this.id)'><i class='material-icons'>delete</i></a>" +
                                       "</div>" +
                                       "</div>";
                    cardTraining.Controls.Add(_tbody);
                    i++;
                }//);
            }
            return TrainingLists;
        }

        public List<Trainers.GetTrainerList> GetTrainerLists()
        {
            TrainerLists.Clear();
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            partiDB.RootObject rootObject = new partiDB.RootObject();

            string json_str = _parti.GetTrainerList("");
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
                Parallel.ForEach(rootObject.GetTrainerList, vl =>
                {

                });
                foreach (var vl in rootObject.GetTrainerList)
                {
                    TrainerLists.Add(new Trainers.GetTrainerList(vl.id, vl.fullname_la, vl.fullname_eng, vl.date_of_birth, vl.sex, vl.status, vl.village, vl.district,
                        vl.province, vl.workplace, vl.department, vl.position, vl.date_of_govermented, vl.office_tel, vl.mobile_tel, vl.email,
                        vl.avatar_url, vl.doc1_url, vl.doc2_url, vl.doc3_url, vl.doc4_url, vl.doc5_url, vl.username, vl.education_level, vl.education_major,
                        vl.education_country,vl.education_year, vl.education_name));
                    //Render Table Trainer Choice
                    HtmlElement _tbody = new HtmlElement();
                    HtmlElement _tbody2 = new HtmlElement();

                    _tbody.InnerHtml = "<tr id='1Tner" + i + "' class='trTrainer'>" +
                                       "<td>" + vl.fullname_la + ", " + vl.workplace + ".</td>" +
                                       "<td><div class='row'><div class='col'>" +
                                       "<button type='button' class='btn-floating btn-small z-depth-3 blue tooltipped " +
                                       "hvr-grow-shadow' " +
                                       "href='#!' data-position='left' data-tooltip='ເລືອກເອົາ' id='1Tner" + i + "' name='2Tner" + i + "' " +
                                       "onclick='Select(this.id, this.name)'><i class='material-icons'>send</i></button>" +
                                       "</div>&nbsp;<div class='col'></div></div></td>" +
                                       "<input type='hidden' value='" + vl.id + "' id='i1Tner" + i + "'/></tr>";

                    _tbody2.InnerHtml = "<tr id='2Tner" + i + "' hidden>" +
                                       "<td>" + vl.fullname_la + ", " + vl.workplace + ".</td>" +
                                       "<td><div class='row'><div class='col'>" +
                                       "<button type='button' class='btn-floating btn-small z-depth-3 red darken-3 tooltipped " +
                                       "hvr-grow-shadow' " +
                                       "href='#!' data-position='right' data-tooltip='ລົບອອກ' id='2Tner" + i + "' name='1Tner" + i + "' " +
                                       "onclick='Disselect(this.id, this.name)'><i class='material-icons'>delete_forever</i></button>" +
                                       "</div>&nbsp;<div class='col'></div></div></td>" +
                                       "<input type='hidden' id='i2Tner" + i + "' value='" + vl.id + "' /></tr>";
                    tbTnerBody1.Controls.Add(_tbody);
                    tbTnerBody2.Controls.Add(_tbody2);
                    i++;
                }//);
            }
            return TrainerLists;
        }

        public List<Trainee.GetTraineeList> GetTraineeLists()
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
                //Parallel.ForEach(rootObject.GetTraineeList, vl =>
                //{
                foreach (var vl in rootObject.GetTraineeList)
                {
                    TraineeLists.Add(new Trainee.GetTraineeList(vl.id, vl.fullname_la, vl.fullname_eng, vl.date_of_birth, vl.sex, vl.status, vl.village, vl.district,
                        vl.province, vl.work_place, vl.department, vl.position, vl.date_of_govermented, vl.office_tel, vl.mobile_tel, vl.email, vl.avatar_url,
                        vl.approval_id, vl.doc1_url, vl.doc2_url, vl.doc3_url, vl.doc4_url, vl.doc5_url, vl.appr_id, vl.appr_fullname, vl.appr_position_name, vl.appr_position_major,
                        vl.appr_relationship_trainee, vl.appr_office_name, vl.appr_office_tel, vl.appr_mobile_tel, vl.appr_email, vl.education_level, vl.education_major,
                        vl.education_country, vl.educated_year, vl.education_name));
                    //Render Table Trainer Choice
                    HtmlElement _tbody = new HtmlElement();
                    HtmlElement _tbody2 = new HtmlElement();

                    _tbody.InnerHtml = "<tr id='1Tnee" + i + "' class='trTrainee'>" +
                                       "<td>" + vl.fullname_la + ", " + vl.work_place + ".</td>" +
                                       "<td><div class='row'><div class='col'>" +
                                       "<button type='button' class='btn-floating btn-small z-depth-3 blue tooltipped " +
                                       "hvr-grow-shadow' " +
                                       "href='#!' data-position='left' data-tooltip='ເລືອກເອົາ' id='1Tnee" + i + "' name='2Tnee" + i + "'" +
                                       "onclick='Select(this.id, this.name)'><i class='material-icons'>send</i></button>" +
                                       "</div>&nbsp;<div class='col'></div></div></td>" +
                                       "<input type='hidden' value='" + vl.id + "' id='i1Tnee" + i + "'/></tr>";

                    _tbody2.InnerHtml = "<tr id='2Tnee" + i + "' hidden>" +
                                       "<td>" + vl.fullname_la + ", " + vl.work_place + ".</td>" +
                                       "<td><div class='row'><div class='col'>" +
                                       "<button type='button' class='btn-floating btn-small z-depth-3 red darken-3 tooltipped " +
                                       "hvr-grow-shadow' " +
                                       "href='#!' data-position='right' data-tooltip='ລົບອອກ' id='2Tnee" + i + "' name='1Tnee" + i + "'" +
                                       "onclick='Disselect(this.id, this.name)'><i class='material-icons'>delete_forever</i></button>" +
                                       "</div>&nbsp;<div class='col'></div></div></td>" +
                                       "<input type='hidden' id='i2Tnee" + i + "' value='" + vl.id + "' /></tr>";
                    tbTneeBody1.Controls.Add(_tbody);
                    tbTneeBody2.Controls.Add(_tbody2);
                    i++;
                }//);
            }
            return TraineeLists;
        }

        [WebMethod]
        public static GetTrainingList GetTrainingInfo(int TrainingID)
        {
            GetTrainingList getTraiing;
            getTraiing = TrainingLists[TrainingID];

            return getTraiing;
        }

        [WebMethod]
        public static List<GetTraineeByTraining> GetTraineeByTrainings(string id)
        {
            TraineeByTrainings.Clear();
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            partiDB.RootObject rootObject = new partiDB.RootObject();

            string json_str = _parti.GetTraineeByTraining(id);
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
                foreach (var vl in rootObject.GetTraineeByTraining)
                {
                    TraineeByTrainings.Add(new GetTraineeByTraining(vl.training_id, vl.trainee_id, vl.fullname, vl.work_place));
                    i++;
                }
            }
            return TraineeByTrainings;
        }

        [WebMethod]
        public static List<GetTrainerByTraining> GetTrainerByTrainings(string id)
        {
            TrainerByTrainings.Clear();
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            partiDB.RootObject rootObject = new partiDB.RootObject();

            string json_str = _parti.GetTrainerByTraining(id);
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
                foreach (var vl in rootObject.GetTrainerByTraining)
                {
                    TrainerByTrainings.Add(new GetTrainerByTraining(vl.training_id, vl.trainer_id, vl.fullname, vl.work_place));
                    i++;
                }
            }
            return TrainerByTrainings;
        }

        [WebMethod]
        public static string SetTraining(string action, string id, string title, string course_id, string int_or_ext, string training_address, string training_district, string training_province,
            string training_days, string training_date, string description, string date_of_modified_data)
        {
            string result = null;
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            string json_str = _parti.EditTrainings(action, id, title, course_id, int_or_ext, training_address, training_district, training_province, 
                training_days, training_date, description, date_of_modified_data);
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
                result = "e5:ຈັດການຂໍ້ມູນສຳເລັດ.";
            }

            return result;
        }

        [WebMethod]
        public static string SetTrainerForTraining(string action, string id, string trainer_id, string training_id)
        {
            string result = null;
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            string json_str = _parti.EditTrainerForTrainings(action, id, trainer_id, training_id);
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
                result = "e5:ຈັດການຂໍ້ມູນສຳເລັດ.";
            }

            return result;
        }

        [WebMethod]
        public static string SetTraineeForTraining(string action, string id, string trainee_id, string training_id)
        {
            string result = null;
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            string json_str = _parti.EditTraineeForTrainings(action, id, trainee_id, training_id);
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
                result = "e5:ຈັດການຂໍ້ມູນສຳເລັດ.";
            }

            return result;
        }

        private void RenderSelectCourse()
        {
            gridData = GetgridData();
            foreach (var vl in gridData)
            {
                selCourseID.Items.Add(new ListItem(vl.name, vl.id.ToString()));
            }
        }

        [WebMethod]
        public static List<GetDistrict> GetDistricts()
        {
            listDistrict.Clear();
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            partiDB.RootObject rootObject = new partiDB.RootObject();
            if (listDistrict.Count == 0)
            {
                string json_str = _parti.GetDistrict();
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
                    foreach (var vl in rootObject.GetDistrict)
                    {
                        listDistrict.Add(new GetDistrict(vl.d_id, vl.d_name, vl.p_id));
                    }
                }
            }
            return listDistrict;
        }

        [WebMethod]
        public static List<GetProvince> GetProvinces()
        {
            listProvince.Clear();
            wcf.parti.Service1 _parti = new wcf.parti.Service1();
            partiDB.RootObject rootObject = new partiDB.RootObject();
            if (listProvince.Count == 0)
            {
                string json_str = _parti.GetProvince();
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
                    foreach (var vl in rootObject.GetProvince)
                    {
                        listProvince.Add(new GetProvince(vl.p_id, vl.p_name));
                    }
                }
            }
            return listProvince;
        }

    }
}
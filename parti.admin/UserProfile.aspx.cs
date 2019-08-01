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
                wcf.parti.Service1 _parti = new wcf.parti.Service1();
                string action = "edit";
                string sex = null;
                string picture_url = null;
                if (String.IsNullOrEmpty(imageUpload.PostedFile.FileName) == false)
                {
                    string imgfile = Path.GetFileName(imageUpload.PostedFile.FileName);
                    string imgfilePath = Server.MapPath("avatar/") + imgfile;
                    string extension = Path.GetExtension(imgfilePath);
                    string renamePath = Server.MapPath("avatar/") + txtUsername.Value + extension;
                    picture_url = "~/avatar/" + txtUsername.Value + extension;
                    imageUpload.SaveAs(imgfilePath);
                    if (File.Exists(renamePath))
                    {
                        File.Delete(renamePath);
                    }
                    File.Move(imgfilePath, renamePath);
                }
                else
                {
                    if (action == "add")
                    {
                        picture_url = "~/img/avatar.png";
                    }
                    else
                    {
                        picture_url = avartaUrl.Value;
                    }
                }

                if (rdMale.Checked)
                {
                    sex = "m";
                }
                else if (rdFamale.Checked)
                {
                    sex = "f";
                }

                string result = _parti.EditTrainer(action, txtID.Value, txtName.Value, txtfaminame.Value, dtpBD.Value, sex, txtworkPlace.Value,
                    txtPosition.Value, picture_url, txtUsername.Value, txtlv1.Value, txtlv2.Value, txtlv3.Value, txtlv4.Value, txtlv5.Value);

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
            public string name { get; set; }
            public string faminame { get; set; }
            public string date_of_birth { get; set; }
            public string sex { get; set; }
            public string work_place { get; set; }
            public string position { get; set; }
            public string picture_url { get; set; }
            public string userame { get; set; }
            public string lv1 { get; set; }
            public string lv2 { get; set; }
            public string lv3 { get; set; }
            public string lv4 { get; set; }
            public string lv5 { get; set; }

            public GetUserProfile(string id, string name, string faminame, DateTime date_of_birth, string sex, string work_place, string position, string picture_url, string userame, string lv1, string lv2, string lv3, string lv4, string lv5)
            {
                this.id = id;
                this.name = name;
                this.faminame = faminame;
                this.date_of_birth = date_of_birth.ToString("MM/dd/yyyy");
                this.sex = sex;
                this.work_place = work_place;
                this.position = position;
                this.picture_url = picture_url;
                this.userame = userame;
                this.lv1 = lv1;
                this.lv2 = lv2;
                this.lv3 = lv3;
                this.lv4 = lv4;
                this.lv5 = lv5;
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
                    getUserProfile.Add(new GetUserProfile(vl.id, vl.name, vl.faminame, vl.date_of_birth, vl.sex, vl.work_place, vl.position,
                        vl.picture_url, vl.userame, vl.lv1, vl.lv2, vl.lv3, vl.lv4, vl.lv5));
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

            txtID.Value = _userProfile.id;
            txtIDHidden.Value = _userProfile.id;
            txtID.Attributes.Add("disabled", "disabled");
            txtName.Value = _userProfile.name;
            txtfaminame.Value = _userProfile.faminame;
            dtpBD.Value = _userProfile.date_of_birth;
            txtworkPlace.Value = _userProfile.work_place;
            txtPosition.Value = _userProfile.position;
            lblPicUrlPath.InnerText = _userProfile.picture_url;
            avartaUrl.Value = _userProfile.picture_url;
            txtUsername.Value = _userProfile.userame;
            txtlv1.Value = _userProfile.lv1;
            txtlv2.Value = _userProfile.lv2;
            txtlv3.Value = _userProfile.lv3;
            txtlv4.Value = _userProfile.lv4;
            txtlv5.Value = _userProfile.lv5;
            profileImage.Src = _userProfile.picture_url.Replace("~", "");
            if (_userProfile.sex == "m")
            {
                rdMale.Attributes.Add("checked", "checked");
            }
            else if (_userProfile.sex == "f")
            {
                rdFamale.Attributes.Add("checked", "checked");
            }
        }
    }
}
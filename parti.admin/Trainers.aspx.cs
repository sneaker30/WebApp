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
    public partial class Trainers : System.Web.UI.Page
    {
        public static List<GetTrainerList> TrainerLists = new List<GetTrainerList>();
        public static GetSetEnCoding enCoding = new GetSetEnCoding();
        public static Page _Page = new Page();

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

        public List<GetTrainerList> GetTrainerLists()
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
                int i = 0;
                rootObject = JsonConvert.DeserializeObject<partiDB.RootObject>(json_str);
                foreach (var vl in rootObject.GetTrainerList)
                {
                    TrainerLists.Add(new GetTrainerList(vl.id, vl.name, vl.faminame, vl.date_of_birth, vl.sex, vl.work_place, vl.position,
                        vl.picture_url, vl.userame, vl.lv1, vl.lv2, vl.lv3, vl.lv4, vl.lv5));
                    //Render Carousel
                    HtmlElement carouselItem = new HtmlElement();
                    carouselItem.InnerHtml = "<div class='card card-profiler laotxt hvr-grow-shadow' data-cindex='" + i + "'>" +
                        "<div class='card-image'>" +
                        "<a href='#'><img class='img' src='" + vl.picture_url.Replace("~", "") + "'></a>" +
                        "</div>" +
                        "<div class='table center'>" +
                        "<p>" + vl.name + " " + vl.faminame + "</p>" +
                        "<h6>" + vl.position + "</h6>" +
                        "<button id='btn" + i + "' value='" + i + "' onclick='SetTrainerInfo(this.value); return false;' type='button' " +
                        "class='btn-floating btn-small waves-effect waves-light red tooltipped modal-trigger' href='#modalTrainer' data-position='top' " +
                        "data-tooltip='ຂໍ້ມູນເພີ່ມຕື່ມ'><i class='material-icons'>keyboard_arrow_down</i></button>" +
                        "</div></div>";
                    crsTrainerList.Controls.AddAt(i, carouselItem);
                    i++;
                }
                lblTotalTrainer.InnerText = i.ToString();
            }
            return TrainerLists;
        }

        public class GetTrainerList
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

            public GetTrainerList(string id, string name, string faminame, DateTime date_of_birth, string sex, string work_place, string position, string picture_url, string userame, string lv1, string lv2, string lv3, string lv4, string lv5)
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

        [WebMethod]
        public static GetTrainerList GetTrainerInfo(int TrainerID)
        {
            GetTrainerList getTrainer;
            getTrainer = TrainerLists[TrainerID];

            return getTrainer;
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
                if (string.IsNullOrEmpty(imageUpload.PostedFile.FileName) == false)
                {
                    var imgfile = Path.GetFileName(imageUpload.PostedFile.FileName);
                    var imgfilePath = Server.MapPath("avatar/") + imgfile;
                    var extension = Path.GetExtension(imgfilePath);
                    var renamePath = Server.MapPath("avatar/") + txtUsername.Value + extension;
                    picture_url = "~/avatar/" + txtUsername.Value + extension;
                    imageUpload.SaveAs(imgfilePath);
                    if (imgfilePath != renamePath)
                    {
                        if (File.Exists(renamePath))
                        {
                            File.Delete(renamePath);
                        }
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

                if (action == "add")
                {
                    txtid = txtID.Value;
                }
                else if (action == "edit")
                {
                    txtid = txtIDHidden.Value;
                }


                var result = parti.EditTrainer(action, txtid, txtName.Value, txtfaminame.Value, dtpBD.Value, sex, txtworkPlace.Value,
                    txtPosition.Value, picture_url, txtUsername.Value, txtlv1.Value, txtlv2.Value, txtlv3.Value, txtlv4.Value, txtlv5.Value);

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

        protected void btnDel_Click(object sender, EventArgs e)
        {
            try
            {
                wcf.parti.Service1 _parti = new wcf.parti.Service1();
                string action = "del";
                string sex = null;
                string picture_url = null;
                string renamePath = Server.MapPath(avartaUrl.Value.Replace("~/", ""));

                string result = _parti.EditTrainer(action, txtIDHidden.Value, txtName.Value, txtfaminame.Value, dtpBD.Value, sex, txtworkPlace.Value,
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
                    if (avartaUrl.Value != "~/img/avatar.png")
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
    }
}
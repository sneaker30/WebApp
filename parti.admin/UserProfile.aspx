﻿<%@ Page Title="ຂໍ້ມູນສ່ວນຕົວ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="parti.admin.UserProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .bottom-sheet {
            min-height: 80%;
        }

        .imageUpload {
            display: none;
        }

        .profileImage {
            cursor: pointer;
        }

        #profile-container {
            width: 150px;
            height: 150px;
            overflow: hidden;
            -webkit-border-radius: 50%;
            -moz-border-radius: 50%;
            -ms-border-radius: 50%;
            -o-border-radius: 50%;
            border-radius: 50%;
        }

            #profile-container img {
                width: 150px;
                height: 150px;
            }

        .img {
            width: 100px;
            height: 110px;
            object-fit: fill;
            cursor: pointer;
        }

        .card {
            display: inline-block;
            position: relative;
            width: 150px;
            margin-bottom: 50px;
            margin-right: 20px;
            border-radius: 6px;
            color: rgba(0, 0, 0, 0.87);
            background: #fff;
            box-shadow: 0 2px 2px 0 rgba(0, 0, 0, 0.14), 0 3px 1px -2px rgba(0, 0, 0, 0.2), 0 1px 5px 0 rgba(0, 0, 0, 0.12);
        }

        .card-profile {
            margin-top: 30px;
            text-align: center;
        }

        .card .card-image {
            position: relative;
            overflow: hidden;
            margin-left: 15px;
            margin-right: 15px;
            margin-top: -30px;
            border-radius: 6px;
            box-shadow: 0 16px 38px -12px rgba(0, 0, 0, 0.56), 0 4px 25px 0px rgba(0, 0, 0, 0.12), 0 8px 10px -5px rgba(0, 0, 0, 0.2);
        }

        .table {
            padding: 10px;
            margin-bottom: 0px;
            background-color: transparent;
        }

        .img {
            align-content: center;
            object-fit: cover;
        }

        .select-dropdown {
            font-family: PhetsarathOT;
        }
    </style>
    <br />
    <br />

    <div class="row">
        <div class="col s12 m3 l3" align="center">
            <div id="profile-container">
                <img id="profileImage" runat="server" src="img/avatar.png" class="img responsive-img tooltipped" data-position="left" data-tooltip="ປ່ຽນຮູບພາບ 150x150" />
            </div>
            <asp:FileUpload ID="imageUpload" runat="server" name="profile_photo" class="imageUpload" />
        </div>
        <br />
        <div class="col s12 m9 l9">
            <ul class="tabs" id="myTab">
                <li class="tab col s2 m2 l2 tooltipped" data-position="top" data-tooltip="ປະຫວັດສ່ວນຕົວ"><a href="#PersonalInfo" class="grey-text">
                    <h6>ປະຫວັດສ່ວນຕົວ</h6>
                </a></li>
                <li class="tab col s2 m2 l2 tooltipped" data-position="top" data-tooltip="ວຸດທິການສຶກສາ"><a href="#Edocation" class="grey-text">
                    <h6>ວຸດທິການສຶກສາ</h6>
                </a></li>
                <li class="tab col s2 m2 l2 tooltipped" data-position="top" data-tooltip="ບ່ອນປະຈຳການປະຈຸບັນ"><a href="#Workplace" class="grey-text">
                    <h6>ບ່ອນປະຈຳການປະຈຸບັນ</h6>
                </a></li>
                <li class="tab col s2 m2 l2 tooltipped" data-position="top" data-tooltip="ປະສົບການດ້ານການປະຕິບັດວຽກງານຜ່ານມາຫາປັດຈຸບັນ"><a href="#Experiance" class="grey-text">
                    <h6>ປະສົບການດ້ານການປະຕິບັດວຽກງານຜ່ານມາຫາປັດຈຸບັນ</h6>
                </a></li>
                <li class="tab col s2 m2 l2 tooltipped" data-position="top" data-tooltip="ປະສົບການໃນການເປັນຄູຝຶກຜ່ານມາຫາປັດຈຸບັນ"><a href="#Trainer" class="grey-text">
                    <h6>ປະສົບການໃນການເປັນຄູຝຶກຜ່ານມາຫາປັດຈຸບັນ</h6>
                </a></li>
                <li class="tab col s2 m2 l2 tooltipped" data-position="top" data-tooltip="ຟຣາຍເອກະສານແນບເຂົ້າໃນລະບົບ"><a href="#FileUpload" class="grey-text">
                    <h6>ຟຣາຍເອກະສານແນບເຂົ້າໃນລະບົບ</h6>
                </a></li>
            </ul>
            <div id="myTabContent">
                <div id="PersonalInfo" class="col s12 m12 l12">
                    <br />
                    <div class="row">
                        <div class="input-field col s12 m12 l12">
                            <input type="text" id="txtID" runat="server" class="validate laotxt" required />
                            <label for="txtID">ລະຫັດພະນັກງານ</label>
                            <input type="hidden" id="txtIDHidden" runat="server" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s12 m6 l6">
                            <label for="txtNameLa">ຊື່ ແລະ ນາມສະກຸນ, ພາສາລາວ</label>
                            <input type="text" id="txtNameLa" runat="server" class="validate laotxt" required />
                        </div>
                        <div class="input-field col s12 m6 l6">
                            <label for="txtNameEng">ຊື່ ແລະ ນາມສະກຸນ, ພາສາອັງກິດ</label>
                            <input type="text" id="txtNameEng" runat="server" class="validate laotxt" required />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s6 m4 l4">
                            <label for="dtpBD">ວັນເດືອນປີເກີດ</label>
                            <input id="dtpBD" type="text" class="datepicker validate laotxt" runat="server" required />
                            <span class="helper-text grey-text" data-error="ສະເພາະວັນທີ." data-success="ວັນເດືອນປີເກີດ.">ວັນເດືອນປີເກີດ.</span>
                        </div>
                        <div class="input-field col s6 m4 l4 center">
                            <div class="row">
                                <p>
                                    <span class="grey-text">ເພດ:</span>
                                    <label>
                                        <input name="group1" type="radio" id="rdMale" runat="server" class="with-gap" checked />
                                        <span>ຊາຍ</span>
                                    </label>
                                    <label>
                                        <input name="group1" type="radio" id="rdFamale" runat="server" class="with-gap" />
                                        <span>ຍິງ</span>
                                    </label>
                                </p>
                            </div>
                        </div>
                        <div class="input-field col s12 m4 l4">
                            <h6 class="grey-text">ຮູບພາບປະຈຳຕົວ:<label id="lblPicUrlPath" runat="server"></label>
                            </h6>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s12 m4 l4">
                            <label for="txtVillage">ບ້ານ</label>
                            <input type="text" id="txtVillage" runat="server" class="validate laotxt autocomplete" required autocomplete="off" onkeyup="GetVill(this.value)" />
                        </div>
                        <div class="input-field col s12 m4 l4">
                            <label for="txtDistrict">ເມືອງ</label>
                            <input type="text" id="txtDistrict" runat="server" class="validate laotxt autocomplete" required autocomplete="off" />
                        </div>
                        <div class="input-field col s12 m4 l4">
                            <label for="txtProvince">ແຂວງ</label>
                            <input type="text" id="txtProvince" runat="server" class="validate laotxt autocomplete" required autocomplete="off" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s12 m6 l6">
                            <br />
                            <div>
                                <span class="grey-text">ສະຖານະພາບ:</span>
                                <label>
                                    <input class="with-gap" type="radio" id="rdMarried" runat="server" name="rdStatus" checked /><span>ໂສດ</span>
                                </label>
                                <label>
                                    <input class="with-gap" type="radio" id="rdSingle" runat="server" name="rdStatus" /><span>ແຕ່ງງານ</span>
                                </label>
                                <label>
                                    <input class="with-gap" type="radio" id="rdDivorce" runat="server" name="rdStatus" /><span>ຍ່າຮ້າງ</span>
                                </label>
                            </div>
                        </div>
                        <div class="input-field col s12 m6 l6">
                            <label for="txtUsername">ຊື່ຜູ້ໃຊ້</label>
                            <input type="text" id="txtUsername" runat="server" class="validate" required />
                            <span class="helper-text">ຊື່ຜູ້ໃຊ້ນີ້ຕ້ອງກົງກັບ ຂໍ້ມູນໃນ "ຂໍ້ມູນບັນຊີຜູ້ໃຊ້"</span>
                        </div>
                    </div>
                </div>
                <div id="Edocation" class="col s12 m12 l12">
                    <br />
                    <div class="row">
                        <div class="input-field col s12 m6 l6">
                            <label for="txtEducation_level">ວິຊາສະເພາະທີ່ຮຽນຈົບຊັ້ນ</label>
                            <input type="text" id="txtEducation_level" runat="server" class="validate laotxt" required />
                            <span class="helper-text">ຕົວຢ່າງ: ຊັ້ນຕົ້ນ, ຊັ້ນກາງ, ຊັ້ນສູງ, ປະລິນຍາຕີ, ປະລິນຍາໂທ, ປະລິນຍາເອກ...</span>
                        </div>
                        <div class="input-field col s12 m6 l6">
                            <label for="txtEducation_major">ສາຂາວິຊາ ຫລື ວິຊາຮຽນ</label>
                            <input type="text" id="txtEducation_major" runat="server" class="validate laotxt" required />
                            <span class="helper-text">ຕົວຢ່າງ: ວິທະຍາສາດການປົກຄອງ, ຄູ...</span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s12 m12 l12">
                            <br />
                            <div>
                                <span class="grey-text">ບ່ອນຮຽນ:</span>
                                <label>
                                    <input class="with-gap" type="radio" id="rdEduIn" runat="server" name="rdEducation_country" checked /><span>ຈົບຈາກພາຍໃນ</span>
                                </label>
                                <label>
                                    <input class="with-gap" type="radio" id="rdEduOut" runat="server" name="rdEducation_country" /><span>ຈົບຈາກຕ່າງປະເທດ</span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s12 m6 l6">
                            <label for="txtEducation_Name">ຊື່ສະຖານສຶກສາ</label>
                            <input type="text" id="txtEducation_Name" runat="server" class="validate laotxt" required />
                        </div>
                        <div class="input-field col s12 m6 l6">
                            <label for="txtEducated_year">ສົກປີຮຽນຈົບ</label>
                            <input type="text" id="txtEducated_year" runat="server" class="validate laotxt" required />
                        </div>
                    </div>
                </div>
                <div id="Workplace" class="col s12 m12 l12">
                    <br />
                    <div class="row">
                        <div class="input-field col s12 m6 l6">
                            <label for="txtWork_place">ກະຊວງ/ແຂວງ/ເມືອງ</label>
                            <input type="text" id="txtWork_place" runat="server" class="validate laotxt" required />
                        </div>
                        <div class="input-field col s12 m6 l6">
                            <label for="txtDepartment">ກົມ/ພະແນກ/ຫ້ອງການ</label>
                            <input type="text" id="txtDepartment" runat="server" class="validate laotxt" required />
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s12 m6 l6">
                            <label for="txtPosition">ຕຳແໜ່ງ</label>
                            <input type="text" id="txtPosition" runat="server" class="validate laotxt" required />
                        </div>

                        <div class="input-field col s12 m6 l6">
                            <label for="txtDate_of_govermented">ວັນສັງກັດລັດ</label>
                            <input type="text" id="txtDate_of_govermented" runat="server" class="datepicker validate laotxt" required />
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s12 m4 l4">
                            <label for="txtOffice_tel">ເບີໂທຫ້ອງການ</label>
                            <input type="text" id="txtOffice_tel" runat="server" class="validate laotxt" required />
                        </div>
                        <div class="input-field col s12 m4 l4">
                            <label for="txtMobile_tel">ເບີມືຖື</label>
                            <input type="text" id="txtMobile_tel" runat="server" class="validate laotxt" required />
                        </div>
                        <div class="input-field col s12 m4 l4">
                            <label for="txtEmail">ອີເມວ</label>
                            <input type="text" id="txtEmail" runat="server" class="validate laotxt" required />
                        </div>
                    </div>
                </div>
                <div id="Experiance" class="col s12 m12 l12">
                    <br />
                    <div class="row">
                        <div class="input-field col s12 m3 l3">
                            <label for="txtEx_Responsibility">ຮັບຜິດຊອບວຽກງານ</label>
                            <input type="text" id="txtEx_Responsibility" runat="server" class="validate laotxt" />
                        </div>
                        <div class="input-field col s12 m3 l3">
                            <label for="txtEx_Office">ພາກສ່ວນ</label>
                            <input type="text" id="txtEx_Office" runat="server" class="validate laotxt" />
                        </div>
                        <div class="input-field col s12 m3 l3">
                            <label for="txtEx_Years">ໄລຍະເວລາ/ສົກປີ</label>
                            <input type="text" id="txtEx_Years" runat="server" class="validate laotxt" />
                        </div>
                        <div class="col s12 m3 l3">
                            <br />
                            <a class="waves-effect btn-small grey lighten-1 col s12 m12 l12 z-depth-3" onclick="EditExPer()">ເພີ່ມປະສົບການ</a>
                        </div>
                    </div>
                    <div class="row">
                        <table>
                            <thead>
                                <tr>
                                    <th class="col s12 m3 l3"></th>
                                    <th class="col s12 m3 l3"></th>
                                    <th class="col s12 m3 l3"></th>
                                    <th class="col s12 m3 l3"></th>
                                </tr>
                            </thead>
                            <tbody id="tbody_WorkExper">
                            </tbody>
                        </table>
                    </div>
                </div>
                <div id="FileUpload" class="col s12 m12 l12">
                    <br />
                    <div class="row">
                        <div class="col s12 m12 l12">
                            <asp:FileUpload type="file" class="file-path validate tooltipped" data-position="left" data-tooltip="ແນບເອກະສານ" ID="txtReferDoc1" runat="server" onchange="LabelMe(this)" />
                            ທີ່ຢູ່ຂອງຟຣາຍ:
                                <label id="txtReferDoc1Hidd" runat="server"></label>
                            <input type="hidden" id="txtReferDoc1Hidd_I" runat="server" />
                            <a class="btn btn-flat tooltipped" data-position="right" data-tooltip="ເປີດເບີ່ງຟຣາຍ" onclick="PreviewIMG(document.getElementById('<%: txtReferDoc1Hidd_I.ClientID %>').value)">
                                <i class="material-icons">pageview</i>
                            </a>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s12 m12 l12">
                            <asp:FileUpload type="file" class="file-path validate tooltipped" data-position="left" data-tooltip="ແນບເອກະສານ" ID="txtReferDoc2" runat="server" onchange="LabelMe(this)" />
                            ທີ່ຢູ່ຂອງຟຣາຍ:
                                <label id="txtReferDoc2Hidd" runat="server"></label>
                            <input type="hidden" id="txtReferDoc2Hidd_I" runat="server" />
                            <a class="btn btn-flat tooltipped" data-position="right" data-tooltip="ເປີດເບີ່ງຟຣາຍ" onclick="PreviewIMG(document.getElementById('<%: txtReferDoc2Hidd_I.ClientID %>').value)">
                                <i class="material-icons">pageview</i>
                            </a>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s12 m12 l12">
                            <asp:FileUpload type="file" class="file-path validate tooltipped" data-position="left" data-tooltip="ແນບເອກະສານ" ID="txtReferDoc3" runat="server" onchange="LabelMe(this)" />
                            ທີ່ຢູ່ຂອງຟຣາຍ:
                                <label id="txtReferDoc3Hidd" runat="server"></label>
                            <input type="hidden" id="txtReferDoc3Hidd_I" runat="server" />
                            <a class="btn btn-flat tooltipped" data-position="right" data-tooltip="ເປີດເບີ່ງຟຣາຍ" onclick="PreviewIMG(document.getElementById('<%: txtReferDoc3Hidd_I.ClientID %>').value)">
                                <i class="material-icons">pageview</i>
                            </a>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s12 m12 l12">
                            <asp:FileUpload type="file" class="file-path validate tooltipped" data-position="left" data-tooltip="ແນບເອກະສານ" ID="txtReferDoc4" runat="server" onchange="LabelMe(this)" />
                            ທີ່ຢູ່ຂອງຟຣາຍ:
                                <label id="txtReferDoc4Hidd" runat="server"></label>
                            <input type="hidden" id="txtReferDoc4Hidd_I" runat="server" />
                            <a class="btn btn-flat tooltipped" data-position="right" data-tooltip="ເປີດເບີ່ງຟຣາຍ" onclick="PreviewIMG(document.getElementById('<%: txtReferDoc4Hidd_I.ClientID %>').value)">
                                <i class="material-icons">pageview</i>
                            </a>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s12 m12 l12">
                            <asp:FileUpload type="file" class="file-path validate tooltipped" data-position="left" data-tooltip="ແນບເອກະສານ" ID="txtReferDoc5" runat="server" onchange="LabelMe(this)" />
                            ທີ່ຢູ່ຂອງຟຣາຍ:
                                <label id="txtReferDoc5Hidd" runat="server"></label>
                            <input type="hidden" id="txtReferDoc5Hidd_I" runat="server" />
                            <a class="btn btn-flat tooltipped" data-position="right" data-tooltip="ເປີດເບີ່ງຟຣາຍ" onclick="PreviewIMG(document.getElementById('<%: txtReferDoc5Hidd_I.ClientID %>').value)">
                                <i class="material-icons">pageview</i>
                            </a>
                        </div>
                    </div>
                </div>
                <div id="Trainer" class="col s12 m12 l12">
                    <br />
                    <table>
                        <thead>
                            <tr>
                                <th class="col s1 m1 l1 grey-text">ລ/ດ</th>
                                <th class="col s3 m3 l3 grey-text">ຫຼັກສູດ/ຫົວຂໍ້</th>
                                <th class="col s2 m2 l2 grey-text">ຈັດໂດຍ</th>
                                <th class="col s4 m4 l4 grey-text">ສະຖານທີ່</th>
                                <th class="col s2 m2 l2 grey-text">ວັນທີ-ເດືອນ-ປີ</th>
                            </tr>
                        </thead>
                        <tbody id="tbody">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col s12 m3 l3"></div>
        <div class="col s12 m9 l9">
            <asp:Button class="btn-small waves-effect waves-light laotxt z-depth-3" ID="btnSave" runat="server" OnClick="btnSave_Click" Text="ບັນທຶກ"></asp:Button>
            <input type="hidden" id="btnState" runat="server" />
            <input type="hidden" id="avartaUrl" runat="server" />
            <input type="hidden" id="txtAvatarHidd_I" runat="server" />
            <input type="hidden" id="uid" runat="server" />
        </div>
    </div>

    <script>
        $(document).ready(function () {
            $('.autocomplete').autocomplete();
            $('.tooltipped').tooltip();
            $('.modal').modal();
            $('.tabs').tabs();
            $('.datepicker').datepicker({
                format: 'yyyy-mm-dd'
            });

            $('#<%: profileImage.ClientID %>').click(function (e) {
                $('#<%: imageUpload.ClientID %>').click();
            });

            function fasterPreview(uploader) {
                if (uploader.files && uploader.files[0]) {
                    $('#<%: profileImage.ClientID %>').attr('src', window.URL.createObjectURL(uploader.files[0]));
                }
            }

            $('#<%: imageUpload.ClientID %>').change(function () {
                fasterPreview(this);
                var thefile = document.getElementById('<%: imageUpload.ClientID %>');
                document.getElementById('<%: lblPicUrlPath.ClientID %>').innerText = thefile.value;
            });

            GetAutocompleteVill('');
            $('#<%: txtVillage.ClientID %>.autocomplete').autocomplete({
                data: itemVillage,
                limit: 10
            });

            GetAutocompleteDis();
            $('#<%: txtDistrict.ClientID %>.autocomplete').autocomplete({
                data: itemDistrict,
                limit: 10
            });
            GetAutocompletePro();
            $('#<%: txtProvince.ClientID %>.autocomplete').autocomplete({
                data: itemProvince,
                limit: 10
            });

            var uid = document.getElementById('<%: uid.ClientID %>').value;
            GetTrainingExp_Trainer(uid);
            GetExperience(uid);
        });

        function GetVill(txt) {
            GetAutocompleteVill(txt);
            $('#<%: txtVillage.ClientID %>.autocomplete').autocomplete({
                data: itemVillage,
                limit: 10
            });
            $('#<%: txtVillage.ClientID %>.autocomplete').autocomplete('open');
        }

        var exper_check;
        var respon_check;
        var offic_check;
        var yea_check;

        function EditExPer() {
            var experience_id = document.getElementById("<%: txtID.ClientID %>").value;
            var responsibility = document.getElementById("<%: txtEx_Responsibility.ClientID %>").value;
            var office = document.getElementById("<%: txtEx_Office.ClientID %>").value;
            var years = document.getElementById("<%: txtEx_Years.ClientID %>").value;

            var result = EditExperience("add", "", experience_id, responsibility, office, years);
            if (result === "e3") {
                swalModal('warning', 'ມີຂໍ້ມູນນີ້ຢູ່ແລ້ວ', '');
            } else if (result === "e5") {
                GetExperience(experience_id);
            }
        }

        function EditExperience(action, id, experience_id, responsibility, office, years) {
            var result;
            $.ajax({
                async: false,
                type: "POST",
                url: "<%: ResolveUrl("Trainers.aspx/EditExperiance") %>",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{action:'" +
                    action +
                    "', id:'" +
                    id +
                    "', experience_id:'" +
                    experience_id +
                    "', responsibility:'" +
                    responsibility +
                    "', office:'" +
                    office +
                    "', years:'" +
                    years +
                    "'}",
                success: function (response) {
                    var obj = response.d;
                    result = obj;
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
            return result;
        }

        function DelExperience(id, experience_id) {
            var result = EditExperience('del', id, experience_id, '', '', '');
            if (result === "e5") {
                GetExperience(experience_id);
            }
        }

        function GetExperience(exper_id) {
            $.ajax({
                type: "POST",
                url: "<%: ResolveUrl("Trainers.aspx/GetExperianceInfo") %>",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{exper_id:'" + exper_id + "'}",
                success: function (response) {
                    var obj = response.d;
                    $('#tbody_WorkExper').empty();
                    $.each(obj,
                        function (key, value) {
                            var element =
                                '<tr><td class="col s12 m3 l3 left grey-text">' + value.responsibility + '</td>' +
                                '<td class="col s12 m3 l3 left grey-text">' + value.office + '</td>' +
                                '<td class="col s12 m3 l3 left grey-text">' + value.years + '</td>' +
                                '<td class="col s12 m3 l3 left grey-text center">' +
                                '<a class="btn-floating btn-small waves-effect waves-light tooltipped red darken-3 z-depth-3" data-position="right" data-tooltip="ລົບ" id="' +
                                value.id + '" name="' + value.experience_id + '"' +
                                "onclick='DelExperience(this.id, this.name)'>" +
                                '<i class="material-icons">delete</i></a>' +
                                '</td></tr>';
                            document.getElementById("tbody_WorkExper").insertAdjacentHTML("beforeend", element);
                            $('.tooltipped').tooltip();
                        });
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }

        function GetTrainingExp_Trainer(id) {
            $.ajax({
                type: "POST",
                url: "<%: ResolveUrl("Trainers.aspx/GetTrainingExperiences_Trainer") %>",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{id:'" + id + "'}",
                success: function (response) {
                    $('#tbody').empty();
                    var obj = response.d;
                    var i = 1;
                    $.each(obj,
                        function (key, value) {
                            var IntOut = value.int_or_ext;
                            if (IntOut === "int") {
                                IntOut = "ຈັດພາຍໃນສະຖາບັນ";
                            } else if (IntOut === "ext") {
                                IntOut = "ຈັດພາຍໃນສະຖາບັນ";
                            }
                            var element = "<tr><td class='col s1 m1 l1 grey-text'>" + i + "</td>" +
                                "<td class='col s3 m3 l3 grey-text'>" + value.title + "</td>" +
                                "<td class='col s2 m2 l2 grey-text'>" + IntOut + "</td>" +
                                "<td class='col s4 m4 l4 grey-text'>" + value.address + "</td>" +
                                "<td class='col s2 m2 l2 grey-text'>" + value.training_date + "</td></tr>";
                            i++;
                            document.getElementById("tbody").insertAdjacentHTML("beforeend", element);
                        });
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }

        var itemVillage = {};
        var itemDistrict = {};
        var itemProvince = {};

        function GetAutocompleteVill(v_name) {
            $.ajax({
                type: "POST",
                url: "<%: ResolveUrl("Training.aspx/GetVillages") %>",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{v_name:'" + v_name + "'}",
                success: function (response) {
                    var obj = response.d;
                    $.each(obj,
                        function (key, value) {
                            itemVillage['' + value.v_name + ''] = null;
                        });
                },
                failure: function (response) {
                    swalModal('error', response.d, '');
                }
            });
        }

        function GetAutocompleteDis() {
            $.ajax({
                type: "POST",
                url: "<%: ResolveUrl("Training.aspx/GetDistricts") %>",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var obj = response.d;
                    $.each(obj,
                        function (key, value) {
                            itemDistrict['' + value.d_name + ''] = null;
                        });
                },
                failure: function (response) {
                    swalModal('error', response.d, '');
                }
            });
        }

        function GetAutocompletePro() {
            $.ajax({
                type: "POST",
                url: "<%: ResolveUrl("Training.aspx/GetProvinces") %>",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var obj = response.d;
                    $.each(obj,
                        function (key, value) {
                            itemProvince['' + value.p_name + ''] = null;
                        });
                },
                failure: function (response) {
                    swalModal('error', response.d, '');
                }
            });
        }

        function LabelMe(obj) {
            var label_name = obj.id + "Hidd";
            var input_name = obj.id + "Hidd_I";
            document.getElementById(label_name).innerText = obj.value;
        }
    </script>
</asp:Content>

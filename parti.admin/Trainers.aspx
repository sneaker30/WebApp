<%@ Page Title="ຂໍ້ມູນຄູຝຶກ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Trainers.aspx.cs" Inherits="parti.admin.Trainers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="scm" runat="server" EnablePageMethods="true" />

    <style>
        .bottom-sheet {
            min-height: 90%;
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
    <!-- Search BOX & Main Function -->
    <div class="row">
        <div class="col s6 m6 l6">
            <div class="input-field">
                <label for="txtSearch">ຄົ້ນຫາ</label>
                <input id="txtSearch" runat="server" type="text" class="laotxt" autocomplete="on" />
                <span class="helper-text">ຂໍ້ມູນທີ່ສາມາດຄົ້ນຫາໄດ້: ຊື່ ແລະ ນາມສະກຸນ...</span>
            </div>
        </div>
        <div class="col">
            <br />
            <a class="hvr-grow-shadow btn-floating red darken-3 left z-depth-3 tooltipped" data-position="bottom" data-tooltip="ຄົ້ນຫາ" onclick="Search()" id="btnSearch">
                <i class="material-icons">search</i>
            </a>
        </div>
        <div class="col">
            <br />
            <a class="hvr-grow-shadow btn-floating blue tooltipped modal-trigger left z-depth-3" href="#modalTrainer" data-position="bottom" data-tooltip="ເພີ່ມ" onclick="SetTrainerInfo('-1')">
                <i class="material-icons">add</i>
            </a>
        </div>
    </div>
    <!-- Search BOX & Main Function -->

    <%-- Total Trainer --%>
    <div class="row">
        <div class="col">
            <h5 class="grey-text darken-3">ຈຳນວນຄູຝຶກທັງຫມົດ:</h5>
        </div>
        <div class="col">
            <h5 class="red-text darken-3" id="lblTotalTrainer" runat="server">0</h5>
        </div>
    </div>
    <%-- Total Trainer --%>
    <br />
    <br />
    <%-- Card Start --%>
    <div class="row">
        <div class="col">
            <div class="row" id="crsTrainerList" runat="server">
            </div>
        </div>
    </div>
    <%-- Card End --%>

    <%-- modal profile start --%>
    <div id="modalTrainer" class="modal bottom-sheet">
        <div class="modal-content">
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
                        <li class="tab col s2 m2 l2 tooltipped" data-position="top" data-tooltip="ປະຫວັດສ່ວນຕົວ"><a href="#PersonalInfo" class="grey-text"><h6>ປະຫວັດສ່ວນຕົວ</h6></a></li>
                        <li class="tab col s2 m2 l2 tooltipped" data-position="top" data-tooltip="ວຸດທິການສຶກສາ"><a href="#Edocation" class="grey-text"><h6>ວຸດທິການສຶກສາ</h6></a></li>
                        <li class="tab col s2 m2 l2 tooltipped" data-position="top" data-tooltip="ບ່ອນປະຈຳການປະຈຸບັນ"><a href="#Workplace" class="grey-text"><h6>ບ່ອນປະຈຳການປະຈຸບັນ</h6></a></li>
                        <li class="tab col s2 m2 l2 tooltipped" data-position="top" data-tooltip="ປະສົບການດ້ານການປະຕິບັດວຽກງານຜ່ານມາຫາປັດຈຸບັນ"><a href="#Experiance" class="grey-text"><h6>ປະສົບການດ້ານການປະຕິບັດວຽກງານຜ່ານມາຫາປັດຈຸບັນ</h6></a></li>
                        <li class="tab col s2 m2 l2 tooltipped" data-position="top" data-tooltip="ປະສົບການໃນການເປັນຄູຝຶກຜ່ານມາຫາປັດຈຸບັນ"><a href="#Trainer" class="grey-text"><h6>ປະສົບການໃນການເປັນຄູຝຶກຜ່ານມາຫາປັດຈຸບັນ</h6></a></li>
                        <li class="tab col s2 m2 l2 tooltipped" data-position="top" data-tooltip="ຟຣາຍເອກະສານແນບເຂົ້າໃນລະບົບ"><a href="#FileUpload" class="grey-text"><h6>ຟຣາຍເອກະສານແນບເຂົ້າໃນລະບົບ</h6></a></li>
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

                                <div class="col s12 m6 l6">
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
        </div>
        <br />
        <div class="modal-footer">
            <div class="row">
                <div class="col s12 m3 l3"></div>
                <div class="col s12 m1 l1">
                    <asp:Button class="btn-small waves-effect waves-light laotxt left z-depth-3" ID="btnSave" runat="server" OnClick="btnSave_Click" Text="ບັນທຶກ"></asp:Button>
                    <input type="hidden" id="btnState" runat="server" />
                    <input type="hidden" id="avartaUrl" runat="server" />
                </div>
                <div class="col s12 m1 l1">
                    <a class="btn-small waves-effect waves-light modal-close laotxt left z-depth-3">ຍົກເລີກ</a>
                </div>
                <div class="col s12 m7 l7">
                    <asp:Button class="btn-small waves-effect waves-light right red darken-3 laotxt z-depth-3" ID="btnDel" runat="server" Text="ລົບ" OnClick="btnDel_Click"></asp:Button>
                </div>
            </div>
            <input type="hidden" id="txtAvatarHidd_I" runat="server" />
        </div>
    </div>
    <%-- modal profile end --%>

    <%-- Customs JS --%>
    <script type="text/javascript">

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
        });

        function PreviewIMG(file) {
            if (file != '') {
                window.open(file);
            } else {
                swalToast('info', 'e1: ບໍ່ມີໄຟຣທີ່ຈະສະແດງ...');
            }
        }

        function GetVill(txt) {
            GetAutocompleteVill(txt);
            $('#<%: txtVillage.ClientID %>.autocomplete').autocomplete({
                data: itemVillage,
                limit: 10
            });
            $('#<%: txtVillage.ClientID %>.autocomplete').autocomplete('open');
        }

        function Search() {
            var txt = document.getElementById('<%: txtSearch.ClientID %>').value;
            var index = $('.card:contains("' + txt + '")').index();
            $('.card:not(:contains("' + txt + '"))').hide('500');
            $('.card:contains("' + txt + '")').show();
        }

        function SetTrainerInfo(id) {
            var trainerID = id;
            if (trainerID == "-1") {
                ClearTxT();
                document.getElementById("<%: btnState.ClientID %>").value = "add";
            } else {
                document.getElementById("<%: btnState.ClientID %>").value = "edit";
                $.ajax({
                    type: "POST",
                    url: "<%: ResolveUrl("Trainers.aspx/GetTrainerInfo") %>",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{TrainerID:" + trainerID + "}",
                    success: function (response) {
                        var obj = response.d;
                        GetTrainingExp_Trainer(obj.id);
                        document.getElementById("<%: txtID.ClientID %>").value = obj.id;
                        GetExperience(obj.id);
                        document.getElementById("<%: txtID.ClientID %>").setAttribute("disabled", "disabled");
                        document.getElementById("<%: txtIDHidden.ClientID %>").value = obj.id;
                        document.getElementById("<%: txtNameLa.ClientID %>").value = obj.fullname_la;
                        document.getElementById("<%: txtNameEng.ClientID %>").value = obj.fullname_eng;
                        document.getElementById("<%: dtpBD.ClientID %>").value = obj.date_of_birth;
                        if (obj.sex == "m") {
                            document.getElementById("<%: rdMale.ClientID %>").setAttribute("checked", "checked");
                        } else if (obj.sex == "f") {
                            document.getElementById("<%: rdFamale.ClientID %>").setAttribute("checked", "checked");
                        }
                        if (obj.status === "s") {
                            document.getElementById("<%: rdSingle.ClientID %>").setAttribute("checked", "checked");
                        } else if (obj.status === "d") {
                            document.getElementById("<%: rdDivorce.ClientID %>").setAttribute("checked", "checked");
                        } else if (obj.status === "m") {
                            document.getElementById("<%: rdMarried.ClientID %>").setAttribute("checked", "checked");
                        }
                        document.getElementById("<%: txtVillage.ClientID %>").value = obj.village;
                        document.getElementById("<%: txtDistrict.ClientID %>").value = obj.district;
                        document.getElementById("<%: txtProvince.ClientID %>").value = obj.province;
                        document.getElementById("<%: txtWork_place.ClientID %>").value = obj.work_place;
                        document.getElementById("<%: txtDepartment.ClientID %>").value = obj.department;
                        document.getElementById("<%: txtPosition.ClientID %>").value = obj.position;
                        document.getElementById("<%: txtDate_of_govermented.ClientID %>").value = obj.date_of_govermented;
                        document.getElementById("<%: txtOffice_tel.ClientID %>").value = obj.office_tel;
                        document.getElementById("<%: txtMobile_tel.ClientID %>").value = obj.mobile_tel;
                        document.getElementById("<%: txtEmail.ClientID %>").value = obj.email;
                        document.getElementById("<%: profileImage.ClientID %>").src = obj.avatar_url.replace("~", "");
                        document.getElementById("<%: lblPicUrlPath.ClientID %>").innerText = obj.avatar_url;
                        document.getElementById("<%: txtReferDoc1Hidd.ClientID %>").innerText = obj.doc1_url;
                        document.getElementById("<%: txtReferDoc2Hidd.ClientID %>").innerText = obj.doc2_url;
                        document.getElementById("<%: txtReferDoc3Hidd.ClientID %>").innerText = obj.doc3_url;
                        document.getElementById("<%: txtReferDoc4Hidd.ClientID %>").innerText = obj.doc4_url;
                        document.getElementById("<%: txtReferDoc5Hidd.ClientID %>").innerText = obj.doc5_url;
                        document.getElementById("<%: txtAvatarHidd_I.ClientID %>").value = obj.avatar_url;
                        document.getElementById("<%: txtReferDoc1Hidd_I.ClientID %>").value = obj.doc1_url;
                        document.getElementById("<%: txtReferDoc2Hidd_I.ClientID %>").value = obj.doc2_url;
                        document.getElementById("<%: txtReferDoc3Hidd_I.ClientID %>").value = obj.doc3_url;
                        document.getElementById("<%: txtReferDoc4Hidd_I.ClientID %>").value = obj.doc4_url;
                        document.getElementById("<%: txtReferDoc5Hidd_I.ClientID %>").value = obj.doc5_url;
                        document.getElementById("<%: txtUsername.ClientID %>").value = obj.username;
                        document.getElementById("<%: txtEducation_level.ClientID %>").value = obj.education_level;
                        document.getElementById("<%: txtEducation_major.ClientID %>").value = obj.education_major;
                        document.getElementById("<%: txtEducated_year.ClientID %>").value = obj.educated_year;
                        document.getElementById("<%: txtEducation_Name.ClientID %>").value = obj.education_name;
                        if (obj.education_country === "in") {
                            document.getElementById("<%: rdEduIn.ClientID %>").setAttribute("checked", "checked");
                        } else if (obj.education_country === "out") {
                            document.getElementById("<%: rdEduOut.ClientID %>").setAttribute("checked", "checked");
                        }
                        M.updateTextFields();
                    },
                    failure: function (response) {
                        alert(response.d);
                    }
                });
            }
        }

        function ClearTxT() {
            document.getElementById("<%: txtID.ClientID %>").value = "";
            document.getElementById("<%: txtIDHidden.ClientID %>").value = "";
            document.getElementById("<%: txtNameLa.ClientID %>").value = "";
            document.getElementById("<%: txtNameEng.ClientID %>").value = "";
            document.getElementById("<%: dtpBD.ClientID %>").value = "";
            document.getElementById("<%: txtVillage.ClientID %>").value = "";
            document.getElementById("<%: txtDistrict.ClientID %>").value = "";
            document.getElementById("<%: txtProvince.ClientID %>").value = "";
            document.getElementById("<%: txtWork_place.ClientID %>").value = "";
            document.getElementById("<%: txtDepartment.ClientID %>").value = "";
            document.getElementById("<%: txtPosition.ClientID %>").value = "";
            document.getElementById("<%: txtDate_of_govermented.ClientID %>").value = "";
            document.getElementById("<%: txtOffice_tel.ClientID %>").value = "";
            document.getElementById("<%: txtMobile_tel.ClientID %>").value = "";
            document.getElementById("<%: txtEmail.ClientID %>").value = "";
            document.getElementById("<%: txtReferDoc1Hidd.ClientID %>").innerText = "";
            document.getElementById("<%: txtReferDoc2Hidd.ClientID %>").innerText = "";
            document.getElementById("<%: txtReferDoc3Hidd.ClientID %>").innerText = "";
            document.getElementById("<%: txtReferDoc4Hidd.ClientID %>").innerText = "";
            document.getElementById("<%: txtReferDoc5Hidd.ClientID %>").innerText = "";
            document.getElementById("<%: txtAvatarHidd_I.ClientID %>").value = "";
            document.getElementById("<%: txtReferDoc1Hidd_I.ClientID %>").value = "";
            document.getElementById("<%: txtReferDoc2Hidd_I.ClientID %>").value = "";
            document.getElementById("<%: txtReferDoc3Hidd_I.ClientID %>").value = "";
            document.getElementById("<%: txtReferDoc4Hidd_I.ClientID %>").value = "";
            document.getElementById("<%: txtReferDoc5Hidd_I.ClientID %>").value = "";
            document.getElementById("<%: txtUsername.ClientID %>").value = "";
            document.getElementById("<%: txtEducation_level.ClientID %>").value = "";
            document.getElementById("<%: txtEducation_major.ClientID %>").value = "";
            document.getElementById("<%: txtEducated_year.ClientID %>").value = "";
            document.getElementById("<%: txtEducation_Name.ClientID %>").value = "";
            document.getElementById("<%: profileImage.ClientID %>").src = "img/avatar.png";
            document.getElementById("<%: lblPicUrlPath.ClientID %>").innerText = "";
            document.getElementById("<%: txtID.ClientID %>").removeAttribute("disabled");
            $('#tbody_WorkExper').empty();
            $('#tbody').empty();
            M.updateTextFields();
            exper_check = "";
            respon_check = "";
            offic_check = "";
            yea_check = "";
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

        function LabelMe(obj) {
            var label_name = obj.id + "Hidd";
            var input_name = obj.id + "Hidd_I";
            document.getElementById(label_name).innerText = obj.value;
        }

    </script>
    <%-- Customs JS --%>
</asp:Content>

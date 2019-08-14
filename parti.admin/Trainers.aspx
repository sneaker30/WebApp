<%@ Page Title="ຂໍ້ມູນຄູຝຶກ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Trainers.aspx.cs" Inherits="parti.admin.Trainers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="scm" runat="server" EnablePageMethods="true" />

    <style>
        .bottom-sheet {
            min-height: 100%;
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
                        <img id="profileImage" runat="server" src="https://www.sideshow.com/product-asset/903429/feature" class="img responsive-img tooltipped" data-position="left" data-tooltip="ປ່ຽນຮູບພາບ 150x150" />
                    </div>
                    <asp:FileUpload ID="imageUpload" runat="server" name="profile_photo" class="imageUpload" />
                </div>
                <br />
                <div class="col s12 m9 l9">
                    <ul class="tabs" id="myTab">
                        <li class="tab col"><a href="#PersonalInfo">ປະຫວັດສ່ວນຕົວ</a></li>
                        <li class="tab col"><a href="#Edocation">ວຸດທິການສຶກສາ</a></li>
                        <li class="tab col"><a href="#Workplace">ບ່ອນປະຈຳການປະຈຸບັນ</a></li>
                        <li class="tab col"><a href="#Experiance">ປະສົບການດ້ານການປະຕິບັດວຽກງານຜ່ານມາຫາປັດຈຸບັນ</a></li>
                        <li class="tab col"><a href="#FileUpload">ຟຣາຍເອກະສານແນບເຂົ້າໃນລະບົບ</a></li>
                    </ul>
                    <div id="myTabContent">
                        <div id="PersonalInfo" class="col s12 m12 l12">
                            <br />
                            <div class="row">
                                <div class="col s12 m12 l12">
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
                                            <h6 class="grey-text">ຮູບພາບປະຈຳຕົວ:
                        <label id="lblPicUrlPath" runat="server"></label>
                                            </h6>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col s12 m4 l4">
                                            <label for="txtVillage">ບ້ານ</label>
                                            <input type="text" id="txtVillage" runat="server" class="validate laotxt" required />
                                        </div>
                                        <div class="input-field col s12 m4 l4">
                                            <label for="txtDistrict">ເມືອງ</label>
                                            <input type="text" id="txtDistrict" runat="server" class="validate laotxt" required />
                                        </div>
                                        <div class="input-field col s12 m4 l4">
                                            <label for="txtProvince">ແຂວງ</label>
                                            <input type="text" id="txtProvince" runat="server" class="validate laotxt" required />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col s12 m12 l12">
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
                                    </div>
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
                            <div id="UserAccount" class="col s12 m12 l12">
                                <br />
                                <div class="input-field">
                                    <label for="txtUsername">ຊື່ຜູ້ໃຊ້</label>
                                    <input type="text" id="txtUsername" runat="server" class="validate" required />
                                    <span class="helper-text">ຊື່ຜູ້ໃຊ້ນີ້ຕ້ອງກົງກັບ ຂໍ້ມູນໃນ "ຂໍ້ມູນບັນຊີຜູ້ໃຊ້"</span>
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
                                    <input type="text" id="txtEx_Responsibility" runat="server" class="validate laotxt" required />
                                </div>
                                <div class="input-field col s12 m3 l3">
                                    <label for="txtEx_Office">ພາກສ່ວນ</label>
                                    <input type="text" id="txtEx_Office" runat="server" class="validate laotxt" required />
                                </div>
                                <div class="input-field col s12 m3 l3">
                                    <label for="txtEx_Years">ໄລຍະເວລາ/ສົກປີ</label>
                                    <input type="text" id="txtEx_Years" runat="server" class="validate laotxt" required />
                                </div>
                                <div class="col s12 m3 l3">
                                    <br />
                                    <a class="waves-effect btn-small grey lighten-1 col s12 m12 l12">ເພີ່ມປະສົບການ</a>
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
                                    <tbody>
                                        <tr>
                                            <td class="col s12 m3 l3 left grey-text">Officer</td>
                                            <td class="col s12 m3 l3 left grey-text">PARTI</td>
                                            <td class="col s12 m3 l3 left grey-text">2017</td>
                                            <td class="col s12 m3 l3 left grey-text center"><a class="tooltipped" data-position="right" data-tooltip="ລົບ"><i class="material-icons red-text lighten-3">delete</i></a></td>
                                        </tr>
                                        <tr>
                                            <td class="col s12 m3 l3 left grey-text">Officer</td>
                                            <td class="col s12 m3 l3 left grey-text">PARTI</td>
                                            <td class="col s12 m3 l3 left grey-text">2017</td>
                                            <td class="col s12 m3 l3 left grey-text center"><a class="tooltipped" data-position="right" data-tooltip="ລົບ"><i class="material-icons red-text lighten-3">delete</i></a></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div id="FileUpload" class="col s12 m12 l12">
                            <br />
                            <div class="row">
                                <div class="col s12 m6 l6">
                                    <div class="file-field input-field">
                                        <div class="btn btn-small">
                                            <span>ຮູບພາບຜູ້ຝຶກອົບຮົມ</span>
                                            <input type="file">
                                        </div>
                                        <div class="file-path-wrapper">
                                            <asp:FileUpload type="file" ID="txtAvatar" placeholder="ຮູບພາບຜູ້ຝຶກອົບຮົມ" runat="server" onchange="LabelMe(this)" />
                                            <label id="txtAvatarHidd" runat="server" style="font-size: large"></label>
                                            <input type="hidden" id="txtAvatarHidd_I" runat="server" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col s12 m6 l6">
                                    <a class="btn btn-flat right" onclick="PreviewIMG(document.getElementById('<%: txtAvatarHidd_I.ClientID %>').value)">
                                        <i class="material-icons">pageview</i>
                                    </a>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col s12 m6 l6">
                                    <div class="file-field input-field">
                                        <div class="btn btn-small">
                                            <span>ເອກະສານແນບທີ1</span>
                                            <input type="file">
                                        </div>
                                        <div class="file-path-wrapper">
                                            <asp:FileUpload type="file" class="file-path validate" ID="txtReferDoc1" placeholder="ເອກະສານແນບທີ1" runat="server" onchange="LabelMe(this)" />
                                            <label id="txtReferDoc1Hidd" runat="server" style="font-size: large"></label>
                                            <input type="hidden" id="txtReferDoc1Hidd_I" runat="server" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col s12 m6 l6">
                                    <a class="btn btn-flat right" onclick="PreviewIMG(document.getElementById('<%: txtReferDoc1Hidd_I.ClientID %>').value)">
                                        <i class="material-icons">pageview</i>
                                    </a>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col s12 m6 l6">
                                    <div class="file-field input-field">
                                        <div class="btn btn-small">
                                            <span>ເອກະສານແນບທີ2</span>
                                            <input type="file">
                                        </div>
                                        <div class="file-path-wrapper">
                                            <asp:FileUpload type="file" class="file-path validate" ID="txtReferDoc2" placeholder="ເອກະສານແນບທີ2" runat="server" onchange="LabelMe(this)" />
                                            <label id="txtReferDoc2Hidd" runat="server" style="font-size: large"></label>
                                            <input type="hidden" id="txtReferDoc2Hidd_I" runat="server" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col s12 m6 l6">
                                    <a class="btn btn-flat right" onclick="PreviewIMG(document.getElementById('<%: txtReferDoc2Hidd_I.ClientID %>').value)">
                                        <i class="material-icons">pageview</i>
                                    </a>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col s12 m6 l6">
                                    <div class="file-field input-field">
                                        <div class="btn btn-small">
                                            <span>ເອກະສານແນບທີ3</span>
                                            <input type="file">
                                        </div>
                                        <div class="file-path-wrapper">
                                            <asp:FileUpload type="file" class="file-path validate" ID="txtReferDoc3" placeholder="ເອກະສານແນບທີ3" runat="server" onchange="LabelMe(this)" />
                                            <label id="txtReferDoc3Hidd" runat="server" style="font-size: large"></label>
                                            <input type="hidden" id="txtReferDoc3Hidd_I" runat="server" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col s12 m6 l6">
                                    <a class="btn btn-flat right" onclick="PreviewIMG(document.getElementById('<%: txtReferDoc3Hidd_I.ClientID %>').value)">
                                        <i class="material-icons">pageview</i>
                                    </a>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col s12 m6 l6">
                                    <div class="file-field input-field">
                                        <div class="btn btn-small">
                                            <span>ເອກະສານແນບທີ4</span>
                                            <input type="file">
                                        </div>
                                        <div class="file-path-wrapper">
                                            <asp:FileUpload type="file" class="file-path validate" ID="txtReferDoc4" placeholder="ເອກະສານແນບທີ4" runat="server" onchange="LabelMe(this)" />
                                            <label id="txtReferDoc4Hidd" runat="server" style="font-size: large"></label>
                                            <input type="hidden" id="txtReferDoc4Hidd_I" runat="server" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col s12 m6 l6">
                                    <a class="btn btn-flat right" onclick="PreviewIMG(document.getElementById('<%: txtReferDoc4Hidd_I.ClientID %>').value)">
                                        <i class="material-icons">pageview</i>
                                    </a>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col s12 m6 l6">
                                    <div class="file-field input-field">
                                        <div class="btn btn-small">
                                            <span>ເອກະສານແນບທີ5</span>
                                            <input type="file">
                                        </div>
                                        <div class="file-path-wrapper">
                                            <asp:FileUpload type="file" class="file-path validate" ID="txtReferDoc5" placeholder="ເອກະສານແນບທີ5" runat="server" onchange="LabelMe(this)" />
                                            <label id="txtReferDoc5Hidd" runat="server" style="font-size: large"></label>
                                            <input type="hidden" id="txtReferDoc5Hidd_I" runat="server" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col s12 m6 l6">
                                    <a class="btn btn-flat right" onclick="PreviewIMG(document.getElementById('<%: txtReferDoc5Hidd_I.ClientID %>').value)">
                                        <i class="material-icons">pageview</i>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <hr />
                    </div>
                </div>
            </div>
            <div class="modal-footer laotxt">
                <div class="row">
                    <div class="col s12 m3 l3"></div>
                    <div class="col s12 m1 l1">
                        <asp:Button class="btn-small waves-effect waves-light laotxt" ID="btnSave" runat="server" OnClick="btnSave_Click" Text="ບັນທຶກ"></asp:Button>
                        <input type="hidden" id="btnState" runat="server" />
                        <input type="hidden" id="avartaUrl" runat="server" />
                    </div>
                    <div class="col s12 m1 l1">
                        <a class="btn-small waves-effect waves-light modal-close laotxt">ຍົກເລີກ</a>
                    </div>
                    <div class="col s12 m7 l7">
                        <asp:Button class="btn-small waves-effect waves-light right red darken-3 laotxt" ID="btnDel" runat="server" Text="ລົບ" OnClick="btnDel_Click"></asp:Button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- modal profile end --%>

    <%-- Customs JS --%>
    <script type="text/javascript">

        $(document).ready(function () {
            $('.tooltipped').tooltip();
            $('.modal').modal();
            $('.tabs').tabs();
            $('.datepicker').datepicker({
                format: 'mm/dd/yyyy'
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
        });

        function Search() {
            var txt = document.getElementById('<%: txtSearch.ClientID %>').value;
            var index = $('.card:contains("' + txt + '")').index();
            $('.card:not(:contains("' + txt + '"))').hide('slow');
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
                        document.getElementById("<%: txtID.ClientID %>").value = obj.id;
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
                        document.getElementById("<%: txtAvatarHidd.ClientID %>").innerText = obj.avatar_url;
                        document.getElementById("<%: profileImage.ClientID %>").src = obj.avatar_url.replace("~", "");
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
                        document.getElementById("<%: txtEducated_year.ClientID %>").value = obj.education_year;
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
            document.getElementById("<%: txtAvatarHidd.ClientID %>").innerText = "";
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
            document.getElementById("<%: txtID.ClientID %>").removeAttribute("disabled");
            M.updateTextFields();
        }
    </script>
    <%-- Customs JS --%>
</asp:Content>

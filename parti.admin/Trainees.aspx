<%@ Page Title="ຂໍ້ມູນຜູ້ຝຶກ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Trainees.aspx.cs" Inherits="parti.admin.Trainee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="scm" runat="server" EnablePageMethods="true" />
    <script src="Scripts/jquery.simpleLoadMore.min.js"></script>
    <link href="dist/css/dropify.css" rel="stylesheet" />
    <script src="dist/js/dropify.js"></script>

    <style>
        .table {
            font-family: PhetsarathOT;
        }

        .modal {
            font-family: PhetsarathOT;
        }

        .input-field {
            font-family: PhetsarathOT;
        }

        .dropify-wrapper {
            font-family: PhetsarathOT;
        }

        .dropify-clear {
            font-family: PhetsarathOT;
        }
    </style>
    <br />
    <br />
    <%-- Search Box --%>
    <div class="row">
        <div class="col s6 m6 l6 ">
            <div class="input-field">
                <label for="txtSearch">ຄົ້ນຫາ</label>
                <input id="txtSearch" runat="server" type="text" class="laotxt" />
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
            <a class="hvr-grow-shadow btn-floating blue tooltipped modal-trigger left z-depth-3" href="#modalTrainee" data-position="bottom" data-tooltip="ເພີ່ມ" onclick="SetTraineeInfo('-1')">
                <i class="material-icons">add</i>
            </a>
        </div>
    </div>
    <%-- Search Box --%>

    <%-- Total Trainer --%>
    <div class="row">
        <div class="col">
            <h5 class="grey-text darken-3">ຈຳນວນຜູ້ຝຶກອົບຮົມທັງຫມົດ:</h5>
        </div>
        <div class="col">
            <h5 class="red-text darken-3" id="lblTotalTrainer" runat="server">0</h5>
        </div>
    </div>
    <%-- Total Trainer --%>

    <%-- Table --%>
    <div class="row" id="tbTrainees">
        <div class="col s12 m8 l8">
            <table>
                <thead>
                    <tr>
                        <th>ລຳດັບ</th>
                        <th>ຮູບພາບ</th>
                        <th>ລະຫັດລັດຖະກອນ</th>
                        <th>ຊື່ເຕັມ</th>
                        <th>ບ່ອນປະຈຳການ</th>
                        <th>ແກ້ໄຂ</th>
                    </tr>
                </thead>
                <tbody id="tbBody" class="some-list" runat="server">
                </tbody>
            </table>
            <br>
            <br>
            <a href="#!" class="btn-flat waves-effect waves-light right tooltipped blue-text text-darken-3" data-position="right" data-tooltip="ກັບຂື້ນເທີງ" onclick="ScrollTop()">ກັບຂື້ນເທີງ</a>
        </div>
    </div>
    <%-- Table --%>

    <%-- Modal Trainee --%>
    <div id="modalTrainee" class="modal">
        <%-- <div class="modal-content">
            <h5>ຂໍ້ມູນຜູ້ຝຶກອົບຮົມ</h5>
            <div class="row">
                <div class="col s6">
                    <div class="row">
                        <div class="input-field col s12 m4 l4">
                            <label for="txtIDHid">ລະຫັດລັດຖະກອນ</label>
                            <input type="text" id="txtIDHid" runat="server" class="validate laotxt" required />
                        </div>
                        <div class="input-field col s12 m4 l4">
                            <label for="txtName">ຊື່</label>
                            <input type="text" id="txtName" runat="server" class="validate laotxt" required />
                        </div>
                        <div class="input-field col s12 m4 l4">
                            <label for="txtfaminame">ນາມສະກຸນ</label>
                            <input type="text" id="txtfaminame" runat="server" class="validate laotxt" required />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s12 m6 l6">
                            <label for="dtpBD">ວັນເດືອນປີເກີດ</label>
                            <input type="text" class="datepicker" runat="server" id="dtpBD" required>
                            <span class="helper-text" data-error="ສະເພາະວັນທີ." data-success="ວັນເດືອນປີເກີດ.">ວັນເດືອນປີເກີດ.</span>
                        </div>
                        <div class="input-field col s12 m6 l6">
                            <div class="custom-control custom-checkbox custom-control-inline">
                                <label>
                                    <input class="with-gap" type="radio" id="rdMale" runat="server" name="rdSex" checked><span>ຊາຍ</span></label>
                            </div>
                            <div class="custom-control custom-checkbox custom-control-inline">
                                <label>
                                    <input class="with-gap" type="radio" id="rdFamale" runat="server" name="rdSex"><span>ຍິງ</span></label>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s12 m6 l6">
                            <label for="txtworkPlace">ບ່ອນປະຈຳການ</label>
                            <input type="text" id="txtworkPlace" runat="server" class="validate laotxt" required="" />
                            <span class="helper-text">ຕົວຢ່າງ: ກະຊວງພາຍໃນ, ກົມຄຸ້ມຄອງລັດທະກອນ, ພະແນກບໍລິຫານ</span>
                        </div>
                        <div class="input-field col s12 m6 l6">
                            <label for="txtPosition">ຫນ້າທີ່ຮັບຜິດຊອບ</label>
                            <input type="text" id="txtPosition" runat="server" class="validate laotxt" required />
                            <span class="helper-text">ຕົວຢ່າງ: ຫົວຫນ້າກົມ, ຮອງກົມ, ວິຊາການ</span>
                        </div>
                    </div>
                </div>
                <div class="col s6">
                    <asp:FileUpload type="file" class="dropify" id="txtReferDoc" runat="server" data-max-file-size="3M"
                        data-allowed-file-extensions="jpg jpeg png pdf" />
                    <input type="hidden" id="txtReferDocHidd" runat="server" />
                    <a class="btn-flat waves-effect waves-light teal-text" onclick="PreviewIMG()" id="btnPreview">ເບີ່ງໄຟຣ...</a>
                    <br />
                    <p class="grey-text">ໄຟຣທີ່ໃຊ້ເປັນບ່ອນອ້າງອີງເຊັ່ນ: ໃບມະຕິແຕ່ງຕັ້ງ, ໃບຊິຫວະປະຫວັດ, ເອກະສານຕິດຄັດຕ່າງໆ.</p>
                    <p class="grey-text">ປະເພດໄຟຣທີ່ສາມາດແນບໄດ້: JPG, JPEG, PNG, PDF.</p>
                </div>
            </div>
        </div>--%>
        <%-- New Form --%>
        <div class="modal-content">
            <h5>ຂໍ້ມູນຜູ້ຝຶກອົບຮົມ</h5>
            <hr>
            <h6>1. ປະຫວັດສ່ວນຕົວ</h6>
            <div class="row">
                <div class="input-field col s12 m12 l12">
                    <label for="txtID">ລະຫັດລັດຖະກອນ</label>
                    <input type="text" id="txtID" runat="server" class="validate laotxt" required />
                </div>
            </div>
            <div class="row">
                <div class="input-field col s12 m6 l6">
                    <label for="txtNameLA">ຊື່ນາມສະກຸນ ພາສາລາວ</label>
                    <input type="text" id="txtNameLA" runat="server" class="validate laotxt" required />
                </div>
                <div class="input-field col s12 m6 l6">
                    <label for="txtNameEng">ຊື່ນາມສະກຸນ ພາສາອັງກິດ</label>
                    <input type="text" id="txtNameEng" runat="server" class="validate laotxt" required />
                </div>
            </div>
            <div class="row">
                <div class="col s12 m4 l4">
                    <label for="dtpBD">ວັນເດືອນປີເກີດ</label>
                    <input type="text" class="datepicker" runat="server" id="dtpBD" required>
                    <span class="helper-text" data-error="ສະເພາະວັນທີ." data-success="ວັນເດືອນປີເກີດ."></span>
                </div>
                <div class="input-field col s12 m2 l2">
                    <div class="custom-control custom-checkbox custom-control-inline">
                        <label>
                            <input class="with-gap" type="radio" id="rdMale" runat="server" name="rdSex" checked><span>ຊາຍ</span>
                        </label>
                    </div>
                    <div class="custom-control custom-checkbox custom-control-inline">
                        <label>
                            <input class="with-gap" type="radio" id="rdFamale" runat="server" name="rdSex"><span>ຍິງ</span>
                        </label>
                    </div>
                </div>
                <div class="input-field col s12 m4 l4">
                    <div>
                        <br />
                        <label>
                            <input class="with-gap" type="radio" id="rdMarried" runat="server" name="rdStatus" checked><span>ໂສດ</span>
                        </label>
                        <label>
                            <input class="with-gap" type="radio" id="rdSingle" runat="server" name="rdStatus"><span>ແຕ່ງງານ</span>
                        </label>
                        <label>
                            <input class="with-gap" type="radio" id="rdDivorce" runat="server" name="rdStatus"><span>ຍ່າຮ້າງ</span>
                        </label>
                    </div>
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
            <h6>2. ວຸດທິການສຶກສາ</h6>
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
                <div class="col s12 m4 l4">
                    <br />
                    <div>
                        <label>
                            <input class="with-gap" type="radio" id="rdEduIn" runat="server" name="rdEducation_country" checked><span>ຈົບຈາກພາຍໃນ</span>
                        </label>
                        <label>
                            <input class="with-gap" type="radio" id="rdEduOut" runat="server" name="rdEducation_country"><span>ຈົບຈາກຕ່າງປະເທດ</span>
                        </label>
                    </div>
                </div>
                <div class="input-field col s12 m4 l4">
                    <label for="txtEducation_Name">ຊື່ສະຖານສຶກສາ</label>
                    <input type="text" id="txtEducation_Name" runat="server" class="validate laotxt" required />
                </div>
                <div class="input-field col s12 m4 l4">
                    <label for="txtEducated_year">ສົກປີຮຽນຈົບ</label>
                    <input type="text" id="txtEducated_year" runat="server" class="validate laotxt" required />
                </div>
            </div>
            <h6>3. ບ່ອນປະຈຳການປະຈຸບັນ</h6>
            <div class="row">
                <div class="input-field col s12 m4 l4">
                    <label for="txtWork_place">ກະຊວງ/ແຂວງ/ເມືອງ</label>
                    <input type="text" id="txtWork_place" runat="server" class="validate laotxt" required />
                </div>
                <div class="input-field col s12 m4 l4">
                    <label for="txtDepartment">ກົມ/ພະແນກ/ຫ້ອງການ</label>
                    <input type="text" id="txtDepartment" runat="server" class="validate laotxt" required />
                </div>
                <div class="input-field col s12 m4 l4">
                    <label for="txtPosition">ຕຳແໜ່ງ</label>
                    <input type="text" id="txtPosition" runat="server" class="validate laotxt" required />
                </div>
            </div>
            <div class="row">
                <div class="input-field col s12 m3 l3">
                    <label for="txtDate_of_govermented">ວັນສັງກັດລັດ</label>
                    <input class="datepicker" type="text" id="txtDate_of_govermented" runat="server" class="validate laotxt" required />
                </div>
                <div class="input-field col s12 m3 l3">
                    <label for="txtOffice_tel">ເບີໂທຫ້ອງການ</label>
                    <input type="text" id="txtOffice_tel" runat="server" class="validate laotxt" required />
                </div>
                <div class="input-field col s12 m3 l3">
                    <label for="txtMobile_tel">ເບີມືຖື</label>
                    <input type="text" id="txtMobile_tel" runat="server" class="validate laotxt" required />
                </div>
                <div class="input-field col s12 m3 l3">
                    <label for="txtEmail">ອີເມວ</label>
                    <input type="text" id="txtEmail" runat="server" class="validate laotxt" required />
                </div>
            </div>
            <h6>4. ການຈັດຕັ້ງທີ່ອານຸມັດ (ຜູ້ທີ່ຕົກລົງໃຫ້ເຂົ້າຮ່ວມຝຶກອົບຮົມ)</h6>
            <div class="row">
                <div class="input-field col s12 m6 l6">
                    <label for="txtAppr_Fullname">ຊື່ ແລະ ນາມສະກຸນ</label>
                    <input type="text" id="txtAppr_Fullname" runat="server" class="validate laotxt" required />
                </div>
                <div class="input-field col s12 m6 l6">
                    <label for="txtAppr_Relationship_trainee">ສາຍພົວພັນກັບຜູ້ສະໝັກ</label>
                    <input type="text" id="txtAppr_Relationship_trainee" runat="server" class="validate laotxt" required />
                </div>
            </div>
            <div class="row">
                <div class="input-field col s12 m4 l4">
                    <label for="txtAppr_Position_name">ຕຳແໜ່ງ</label>
                    <input type="text" id="txtAppr_Position_name" runat="server" class="validate laotxt" required />
                </div>
                <div class="input-field col s12 m4 l4">
                    <label for="txtAppr_Position_major">ໜ້າທີ່ຮັບຜິດຊອບຊີ້ນຳ</label>
                    <input type="text" id="txtAppr_Position_major" runat="server" class="validate laotxt" required />
                </div>
                <div class="input-field col s12 m4 l4">
                    <label for="txtAppr_Office_name">ຊື່ສຳນັກງານ</label>
                    <input type="text" id="txtAppr_Office_name" runat="server" class="validate laotxt" required />
                </div>
            </div>
            <div class="row">
                <div class="input-field col s12 m4 l4">
                    <label for="txtAppr_Office_tel">ເບີໂທຫ້ອງການ</label>
                    <input type="text" id="txtAppr_Office_tel" runat="server" class="validate laotxt" required />
                </div>
                <div class="input-field col s12 m4 l4">
                    <label for="txtAppr_Mobile_tel">ເບີມືຖື</label>
                    <input type="text" id="txtAppr_Mobile_tel" runat="server" class="validate laotxt" required />
                </div>
                <div class="input-field col s12 m4 l4">
                    <label for="txtAppr_Email">ອີເມວ</label>
                    <input type="text" id="txtAppr_Email" runat="server" class="validate laotxt" required />
                </div>
            </div>
            <h6>5. ການຈັດການຟຣາຍເອກະສານແນບເຂົ້າໃນລະບົບ</h6>
            <div class="file-field input-field">
                <div class="btn-small">
                    <span>File</span>
                    <input type="file">
                </div>
                <div class="file-path-wrapper">
                    <asp:FileUpload type="file" class="file-path validate" ID="txtAvatar" placeholder="ຮູບພາບຂອງຜູ້ຝຶກອົບຮົມ" runat="server" />
                    <input type="hidden" id="txtAvatarHidd" runat="server" />
                </div>
            </div>
            <div class="file-field input-field">
                <div class="btn-small">
                    <span>File</span>
                    <input type="file">
                </div>
                <div class="file-path-wrapper">
                    <asp:FileUpload type="file" class="file-path validate" ID="txtReferDoc1" placeholder="ເອກະສານແນບທີ1" runat="server" />
                    <input type="hidden" id="txtReferDoc1Hidd" runat="server" />
                </div>
            </div>
            <div class="file-field input-field">
                <div class="btn-small">
                    <span>File</span>
                    <input type="file">
                </div>
                <div class="file-path-wrapper">
                    <asp:FileUpload type="file" class="file-path validate" ID="txtReferDoc2" placeholder="ເອກະສານແນບທີ2" runat="server" />
                    <input type="hidden" id="txtReferDoc2Hidd" runat="server" />
                </div>
            </div>
            <div class="file-field input-field">
                <div class="btn-small">
                    <span>File</span>
                    <input type="file">
                </div>
                <div class="file-path-wrapper">
                    <asp:FileUpload type="file" class="file-path validate" ID="txtReferDoc3" placeholder="ເອກະສານແນບທີ3" runat="server" />
                    <input type="hidden" id="txtReferDoc3Hidd" runat="server" />
                </div>
            </div>
            <div class="file-field input-field">
                <div class="btn-small">
                    <span>File</span>
                    <input type="file">
                </div>
                <div class="file-path-wrapper">
                    <asp:FileUpload type="file" class="file-path validate" ID="txtReferDoc4" placeholder="ເອກະສານແນບທີ4" runat="server" />
                    <input type="hidden" id="txtReferDoc4Hidd" runat="server" />
                </div>
            </div>
            <div class="file-field input-field">
                <div class="btn-small">
                    <span>File</span>
                    <input type="file">
                </div>
                <div class="file-path-wrapper">
                    <asp:FileUpload type="file" class="file-path validate" ID="txtReferDoc5" placeholder="ເອກະສານແນບທີ5" runat="server" />
                    <input type="hidden" id="txtReferDoc5Hidd" runat="server" />
                </div>
            </div>
        </div>
        <br />
        <%-- New Form --%>
        <div class="modal-footer">
            <asp:Button class="waves-effect waves-green btn-small" ID="btnSave" runat="server" OnClick="btnSave_OnClick" Text="ບັນທຶກ"></asp:Button>
            <asp:Button class="waves-effect waves-green btn-small red" ID="btnDel" runat="server" OnClick="btnDel_OnClick" Text="ລົບ"></asp:Button>
            <button type="button" class="waves-effect waves-green btn-small modal-close laotxt">ຍົກເລີກ</button>
            <input type="hidden" id="btnState" runat="server" />
        </div>
    </div>
    <%-- Modal Trainee --%>

    <%-- JS --%>
    <script type="text/javascript">
        function PreviewIMG(file) {
            if (file != '') {
                window.open(file);
            } else {
                swalToast('info', 'e1: ບໍ່ມີໄຟຣທີ່ຈະສະແດງ...');
            }
        }

        $(document).ready(function () {
            $('.tooltipped').tooltip();
            $('.tabs').tabs();
            $('.datepicker').datepicker({
                format: 'mm/dd/yyyy'
            });
            $('.some-list').simpleLoadMore({
                item: 'tr',
                count: 5,
                btnHTML: '<br><br><a href="#" id="btnMore" class="load-more_btn btn-flat waves-effect tooltipped blue-text text-darken-3" data-position="left" data-tooltip="ເບີ່ງສ່ວນທີ່ເຫລືອ" onclick="ScrollDown()">ເບີ່ງສ່ວນທີ່ເຫລືອ...</a>'
            });
            $('.materialboxed').materialbox();
        });

        function ScrollDown() {
            $('html,body').animate({ scrollTop: 9999 }, 'slow');
        }

        function ScrollTop() {
            $('html,body').animate({ scrollTop: 0 }, 'slow');
        }

        function Search() {
            var txt = document.getElementById('<%: txtSearch.ClientID %>').value;
            $('.search_result:not(:contains("' + txt + '"))').hide("slow");
            $('.search_result:contains("' + txt + '")').show("slow");
            if (txt == '') {
                window.location.reload();
            }
        }

        function SetTraineeInfo(id) {
            var traineeID = id;
            if (traineeID == "-1") {
                ClearTxT();
                document.getElementById("<%: btnState.ClientID %>").value = "add";
            } else {
                document.getElementById("<%: btnState.ClientID %>").value = "edit";
                $.ajax({
                    type: "POST",
                    url: "<%: ResolveUrl("Trainees.aspx/GetTraineeInfo") %>",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{TraineeID:" + traineeID + "}",
                    success: function (response) {
                        var obj = response.d;
                        document.getElementById("<%: txtID.ClientID %>").value = obj.id;
                        document.getElementById("<%: txtNameLA.ClientID %>").value = obj.fullname_la;
                        document.getElementById("<%: txtNameEng.ClientID %>").value = obj.fullname_eng;
                        document.getElementById("<%: dtpBD.ClientID %>").value = obj.date_of_birth;
                        if (obj.sex === "m") {
                            document.getElementById("<%: rdMale.ClientID %>").setAttribute("checked", "checked");
                        } else if (obj.sex === "f") {
                            document.getElementById("<%: rdFamale.ClientID %>").setAttribute("checked", "checked");
                        }
                        if (obj.status === "") {
                            document.getElementById("<%: rdSingle.ClientID %>").setAttribute("checked", "checked");
                        } else if (obj.status === "") {
                            document.getElementById("<%: rdDivorce.ClientID %>").setAttribute("checked", "checked");
                        } else if (obj.status === "") {
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
                        document.getElementById("<%: txtAvatar.ClientID %>").value = obj.avatar_url;
                        document.getElementById("<%: txtReferDoc1Hidd.ClientID %>").value = obj.doc1_url;
                        document.getElementById("<%: txtReferDoc2Hidd.ClientID %>").value = obj.doc2_url;
                        document.getElementById("<%: txtReferDoc3Hidd.ClientID %>").value = obj.doc3_url;
                        document.getElementById("<%: txtReferDoc4Hidd.ClientID %>").value = obj.doc4_url;
                        document.getElementById("<%: txtReferDoc5Hidd.ClientID %>").value = obj.doc5_url;
                        document.getElementById("<%: txtAppr_Fullname.ClientID %>").value = obj.appr_fullname;
                        document.getElementById("<%: txtAppr_Position_name.ClientID %>").value = obj.appr_position_name;
                        document.getElementById("<%: txtAppr_Position_major.ClientID %>").value = obj.appr_position_major;
                        document.getElementById("<%: txtAppr_Relationship_trainee.ClientID %>").value = obj.appr_relationship_trainee;
                        document.getElementById("<%: txtAppr_Office_name.ClientID %>").value = obj.appr_office_name;
                        document.getElementById("<%: txtAppr_Office_tel.ClientID %>").value = obj.appr_office_tel;
                        document.getElementById("<%: txtAppr_Mobile_tel.ClientID %>").value = obj.appr_mobile_tel;
                        document.getElementById("<%: txtAppr_Email.ClientID %>").value = obj.appr_email;
                        document.getElementById("<%: txtEducation_level.ClientID %>").value = obj.education_level;
                        document.getElementById("<%: txtEducation_major.ClientID %>").value = obj.education_major;
                        if (education_country === "") {

                        } else if (education_country === "") {

                        }



                        M.updateTextFields();
                    },
                    failure: function (response) {
                        alert(response.d);
                    }
                });
            }
            CheckBtnPreview();
        }

        function ClearTxT() {
            document.getElementById("<%: txtID.ClientID %>").value = "";
            document.getElementById("<%: txtNameLA.ClientID %>").value = "";
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
            document.getElementById("<%: txtAvatar.ClientID %>").value = "";
            document.getElementById("<%: txtReferDoc1Hidd.ClientID %>").value = "";
            document.getElementById("<%: txtReferDoc2Hidd.ClientID %>").value = "";
            document.getElementById("<%: txtReferDoc3Hidd.ClientID %>").value = "";
            document.getElementById("<%: txtReferDoc4Hidd.ClientID %>").value = "";
            document.getElementById("<%: txtReferDoc5Hidd.ClientID %>").value = "";
            document.getElementById("<%: txtAppr_Fullname.ClientID %>").value = "";
            document.getElementById("<%: txtAppr_Position_name.ClientID %>").value = "";
            document.getElementById("<%: txtAppr_Position_major.ClientID %>").value = "";
            document.getElementById("<%: txtAppr_Relationship_trainee.ClientID %>").value = "";
            document.getElementById("<%: txtAppr_Office_name.ClientID %>").value = "";
            document.getElementById("<%: txtAppr_Office_tel.ClientID %>").value = "";
            document.getElementById("<%: txtAppr_Mobile_tel.ClientID %>").value = "";
            document.getElementById("<%: txtAppr_Email.ClientID %>").value = "";
            document.getElementById("<%: txtEducation_level.ClientID %>").value = "";
            document.getElementById("<%: txtEducation_major.ClientID %>").value = "";
            M.updateTextFields();
        }

        function CheckBtnPreview() {
            var state = document.getElementById("<%: btnState.ClientID %>").value;
            if (state == 'add') {
                $('#btnPreview').addClass('disabled');
            } else if (state == 'edit') {
                $('#btnPreview').removeClass('disabled');
            }
        }

        function UUID() {
            var dt = new Date().getTime();
            var uuid = 'xxxxxxxx-xxxx-8xxx-Qxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
                var r = (dt + Math.random() * 16) % 16 | 0;
                dt = Math.floor(dt / 16);
                return (c == 'x' ? r : (r & 0x3 | 0x8)).toString(16);
            });
            return uuid;
        }

    </script>
    <%-- JS --%>
</asp:Content>

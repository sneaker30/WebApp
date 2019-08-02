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
        <div class="modal-content">
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
        </div>
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
        function PreviewIMG() {
            var file = document.getElementById("<%: txtReferDocHidd.ClientID %>").value;
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
            $('.dropify').dropify({
                messages: {
                    'default': 'ກົດໃສ່ນີ້ ຫລື ຫລາກໄຟຣມາວ່າງໃສ່ບ່ອນນີ້',
                    'replace': 'ກົດໃສ່ນີ້ ຫລື ຫລາກໄຟຣມາວ່າງໃສ່ບ່ອນນີ້ ເພື່ອປ່ຽນໄຟຣ',
                    'remove': 'ລົບ',
                    'error': 'ເກີດຂໍ້ຜິດພາດກະລຸນາລອງໃຫມ່.'
                },
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
                document.getElementById("<%: txtIDHid.ClientID %>").value = UUID();
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
                        document.getElementById("<%: txtIDHid.ClientID %>").value = obj.id;
                        document.getElementById("<%: txtName.ClientID %>").value = obj.name;
                        document.getElementById("<%: txtfaminame.ClientID %>").value = obj.faminame;
                        document.getElementById("<%: dtpBD.ClientID %>").value = obj.date_of_birth;
                        document.getElementById("<%: txtworkPlace.ClientID %>").value = obj.work_place;
                        document.getElementById("<%: txtPosition.ClientID %>").value = obj.position;
                        if (obj.sex == "m") {
                            document.getElementById("<%: rdMale.ClientID %>").setAttribute("checked", "checked");
                        } else if (obj.sex == "f") {
                            document.getElementById("<%: rdFamale.ClientID %>").setAttribute("checked", "checked");
                        }
                        document.getElementById("<%: txtReferDocHidd.ClientID %>").value = obj.doc_url;
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
            document.getElementById("<%: txtIDHid.ClientID %>").value = "";
            document.getElementById("<%: txtName.ClientID %>").value = "";
            document.getElementById("<%: txtfaminame.ClientID %>").value = "";
            document.getElementById("<%: dtpBD.ClientID %>").value = "";
            document.getElementById("<%: txtworkPlace.ClientID %>").value = "";
            document.getElementById("<%: txtPosition.ClientID %>").value = "";
            document.getElementById("<%: txtReferDocHidd.ClientID %>").value = "";
            document.getElementById("<%: txtReferDoc.ClientID %>").value = "";
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

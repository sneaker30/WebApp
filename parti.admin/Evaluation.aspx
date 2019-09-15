<%@ Page Title="ສ້າງການປະເມີນ/ແບບສອບຖາມ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Evaluation.aspx.cs" Inherits="parti.admin.Evaluation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="scmEvaluation" runat="server" EnablePageMethods="true" />
    <link rel="stylesheet" href="https://unpkg.com/materialize-stepper@3.1.0/dist/css/mstepper.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.2/css/all.css">
    <script src="https://unpkg.com/materialize-stepper@3.1.0/dist/js/mstepper.min.js"></script>
    <script src="Scripts/customs/qrcode.js"></script>

    <style>
        input {
            font-family: PhetsarathOT;
        }

        textarea {
            font-family: PhetsarathOT;
        }

        button {
            font-family: PhetsarathOT;
        }
    </style>
    <%-- Search --%>
    <br />
    <br />
    <div class="row">
        <div class="col s6 m6 l6 ">
            <div class="input-field">
                <label for="txtSearch">ຄົ້ນຫາ</label>
                <input id="txtSearch" runat="server" type="text" class="laotxt autocomplete" autocomplete="off" />
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
            <a class="hvr-grow-shadow btn-floating blue tooltipped left z-depth-3" data-position="bottom" data-tooltip="ເພີ່ມ" onclick="AddEva()">
                <i class="material-icons">add</i>
            </a>
        </div>
    </div>
    <%-- Evaluation List --%>
    <div class="row">
        <table>
            <thead>
                <tr>
                    <th class="col s1 m1 l1">ລ/ດ</th>
                    <th class="col s2 m2 l2">ລະຫັດການຝຶກອົບຮົມ</th>
                    <th class="col s4 m4 l4">ຫົວຂໍ້ການຝຶກອົບຮົມ</th>
                    <th class="col s2 m2 l2">ປະເພດຂອງແບບສອບຖາມ</th>
                    <th class="col s3 m3 l3"></th>
                </tr>
            </thead>
            <tbody id="tbody" runat="server">
            </tbody>
        </table>
    </div>
    <br />
    <br />
    <%-- Title --%>
    <div class="row" id="EvaluationTitle">
        <h5>ແບບຟອມສອບຖາມແລະປະເມີນ</h5>
        <hr />
        <br />
        <div class="row">
            <h6>ຫົວຂໍ້</h6>
            <div class="input-field col s12 m8 l8">
                <input id="txtTitle" type="text" placeholder="ຫົວຂໍ້ການຝຶກອົບຮົມ" class="autocomplete" autocomplete="off" onkeyup="GetAutocompleteTrainingIdName('', this.value)" />
                <span class="helper-text">ຫມາຍເຫດ: ຫົວຂໍ້ການຝຶກອົບຮົມນີ້ຕ້ອງກົງກັບ ຫົວຂໍ້ການຈັດຝຶກອົບຮົມໃນເມນູ "ການຈັດຝຶກອົບຮົມ"</span>
            </div>
            <div class="input-field col s12 m4 l4"></div>
            <div class="input-field col s12 m8 l8">
                <input id="txtTrainingID" type="text" placeholder="ລະຫັດການຝຶກອົບຮົມ" class="autocomplete" autocomplete="off" />
                <span class="helper-text">ຫມາຍເຫດ: ລະຫັດນີ້ຕ້ອງກົງກັບ ລະຫັດຂອງການຈັດຝຶກອົບຮົມໃນເມນູ "ການຈັດຝຶກອົບຮົມ"</span>
            </div>
            <div class="input-field col s12 m4 l4"></div>
        </div>
        <div class="row">
            <div class="col s12 m8 l8">
                <span class="grey-text">ປະເພດ:</span>
                <label>
                    <input class="with-gap" type="radio" id="rdBefore" name="rdQType" value="b" /><span>ຄຳຖາມກ່ອນຝຶກ</span>
                </label>
                <label>
                    <input class="with-gap" type="radio" id="rdAfter" name="rdQType" value="a" /><span>ຄຳຖາມຫຼັງຝຶກ</span>
                </label>
            </div>
            <div class="input-field col s12 m4 l4"></div>
            <input type="hidden" id="txtT_ID" />
            <input type="hidden" id="txtAction" />
        </div>
        <br />
        <br />
        <div class="row">
            <div class="col">
                <a class="btn waves-effect blue-grey lighten-2 z-depth-3" id="btnAddT" onclick="q_title_tb(this.name)">ບັນທຶກ
                <i class="material-icons right">save</i>
                </a>
            </div>
            <div class="col">
                <a class="btn waves-effect blue-grey lighten-2 z-depth-3" id="btnDelT" onclick="q_title_tb('del')">ລົບ
                <i class="material-icons right">delete</i>
                </a>
            </div>
        </div>
    </div>
    <%-- Stepper --%>
    <div class="row" id="EvaluationStep">
        <hr />
        <br />
        <h6>ເຄື່ອງມື</h6>
        <br />
        <div class="row">
            <div class="col">
                <a class="btn waves-effect blue-grey lighten-2 z-depth-3" id="btnAddQ">ເພີ່ມຄຳຖາມ
        <i class="material-icons right">add</i>
                </a>
            </div>
            <div class="col">
                <a class="btn waves-effect blue-grey lighten-2 z-depth-3" id="btnDelQ">ລຸດຄຳຖາມ
        <i class="material-icons right">delete</i>
                </a>
            </div>
            <div class="col">
                <a class="btn waves-effect right z-depth-3" id="btnFinish" onclick="Search()">ສຳເລັດ</a>
            </div>
        </div>
        <div class="row">
            <div class="input-field col">
                <select id="selAnOption">
                    <option value="1">ອັດຕະໄນ</option>
                    <option value="2">ປາລະໄນ</option>
                </select>
            </div>
            <div class="input-field col">
                <input placeholder="ເພີ່ມຕົວເລືອກຄຳຕອບ" id="txtAn" type="text" class="validate">
            </div>
            <div class="switch col" id="AnTrueOrFalse">
                <br />
                <label>
                    ຜິດ
                    <input type="checkbox" id="swAnTrueOrFalse" />
                    <span class="lever"></span>
                    ຖືກ
                </label>
            </div>
            <div class="col">
                <br />
                <a class="btn waves-effect blue-grey lighten-2 z-depth-3" id="btnAddAn">ເພີ່ມຕົວເລືອກຄຳຕອບ
        <i class="material-icons right">add</i>
                </a>
            </div>
            <div class="col">
                <br />
                <a class="btn waves-effect blue-grey lighten-2 z-depth-3" id="btnDelAn">ລຸດຕົວເລືອກຄຳຕອບ
        <i class="material-icons right">delete</i>
                </a>
            </div>
        </div>
        <hr />
        <br />
        <h6>ຂັ້ນຕອນສ້າງແບບຟອມ</h6>
        <div class="row">
            <ul id="stepperQ" class="stepper horizontal">
                <li class="step" id="step0">
                    <div class="step-title waves-effect"></div>
                    <div class="step-content">
                        <div class="row">
                            <div class="input-field col s10 m10 l10">
                                <textarea id="txtQ0" type="text" class="materialize-textarea validate"></textarea>
                                <label for="txtQ0">ຄຳຖາມ</label>
                            </div>
                            <div class="col s2 m2 l2">
                                <br />
                                <a class="btn-small waves-effect blue-grey lighten-2 laotxt z-depth-3" id="btnSaveQ0" onclick="SaveQ()">ບັນທຶກ
                                </a>
                            </div>
                        </div>
                        <br />
                        <br />
                        <br />
                        <input type="hidden" id="txtAnStatus0" value="empty" />
                        <div class="row" id="row_step0">
                        </div>
                        <div class="step-actions">
                            <a class="waves-effect btn btn-small next-step laotxt z-depth-3">ຕໍ່ໄປ</a>
                            <a class="waves-effect btn btn-small previous-step laotxt z-depth-3">ກັບຄືນ</a>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>

    <script>
        var itemNames = {};
        var itemID = {};
        var itemSearch = {};
        var stepperInstace;
        var swCorrect = false;

        function GenLink(t_id, index) {
            var url = SetEvaluationTraining(t_id, index);
            window.open(url, '_blank');
        }

        function GenQRCode(t_id, index) {
            Swal.fire({
                title: 'QR Code',
                html: '<div id="qrcode" align="center"></div>',
                onOpen: () => {
                    var url = SetEvaluationTraining(t_id, index);
                    var qrcode = new QRCode(document.getElementById("qrcode"), {
                        text: url,
                        colorDark: "#000000",
                        colorLight: "#ffffff",
                        correctLevel: QRCode.CorrectLevel.H
                    });
                }
            });
        }

        function SetEvaluationTraining(t_id, index) {
            var result = null;
            $.ajax({
                async: false,
                type: "POST",
                url: "<%: ResolveUrl("Evaluation.aspx/SetEvaluationTraining") %>",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{t_id:'" + t_id + "', index:'" + index + "'}",
                success: function (response) {
                    var obj = response.d;
                    result = obj;
                },
                failure: function (response) {
                    swalModal('error', response.d, '');
                }
            });
            return result;
        }

        function ClearTxT() {
            document.getElementById('txtTitle').value = '';
            document.getElementById('txtTrainingID').value = '';
            document.getElementById('txtAn').value = '';
            var active_index = $('.step').length;
            stepperInstace.openStep(active_index - 1);
            $('#btnDelT').hide();
            for (i = 0; i < active_index; i++) {
                var currentStep = stepperInstace.getSteps();//fix
                if (active_index >= 1) {
                    stepperInstace.deactivateStep(currentStep.active.step);
                    stepperInstace.openStep(active_index - 1);
                }
                var rdoChecked = $("div[id^='row_step']");
                rdoChecked.empty();
            }

            i = 0;
            r = 0;
        }

        function GetQInfo(index, t_id) {
            document.getElementById('btnAddT').name = 'edit';
            document.getElementById('txtAction').value = document.getElementById('btnAddT').name;
            action = document.getElementById('txtAction').value;
            $('#EvaluationTitle').show('500');
            $('#EvaluationStep').show('500');
            $([document.documentElement, document.body]).animate(
                {
                    scrollTop: $("#EvaluationTitle").offset().top
                },
                1000
            );

            GetQTitleID(index);
            GetQQuestionID(t_id);
        }

        function GetQTitleID(id) {
            $.ajax({
                type: "POST",
                url: "<%: ResolveUrl("Evaluation.aspx/GetQTitleID") %>",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{index:" + id + "}",
                success: function (response) {
                    var obj = response.d;
                    document.getElementById('txtTitle').value = obj.title_name;
                    document.getElementById('txtTrainingID').value = obj.training_id;
                    document.getElementById('txtT_ID').value = obj.t_id;
                    if (obj.q_type === 'a') {
                        $('#rdAfter').prop('checked', true);
                        $('#rdBefore').prop('checked', false);
                    } else if (obj.q_type === 'b') {
                        $('#rdAfter').prop('checked', false);
                        $('#rdBefore').prop('checked', true);
                    }
                    document.getElementById('txtAction').value = 'edit';
                    $('#btnDelT').show();
                },
                failure: function (response) {
                    swalModal('error', response.d, '');
                }
            });
        }

        function AddEva() {
            $('#EvaluationTitle').show('500');
            $([document.documentElement, document.body]).animate(
                {
                    scrollTop: $("#EvaluationTitle").offset().top
                },
                1000
            );
            document.getElementById('btnAddT').name = 'add';
            document.getElementById('txtAction').value = document.getElementById('btnAddT').name;
            action = document.getElementById('txtAction').value;
            ClearTxT();
        }

        function Search() {
            $('#EvaluationTitle').hide();
            $('#EvaluationStep').hide();
            var txt = document.getElementById('<%: txtSearch.ClientID %>').value;
            $('.evalist:not(:contains("' + txt + '"))').hide('500');
            $('.evalist:contains("' + txt + '")').show('500');
            ClearTxT();
            ScrUp();
        }

        function q_answers_tb(action, a_id, answer_text, q_id, t_id, status) {
            var eCode;
            $.ajax({
                async: false,
                type: "POST",
                url: "<%: ResolveUrl("Evaluation.aspx/EditQAnswers") %>",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{action:'" + action + "', a_id:'" + a_id + "', answer_text:'" + answer_text + "', q_id:'" + q_id + "', t_id:'" + t_id + "', status:'" + status + "'}",
                success: function (response) {
                    eCode = response.d;
                },
                failure: function (response) {
                    eCode = response.d;
                }
            });
            return eCode;
        }

        function SaveQ() {
            var currentStep = stepperInstace.getSteps();
            var index = currentStep.active.step.id;//fix substring from ID
            index = index.replace('step', '');
            var t_id = document.getElementById("txtT_ID").value;
            var txtQ = document.getElementById("txtQ" + index).value;

            if (t_id !== '' && txtQ !== '') {
                var result = q_questions_tb('add', 'txtQ' + index, txtQ, t_id);
                //alert(result);
                if (result !== 'e5') {
                    swalToast('warning', result);
                } else {
                    swalToast('success', 'ບັນທຶກສຳເລັດ!');
                }
            } else {
                swalToast('warning', 'ກະລຸນາໃສ່ເນື້ອໃນຄຳຖາມ!');
                $('#txtQ' + index).focus();
            }
        }

        function q_questions_tb(action, q_id, question_text, t_id) {
            var eCode;
            $.ajax({
                async: false,
                type: "POST",
                url: "<%: ResolveUrl("Evaluation.aspx/EditQQuestions") %>",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{action:'" + action + "', q_id:'" + q_id + "', question_text:'" + question_text + "', t_id:'" + t_id + "'}",
                success: function (response) {
                    eCode = response.d;
                },
                failure: function (response) {
                    eCode = response.d;
                }
            });
            return eCode;
        }

        function q_title_tb(action) {
            if (action === 'add') {
                document.getElementById('txtT_ID').value = UUID();
            }
            var t_id = document.getElementById('txtT_ID').value;
            document.getElementById('txtAction').value = action;
            var title_name = document.getElementById('txtTitle').value;
            var training_id = document.getElementById('txtTrainingID').value;
            var created_date = GetDate();
            var rdoChecked = $("input[name='rdQType']:checked").val();

            if (action === 'add' || action === 'edit') {
                if (title_name !== '' || training_id !== '') {
                    $('#EvaluationStep').show('500');
                    $([document.documentElement, document.body]).animate(
                        {
                            scrollTop: $("#stepperQ").offset().top
                        },
                        1000
                    );
                    $.ajax({
                        type: "POST",
                        url: "<%: ResolveUrl("Evaluation.aspx/EditQTitle") %>",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{action:'" +
                            action +
                            "', t_id:'" +
                            t_id +
                            "', title_name:'" +
                            title_name +
                            "', training_id:'" +
                            training_id +
                            "', created_date:'" +
                            created_date +
                            "', q_type:'" +
                            rdoChecked + "'}",
                        success: function (response) {
                        },
                        failure: function (response) {
                            swalModal('error', response.d, '');
                        }
                    });
                } else {
                    swalToast('warning', 'ກະລຸນາໃສ່ຫົວຂໍ້ການຝຶກອົບຮົມ');
                    $('#txtTitle').focus();
                }
            }
            if (action === 'del') {
                Swal.fire({
                    title: 'Are you sure?',
                    text: "ຕ້ອງການລົບແບບຟອມນີ້ແທ້ຫຼືບໍ່?",
                    type: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'ລົບ',
                    cancelButtonText: 'ຍົກເລີກ'
                }).then(result => {
                    if (result.value) {
                        $.ajax({
                            type: "POST",
                            url: "<%: ResolveUrl("Evaluation.aspx/EditQTitle") %>",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            data: "{action:'" +
                                action +
                                "', t_id:'" +
                                t_id +
                                "', title_name:'" +
                                title_name +
                                "', training_id:'" +
                                training_id +
                                "', created_date:'" +
                                created_date +
                                "', q_type:'" +
                                rdoChecked + "'}",
                            success: function (response) {
                                swalModal('success', 'e5:ຈັດການຂໍ້ມູນສຳເລັດ', 'Evaluation');
                            },
                            failure: function (response) {
                                swalModal('error', response.d, '');
                            }
                        });
                    }
                });
            }
        }

        function GetDate() {
            var today = new Date();
            var dd = today.getDate();
            var mm = today.getMonth() + 1;
            var yyyy = today.getFullYear();
            if (dd < 10) {
                dd = '0' + dd;
            }
            if (mm < 10) {
                mm = '0' + mm;
            }
            today = yyyy + '-' + mm + '-' + dd;
            return today;
        }

        function UUID() {
            var dt = new Date().getTime();
            var uuid = 'xx-3xxx-xxxx'.replace(/[xy]/g, function (c) {
                var r = (dt + Math.random() * 16) % 16 | 0;
                dt = Math.floor(dt / 16);
                return (c == 'x' ? r : (r & 0x3 | 0x8)).toString(16);
            });
            return uuid;
        }

        var action;

        $(document).ready(function () {
            var stepper = document.querySelector(".stepper");
            stepperInstace = new MStepper(stepper);
            $(".tooltipped").tooltip();
            $(".modal").modal();
            $(".datepicker").datepicker({
                format: "yyyy-mm-dd"
            });
            $("select").formSelect();
            $("#txtAn").hide();
            $('#EvaluationTitle').hide();
            $('#EvaluationStep').hide();
            $("#AnTrueOrFalse").hide();
            document.getElementById('btnAddT').name = 'add';
            document.getElementById('txtAction').value = document.getElementById('btnAddT').name;
            action = document.getElementById('txtAction').value;
            if (action === 'add') {
                $('#btnDelT').hide();
            } else if (action === 'edit') {
                $('#btnDelT').show();
            }
        });

        function GetQAnswerID(id, q_id) {
            $.ajax({
                type: "POST",
                url: "<%: ResolveUrl("Evaluation.aspx/GetQAnswerID") %>",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{t_id:'" + id + "', q_id:'" + q_id + "'}",
                success: function (response) {
                    var obj = response.d;
                    var a_i;
                    var q_i;
                    var txtAn;
                    var row;
                    var rdo;
                    var element;
                    $.each(obj,
                        function (key, vl) {
                            a_i = vl.a_id.substring(5, 6);
                            q_i = vl.q_id.substring(4, 5);
                            txtAn = 'An_' + q_i + '_' + a_i;
                            row = "row_step" + q_i;
                            rdo = "rdo" + txtAn;
                            element = "<div class='col' id='" + txtAn + "'><label><input id='" + rdo +
                                "' name='group" + q_i + "' type='radio' class='with-gap' value='" + txtAn +
                                "'><span id='rdoAnText_" + q_i + "_" + a_i + "'>" + vl.answer_text + "</span></label></div>";
                            var row_step = document.getElementById(row);
                            if (row_step) {
                                row_step.insertAdjacentHTML("beforeend", element);
                            }
                        });
                },
                failure: function (response) {
                    swalModal('error', response.d, '');
                }
            });
        }

        function GetQQuestionID(id) {
            $.ajax({
                type: "POST",
                url: "<%: ResolveUrl("Evaluation.aspx/GetQQuestionID") %>",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{t_id:'" + id + "'}",
                success: function (response) {
                    var obj = response.d;
                    $.each(obj,
                        function (key, vl) {
                            var i = vl.q_id;
                            i = i.substring(4, 5);
                            var txtQ = document.getElementById("txtQ" + i);
                            if (txtQ) {
                                txtQ.value = vl.question_text;
                                txtQ.focus();
                            } else {
                                elements = '<li class="step" id="step' +
                                    i +
                                    '"><div class="step-title waves-effect"></div><div class="step-content"><div class="row">'
                                    + '<div class="input-field col s10 m10 l10"><textarea id="txtQ' +
                                    i +
                                    '" type="text" class="materialize-textarea validate"></textarea><label for="txtQ' +
                                    i +
                                    '">ຄຳຖາມ</label></div><div class="col s2 m2 l2"><br /><a class="btn-small waves-effect blue-grey lighten-2 laotxt" ' +
                                    'id="btnSaveQ' + i + '" onclick="SaveQ()">ບັນທຶກ</a></div></div><br /><br /><br /><div class="row" id="row_step' + i +
                                    '"><input type="hidden" id="txtAnStatus' + i + '" value="empty"></input></div><div class="step-actions">' +
                                    '<a class="waves-effect btn btn-small next-step laotxt z-depth-3">ຕໍ່ໄປ</a><a class="waves-effect btn ' +
                                    'btn-small previous-step laotxt z-depth-3">ກັບຄືນ</a></div></div></li>';
                                stepperInstace.activateStep(elements, i);
                                var txtQ = document.getElementById("txtQ" + i);
                                txtQ.value = vl.question_text;
                                txtQ.focus();
                                M.updateTextFields();
                            }
                            GetQAnswerID(id, txtQ.id);
                        });
                },
                failure: function (response) {
                    swalModal('error', response.d, '');
                }
            });
        }

        window.addEventListener("load", function () {
            var selectedValue = "1";
            var addedSteps;
            var elements;
            var i = 0;//$('.step').length;
            var r = 0;
            var btnAddQ = document.getElementById("btnAddQ");
            var btnDelQ = document.getElementById("btnDelQ");
            var btnAddAn = document.getElementById("btnAddAn");
            var btnDelAn = document.getElementById("btnDelAn");
            var selAnOption = document.getElementById("selAnOption");

            btnAddQ.addEventListener("click", function () {
                $([document.documentElement, document.body]).animate(
                    {
                        scrollTop: $("#stepperQ").offset().top
                    },
                    1000
                );

                elements = '<li class="step" id="step' +
                    (i + 1) +
                    '"><div class="step-title waves-effect"></div><div class="step-content"><div class="row"><div class="input-field col s10 m10 l10"><textarea id="txtQ' +
                    (i + 1) +
                    '" type="text" class="materialize-textarea validate"></textarea><label for="txtQ' +
                    (i + 1) +
                    '">ຄຳຖາມ</label></div><div class="col s2 m2 l2"><br /><a class="btn-small waves-effect blue-grey lighten-2 laotxt" id="btnSaveQ' +
                    (i + 1) +
                    '" onclick="SaveQ()">ບັນທຶກ</a></div></div><br /><br /><br /><input type="hidden" id="txtAnStatus' + (i + 1) + '" value="empty" />' +
                    '<div class="row" id="row_step' + (i + 1) + '"></div>' +
                    '<div class="step-actions"><button class="waves-effect btn-flat btn-small next-step laotxt">ຕໍ່ໄປ</button><button class="waves-effect btn-flat btn-small previous-step laotxt">ກັບຄືນ</button></div></div ></li > ';

                addedSteps = stepperInstace.activateStep(elements, i + 1);
                i++;
                var active_index = $('.step').length;
                stepperInstace.openStep(active_index - 1);
            });

            btnDelQ.addEventListener("click", function () {
                $([document.documentElement, document.body]).animate(
                    {
                        scrollTop: $("#stepperQ").offset().top
                    },
                    1000
                );
                var currentStep = stepperInstace.getSteps();//fix
                var index = currentStep.active.step.id;//fix substring from ID
                index = index.replace('step', '');

                var t_id = document.getElementById("txtT_ID").value;
                var active_index = $('.step').length - 1;
                document.getElementById("txtQ" + index).value = '';
                if (t_id !== '') {
                    var result = q_questions_tb('del', 'txtQ' + index, '', t_id);
                    if (result === 'e5') {
                        document.getElementById("txtQ" + index).value = '';
                        if (active_index !== 0) {
                            stepperInstace.deactivateStep(currentStep.active.step);
                            stepperInstace.openStep(active_index - 1);
                        }
                    } else {
                        swalToast('warning', result);
                    }
                } else {
                    swalToast('error', 'ບໍ່ສາມາດລົບຄຳຖາມໄດ້!');
                    $('#txtQ' + index).focus();
                }
            });

            btnAddAn.addEventListener("click", function () {
                var txtAn = document.getElementById("txtAn").value;
                var t_id = document.getElementById("txtT_ID").value;
                var currentStep = stepperInstace.getSteps();
                var ii = currentStep.active.index;
                var step = "step" + ii;
                var row = "row_step" + ii;
                var element1 =
                    '<div class="input-field" id="An' +
                    ii +
                    '"><h6>ຄຳຕອບ:</h6><textarea id="txtAn' +
                    ii +
                    '" type="text" class="materialize-textarea validate grey lighten-5"></textarea></div>';
                var element2 =
                    '<div class="col" id="An_' +
                    ii +
                    "_" +
                    r +
                    '"><label><input id="rdoAn_' +
                    ii +
                    "_" +
                    r +
                    '" name="group' +
                    ii +
                    '" type="radio" class="with-gap" value="An_' +
                    ii +
                    "_" +
                    r +
                    '"/><span id="rdoAnText_' +
                    ii +
                    "_" +
                    r +
                    '">' +
                    txtAn +
                    "</span></label></div>";
                var txtAnStatus = document.getElementById("txtAnStatus" + ii).value;

                $([document.documentElement, document.body]).animate(
                    {
                        scrollTop: $("#stepperQ").offset().top
                    },
                    1000
                );

                if (selectedValue == "1") {
                    if (txtAnStatus == "empty") {
                        document.getElementById(row).insertAdjacentHTML("beforeend", element1);
                        document.getElementById("txtAnStatus" + ii).value = "full";
                    }
                } else if (selectedValue == "2") {
                    if (txtAn == "") {
                        Swal.fire({
                            text: "ເນື້ອໃນຄຳຕອບວ່າງບໍ່ໄດ້...",
                            type: "info"
                        }).then(result => {
                            if (result.value) {
                                $("#txtAn").focus();
                            }
                        });
                    } else {
                        var result = q_answers_tb('add', "An_" + ii + "_" + r, txtAn, "txtQ" + ii, t_id, swCorrect);
                        if (result === 'e5') {
                            document.getElementById(row).insertAdjacentHTML("beforeend", element2);
                            r++;
                        } else {
                            swalToast('warning', result);
                        }
                        $("#txtAn").focus();
                    }
                }
            });

            btnDelAn.addEventListener("click", function () {
                $([document.documentElement, document.body]).animate(
                    {
                        scrollTop: $("#stepperQ").offset().top
                    },
                    1000
                );
                var t_id = document.getElementById("txtT_ID").value;
                var currentStep = stepperInstace.getSteps();//fix
                var index = currentStep.active.step.id;//fix substring from ID
                var ii = index.replace('step', '');
                var An = "#An" + ii;
                var txtAnStatus = document.getElementById("txtAnStatus" + ii).value;
                if (selectedValue === "1") {
                    if (txtAnStatus === "full") {
                        $(An).remove();
                        document.getElementById("txtAnStatus" + ii).value = "empty";
                    }
                } else if (selectedValue === "2") {
                    var rdoChecked = $("input[name='group" + ii + "']:checked").val();
                    var result = q_answers_tb('del', rdoChecked, txtAn, "txtQ" + ii, t_id, swCorrect);
                    if (result === 'e5') {
                        $('#' + rdoChecked).remove();
                    } else {
                        swalToast('warning', result);
                    }
                    $("#txtAn").focus();
                }
            });

            selAnOption.addEventListener("change", function () {
                $([document.documentElement, document.body]).animate(
                    {
                        scrollTop: $("#stepperQ").offset().top
                    },
                    1000
                );
                selectedValue = $("#selAnOption").val();
                if (selectedValue === "1") {
                    $("#txtAn").hide("500");
                    $("#AnTrueOrFalse").hide("500");
                } else if (selectedValue === "2") {
                    $("#txtAn").show("500");
                    $("#AnTrueOrFalse").show("500");
                }
            });

            $(".switch").find("input[type=checkbox]").on("change", function () {
                swCorrect = $(this).prop('checked');
            });
        });

        setTimeout(function () {
            GetAutocompleteTrainingIdName('', '');
            $('#txtTitle.autocomplete').autocomplete({
                data: itemNames,
                limit: 5
            });
            $('#txtTrainingID.autocomplete').autocomplete({
                data: itemID,
                limit: 5
            });
            $('#<%: txtSearch.ClientID %>.autocomplete').autocomplete({
                data: itemSearch,
                limit: 10
            });
        }, 1000);

        function GetAutocompleteTrainingIdName(id, title) {
            document.getElementById('txtTrainingID').value = '';
            $.ajax({
                type: "POST",
                url: "<%: ResolveUrl("Evaluation.aspx/getTrainingId") %>",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{id:'" + id + "', title:'" + title + "'}",
                success: function (response) {
                    var obj = response.d;
                    $.each(obj,
                        function (key, value) {
                            itemNames['' + value.title + ''] = null;
                            itemID['' + value.id + ''] = null;
                            if (title !== '' && value.id !== '') {
                                document.getElementById('txtTrainingID').value = value.id;
                            }
                            if (id === '' && title === '') {
                                itemSearch['' + value.title + ''] = null;
                                itemSearch['' + value.id + ''] = null;
                            }
                        });
                },
                failure: function (response) {
                    swalModal('error', response.d, '');
                }
            });
        }

    </script>
</asp:Content>

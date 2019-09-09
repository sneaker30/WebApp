<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Evaluation_Training.aspx.cs" Inherits="parti.admin.Evaluation_Training" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="X-UA-Compatible" content="IE=11">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="icon" href="~/favicon.ico" />
    <title>ສວປຝ-ແບບຟອມປະເມີນ</title>
    <!-- CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
    <link href="Content/hover-css/css/hover.css" rel="stylesheet" media="all" />
    <link rel="stylesheet" href="https://unpkg.com/materialize-stepper@3.1.0/dist/css/mstepper.min.css">

    <!-- JS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
    <script src="https://unpkg.com/materialize-stepper@3.1.0/dist/js/mstepper.min.js"></script>

    <style>
        @font-face {
            font-family: 'PhetsarathOT';
            src: url("fonts/PhetsarathOT.ttf") format('truetype');
        }

        form {
            font-family: PhetsarathOT;
        }

        body {
            font-family: PhetsarathOT;
            background: url('img/bg2.png');
            background-repeat: no-repeat;
            background-position: center bottom;
            background-size: cover;
            background-attachment: fixed;
        }

        .input-field {
            font-family: PhetsarathOT;
        }

        input {
            font-family: PhetsarathOT;
        }

        textarea {
            font-family: PhetsarathOT;
        }

        .laotxt {
            font-family: PhetsarathOT;
        }

        .waves-button-input {
            font-family: PhetsarathOT;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="scmEvaluation_Training" runat="server" EnablePageMethods="true" />
        <div class="container">
            <h4>ແບບຟອມການປະເມີນ-ສອບຖາມ</h4>
            <hr />
            <div class="row">
                <p id="txtTitle" style="font-size: xx-large"></p>
                <p id="txtType" style="font-size: xx-large"></p>
                <div class="input-field col s6 m6 l6">
                    <input type="text" id="txtTraineeName" class="validate" required />
                    <label for="txtTraineeName">ຊື່ນາມສະກຸນ</label>
                </div>
                <input type="hidden" id="txtTrainingID" />
            </div>
            <br />
            <div class="row" id="EvaluationStep">
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
                                        <a class="btn-small waves-effect blue-grey lighten-2 laotxt" id="btnSaveQ0" onclick="SaveQ()">ບັນທຶກ
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
                                    <button class="waves-effect btn btn-small next-step laotxt">ຕໍ່ໄປ</button>
                                    <button class="waves-effect btn btn-small previous-step laotxt">ກັບຄືນ</button>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </form>
</body>
<script>
    var t_id;
    $(document).ready(function () {
        var stepper = document.querySelector(".stepper");
        stepperInstace = new MStepper(stepper);
        $(".tooltipped").tooltip();
        $(".modal").modal();
        $(".datepicker").datepicker({
            format: "yyyy-mm-dd"
        });
    });

    setTimeout(function () {
        t_id = GetTID();
        GetQTitleID(t_id[1]);
        GetQQuestionID(t_id[0]);
        GetQAnswerID(t_id[0]);
        M.updateTextFields();
    }, 1000);

    function GetTID() {
        var result;
        $.ajax({
            async: false,
            type: "POST",
            url: "<%: ResolveUrl("Evaluation_Training.aspx/GetTID") %>",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                result = response.d;
            },
            failure: function (response) {
                swalModal('error', response.d, '');
            }
        });
        return result;
    }

    function GetQAnswerID(id) {
        $.ajax({
            type: "POST",
            url: "<%: ResolveUrl("Evaluation.aspx/GetQAnswerID") %>",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{t_id:'" + id + "'}",
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
                var active_index = $('.step').length;
                stepperInstace.openStep(active_index - 1);
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
                                '<button class="waves-effect btn-flat btn-small next-step laotxt">ຕໍ່ໄປ</button><button class="waves-effect btn-flat ' +
                                'btn-small previous-step laotxt">ກັບຄືນ</button></div></div></li>';
                            stepperInstace.activateStep(elements, i);
                            var txtQ = document.getElementById("txtQ" + i);
                            txtQ.value = vl.question_text;
                            txtQ.focus();
                        }
                    });
            },
            failure: function (response) {
                swalModal('error', response.d, '');
            }
        });
    }

    function GetQTitleID(id) {
        $.ajax({
            type: "POST",
            url: "<%: ResolveUrl("Evaluation.aspx/GetQTitleID") %>",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{index:" + (id - 1) + "}",
            success: function (response) {
                var obj = response.d;
                document.getElementById('txtTitle').innerText = 'ຫົວຂໍ້: ' + obj.title_name;
                if (obj.q_type === 'a') {
                    document.getElementById('txtType').innerText = 'ປະເພດ: ຄຳຖາມຫຼັງຝຶກ';
                } else if (obj.q_type === 'b') {
                    document.getElementById('txtType').innerText = 'ປະເພດ: ຄຳຖາມກ່ອນຝຶກ';
                }
            },
            failure: function (response) {
                swalModal('error', response.d, '');
            }
        });
    }

</script>
</html>

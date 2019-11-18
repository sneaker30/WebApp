<%@ Page Title="ລາຍງານລະດັບຄວາມເຂົ້າໃຈ ກ່ອນ-ຫຼັງ ການເຂົ້າຝຶກອົບຮົມ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="tcrpt03.aspx.cs" Inherits="parti.admin.tcrpt03" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        input {
            font-family: PhetsarathOT;
        }

        text {
            font-family: PhetsarathOT;
        }

        #tbSummary td, #tbSummary th {
            border: 1px solid #ddd;
            padding: 8px;
        }

        .preloader-background {
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #eee;
            position: fixed;
            z-index: 100;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
        }
    </style>

    <%-- preloader --%>
    <div class="preloader-background">
        <div class="preloader-wrapper big active">
            <div class="spinner-layer spinner-blue">
                <div class="circle-clipper left">
                    <div class="circle"></div>
                </div>
                <div class="gap-patch">
                    <div class="circle"></div>
                </div>
                <div class="circle-clipper right">
                    <div class="circle"></div>
                </div>
            </div>

            <div class="spinner-layer spinner-red">
                <div class="circle-clipper left">
                    <div class="circle"></div>
                </div>
                <div class="gap-patch">
                    <div class="circle"></div>
                </div>
                <div class="circle-clipper right">
                    <div class="circle"></div>
                </div>
            </div>

            <div class="spinner-layer spinner-yellow">
                <div class="circle-clipper left">
                    <div class="circle"></div>
                </div>
                <div class="gap-patch">
                    <div class="circle"></div>
                </div>
                <div class="circle-clipper right">
                    <div class="circle"></div>
                </div>
            </div>

            <div class="spinner-layer spinner-green">
                <div class="circle-clipper left">
                    <div class="circle"></div>
                </div>
                <div class="gap-patch">
                    <div class="circle"></div>
                </div>
                <div class="circle-clipper right">
                    <div class="circle"></div>
                </div>
            </div>
        </div>
    </div>
    <%-- Search --%>
    <div class="row">
        <h4>ບົດລາຍງານ: ລະດັບຄວາມເຂົ້າໃຈ ກ່ອນ-ຫຼັງ ການເຂົ້າຝຶກອົບຮົມ</h4>
    </div>
    <hr />
    <br />
    <div class="row">
        <p class="helper-text grey-text">ລາຍງານນີ້ ຈະສະແດງລະດັບຄວາມເຂົ້າໃຈຕໍ່ຫົວຂໍ້ການຝຶກຜ່ານການຕອບແບບສອບຖາມກ່ອນການເຂົ້າຝຶກອົບຮົມ ເຊິ່ງຈະເປັນຂໍ້ມູນພື້ນຖານເພື່ອສົມທຽບພາຍຫຼັງການຝຶກອົບຮົມສຳເລັດ.</p>
        <p class="helper-text grey-text">ສຳລັບການຄົ້ນຫາມີຢູ່ 2 ຮູບແບບເຊິ່ງສາມາດຄົ້ນຫາຈາກປະເພດຂອງຫຼັກສູດການຝຶກອົບຮົມ ແລະ ຊ່ວງເວລາຂອງການຝຶກອົບຮົມ.</p>
        <div>
            <div class="col">
                <br />
                <h6 class="grey-text">ຫລັກສູດ:</h6>
            </div>
            <div class="input-field col s12 m4 l4">
                <select id="selCourse2" runat="server"></select>
            </div>
            <div class="col">
                <br />
                <h6 class="grey-text">ລະຫວ່າງວັນທີ:</h6>
            </div>
            <div class="col input-field">
                <input type="text" id="txtDateStart" required class="datepicker validate" placeholder="YYYY-MM-DD" />
                <label for="txtDateStart">ວັນທີ່ເລີ່ມຕົ້ນ</label>
            </div>
            <div class="col input-field">
                <input type="text" id="txtDateEnd" required class="datepicker validate" placeholder="YYYY-MM-DD" />
                <label for="txtDateEnd">ວັນທີ່ສຸດທ້າຍ</label>
            </div>
            <div class="col">
                <br />
                <a class="hvr-grow-shadow btn-floating red darken-3 left z-depth-3 tooltipped" data-position="bottom"
                    data-tooltip="ຄົ້ນຫາ" onclick="Search()"><i class="material-icons">search</i></a>
            </div>
        </div>
    </div>
    <hr />
    <br />
    <div class="row">
        <table class="striped responsive-table" id="tbSummary">
            <caption id="tcaption"></caption>
            <thead class="grey lighten-3">
                <tr>
                    <th>ລ/ດ</th>
                    <th>ຊື່ການຝຶກ</th>
                    <th>ຫຼັກສູດ</th>
                    <th>ສະຖານທີ່ຝຶກ</th>
                    <th>ພາກສ່ວນ</th>
                    <th>ວັນທີ</th>
                    <th>ລາຍລະອຽດ</th>
                </tr>
            </thead>
            <tbody class="grey lighten-3" id="tbody">
            </tbody>
        </table>
    </div>
    <hr />
    <br />
    <div class="row" id="h4_title"></div>
    <br />
    <div class="row" id="details"></div>

    <script>
        $(document).ready(function () {
            $('select').formSelect();
            $('.tooltipped').tooltip();
            $('.datepicker').datepicker({
                format: 'yyyy-mm-dd'
            });
            $('#details').hide();
        });

        function Search() {
            var course_id = $("#<%: selCourse2.ClientID %>").val();
            var course_name = $("#<%: selCourse2.ClientID %> option:selected").text();
            var sdate = document.getElementById('txtDateStart').value;
            var edate = document.getElementById('txtDateEnd').value;
            document.getElementById('h4_title').innerHTML = '';

            document.getElementById('tcaption').innerHTML = '<h6><b>ລາຍງານລະດັບຄວາມເຂົ້າໃຈ ກ່ອນ-ຫຼັງ ການເຂົ້າຝຶກອົບຮົມ ຫົວຂໍ້ ' + course_name + ' ລະຫວ່າງວັນທີ ' + sdate + ' ຫາ ' + edate + '</b></h6><br /><br />';
            //document.getElementById('btnExEXCEL').name = 'ລາຍງານລະດັບຄວາມເຂົ້າໃຈ ກ່ອນ-ຫຼັງ ການເຂົ້າຝຶກອົບຮົມ ຫົວຂໍ້ ' + course_name + ' ລະຫວ່າງວັນທີ ' + sdate + ' ຫາ ' + edate;
            //document.getElementById('btnExpPDF').name = 'ລາຍງານລະດັບຄວາມເຂົ້າໃຈ ກ່ອນ-ຫຼັງ ການເຂົ້າຝຶກອົບຮົມ ຫົວຂໍ້ ' + course_name + ' ລະຫວ່າງວັນທີ ' + sdate + ' ຫາ ' + edate;

            $.ajax({
                async: false,
                type: "POST",
                url: "<%: ResolveUrl("tcrpt03.aspx/getAllQuestionLists") %>",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{course_id:'" + course_id + "', sdate:'" + sdate + "', edate:'" + edate + "'}",
                success: function (response) {
                    var obj = response.d;
                    var i = 1;
                    $('#tbody').empty();
                    $.each(obj,
                        function (key, vl) {
                            var element = "<tr id='" + i + "'>" +
                                "<td>" + i + "</td>" +
                                "<td>" + vl.title + "</td>" +
                                "<td>" + vl.course_name + "</td>" +
                                "<td>" + vl.training_address + "</td>" +
                                "<td>" + vl.org + "</td>" +
                                "<td>" + vl.sdate + " ຫາ " + vl.edate + "</td>" +
                                "<td><a class='btn-small waves-effect z-depth-3 hvr-grow-shadow tooltipped' data-position='right' " +
                                "data-tooltip='ລາຍລະອຽດ' id = '" + vl.t_id + "' name = '" + vl.title + "' onclick = 'getDetails(this.id, this.name)' >" +
                                "<i class='material-icons'>info</i></a></td>" +
                                "</tr>";
                            document.getElementById('tbody').insertAdjacentHTML("beforeend", element);
                            i++;
                        });
                    $('.tooltipped').tooltip();
                },
                failure: function (response) {
                    swalModal('error', response.d, '');
                }
            });
            $('#details').hide();
        }

        function getDetails(t_id, title) {
            $('#details').show('slow');
            document.getElementById('h4_title').innerHTML = '<h6><b>ແບບຟອມປະເມີນຂອງ ການຝຶກອົບຮົມຫົວຂໍ້: <a>' + title + '</a></b></h6>';
            GetQQuestionID(t_id);
            ScrollDownCompare()
        }

        function complete(args) {
            $('select').formSelect();
            M.updateTextFields();
        }

        function ScrollDownCompare() {
            $('html, body').animate({
                scrollTop: $('#details').offset().top
            }, 2500);
        }

        document.addEventListener('DOMContentLoaded', function () {
            $('.preloader-background').delay(2500).fadeOut('slow');
            $('.preloader-wrapper')
                .delay(2500)
                .fadeOut();
        });

        function GetQAnswerID(t_id, q_id) {
            $.ajax({
                type: "POST",
                url: "<%: ResolveUrl("Evaluation.aspx/GetQAnswerID") %>",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{t_id:'" + t_id + "', q_id:'" + q_id + "'}",
                success: function (response) {
                    var obj = response.d;
                    var a_i;
                    var q_i;
                    var txtAn;
                    var row;
                    var element;
                    $.each(obj,
                        function (key, vl) {
                            a_i = vl.a_id.substring(5, 6);
                            q_i = vl.q_id.substring(4, 5);
                            txtAn = 'An_' + q_i + '_' + a_i;
                            row = "txtQ" + q_i;
                            element = "<p id='" + txtAn + "'>ຄຳຕອບ: <a>" + vl.answer_text + "</a> --> ຕອບກ່ອນຝຶກ: <a id='BU_" +
                                txtAn + "'>" + GetCountUAnswer('b', vl.t_id, vl.q_id, txtAn) + "</a>, ຕອບຫຼັງຝຶກ: <a id='AU_" +
                                txtAn + "'>" + GetCountUAnswer('a', vl.t_id, vl.q_id, txtAn) + "</a></p>";
                            var row_Q = document.getElementById(row);
                            if (row_Q) {
                                row_Q.insertAdjacentHTML("beforeend", element);
                            }
                        });
                },
                failure: function (response) {
                    swalModal('error', response.d, '');
                }
            });
        }

        function GetQQuestionID(t_id) {
            $.ajax({
                type: "POST",
                url: "<%: ResolveUrl("Evaluation.aspx/GetQQuestionID") %>",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{t_id:'" + t_id + "'}",
                success: function (response) {
                    var obj = response.d;
                    var round = obj.length;
                    $('#details').empty();
                    $.each(obj,
                        function (key, vl) {
                            var i = vl.q_id;
                            i = i.substring(4, 5);
                            var element = "<div class='row card grey lighten-5' id='row_Q" + i + "'>" +
                                "<div class='card-content'>" +
                                "<div class='row card-title'>" +
                                "<h6>ຄຳຖາມ" + (parseInt(i) + 1) + ": <a>" + vl.question_text + "</a></h6>" +
                                "</div>" +
                                "<div class='row' id='txtQ" + i + "'>" +
                                "</div>" +
                                "</div>" +
                                "</div >";
                            document.getElementById('details').insertAdjacentHTML("beforeend", element);
                            GetQAnswerID(vl.t_id, 'txtQ' + i);
                        });
                },
                failure: function (response) {
                    swalModal('error', response.d, '');
                }
            });
        }

        function GetCountUAnswer(q_type, t_id, q_id, a_id) {
            //getCountUserAnswer
            var result;
            $.ajax({
                async: false,
                type: "POST",
                url: "<%: ResolveUrl("tcrpt03.aspx/getCountUserAnswer") %>",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{q_type:'" + q_type + "', t_id:'" + t_id + "', q_id:'" + q_id + "', a_id:'" + a_id + "'}",
                success: function (response) {
                    result = response.d;
                },
                failure: function (response) {
                    swalModal('error', response.d, '');
                }
            });
            return result;
        }
    </script>
</asp:Content>

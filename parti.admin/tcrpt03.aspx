<%@ Page Title="ລາຍງານລະດັບຄວາມເຂົ້າໃຈກ່ອນການເຂົ້າຝຶກອົບຮົມ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="tcrpt03.aspx.cs" Inherits="parti.admin.tcrpt03" %>

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
        <h4>ລາຍງານລະດັບຄວາມເຂົ້າໃຈ ກ່ອນ-ຫຼັງ ການເຂົ້າຝຶກອົບຮົມ</h4>
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
    <table class="striped responsive-table" id="tbSummary">
        <caption id="tcaption"></caption>
        <thead class="grey lighten-3">
            <tr>
                <th rowspan="2">ລ/ດ</th>
                <th rowspan="2">ຊື່ການຝຶກ</th>
                <th rowspan="2">ສະຖານທີ່ຝຶກ</th>
                <th rowspan="2">ພາກສ່ວນ</th>
                <th rowspan="2">ວັນທີ</th>
                <th rowspan="2">ລາຍລະອຽດ</th>
            </tr>
        </thead>
        <tbody class="grey lighten-3" id="tbody">
        </tbody>
    </table>
    <hr />
    <br />
    <div class="row" id="details">
        <div class="row" id="row_0">
            <div class="row">
                <h6 id="Q0">ຄຳຖາມ: <a>1. ແມວມັກກິນຫຍັງທີ່ສຸດ?</a></h6>
            </div>
            <div class="row">
                <p>ຄຳຕອບ: <a id="A0_0">ປາ</a> --> ຕອບກ່ອນຝຶກ: <a id="CA0_0">10</a></p>
                <p>ຄຳຕອບ: <a id="A0_1">ຊີ້ນຫມູ</a> --> ຕອບກ່ອນຝຶກ: <a id="CA0_1">0</a></p>
                <p>ຄຳຕອບ: <a id="A0_2">ໄກ່</a> --> ຕອບກ່ອນຝຶກ: <a id="CA0_2">0</a></p>
                <p>ຄຳຕອບ: <a id="A0_3">ຫມາ</a> --> ຕອບກ່ອນຝຶກ: <a id="CA0_3">3</a></p>
            </div>
        </div>
        <div class="row" id="row_1">
            <div class="row">
                <h6 id="Q1">ຄຳຖາມ: <a>2. ຂໍໃດຕໍ່ໄປນີ້ບໍ່ສັດກິນຜືດ?</a></h6>
            </div>
            <div class="row">
                <p>ຄຳຕອບ: <a id="A1_0">ງົວ</a> --> ຕອບກ່ອນຝຶກ: <a id="CA1_0">0</a></p>
                <p>ຄຳຕອບ: <a id="A1_1">ແບ້</a> --> ຕອບກ່ອນຝຶກ: <a id="CA1_1">0</a></p>
                <p>ຄຳຕອບ: <a id="A1_2">ຄວາຍ</a> --> ຕອບກ່ອນຝຶກ: <a id="CA1_2">0</a></p>
                <p>ຄຳຕອບ: <a id="A1_3">ເສືອ</a> --> ຕອບກ່ອນຝຶກ: <a id="CA1_3">5</a></p>
            </div>
        </div>
    </div>

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
                                "<td>" + vl.training_address + "</td>" +
                                "<td>" + vl.org + "</td>" +
                                "<td>" + vl.sdate + " ຫາ " + vl.edate + "</td>" +
                                "<td><a class='btn-small waves-effect z-depth-3 hvr-grow-shadow' name='course_id' onclick='getDetails(this.name)'>ລາຍລະອຽດ</a></td>" +
                                "</tr>";
                            document.getElementById('tbody').insertAdjacentHTML("beforeend", element);
                            i++;
                        });
                },
                failure: function (response) {
                    swalModal('error', response.d, '');
                }
            });
            $('#details').hide();
        }

        function getDetails(course_id) {
            $('#details').show('slow');
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
    </script>
</asp:Content>

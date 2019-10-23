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
        <h4>ລາຍງານລະດັບຄວາມເຂົ້າໃຈກ່ອນການເຂົ້າຝຶກອົບຮົມ</h4>
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
                <input type="text" id="txtDateStart" required="" class="datepicker validate" placeholder="YYYY-MM-DD" />
                <label for="txtDateStart">ວັນທີ່ເລີ່ມຕົ້ນ</label>
            </div>
            <div class="col input-field">
                <input type="text" id="txtDateEnd" required="" class="datepicker validate" placeholder="YYYY-MM-DD" />
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
                <th colspan="2">ຈຳນວນຜູ້ເຂົ້າຮ່ວມ</th>
                <th rowspan="2">ວັນທີ</th>
                <th rowspan="2">ລາຍລະອຽດ</th>
            </tr>
            <tr>
                <th>ລວມ</th>
                <th>ຍິງ</th>
            </tr>
        </thead>
        <tbody class="grey lighten-3">
            <tr>
                <td>1</td>
                <td>ຕົວຢ່າງ (ການຝຶກອົບຮົມລັດຖະກອນໃໝ່)</td>
                <td>ໂຮງແຮມວຽງຈັນພຣາຊາ</td>
                <td>ກົມພັດທະນາສີມືແຮງງານແລະຈັດຫາງານ</td>
                <td>40</td>
                <td>15</td>
                <td>10/10/2018 ຫາ 14/10/2018</td>
                <td><a class="btn-small waves-effect z-depth-3 hvr-grow-shadow" name="course_id" onclick="getDetails(this.name)">ລາຍລະອຽດ</a></td>
            </tr>
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

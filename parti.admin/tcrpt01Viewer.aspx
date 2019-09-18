<%@ Page Title="ບົດລາຍງານ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="tcrpt01Viewer.aspx.cs" Inherits="parti.admin.tcrpt01Viewer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.2/css/all.css">
    <style>
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
    <h4>ບົດລາຍງານ: ສະຖິຕິສັງລວມສະຖາບັນຈັດຝຶກອົບຮົມ</h4>
    <hr />
    <br />
    <div class="row">
        <div class="input-field col">
            <div class="custom-control custom-checkbox custom-control-inline">
                <label>
                    <input type="radio" id="rdInternal" class="with-gap" name="IntExt" value="int" /><span>ເປັນການຈັດຕັ້ງໂດຍສະຖາບັນ.</span></label>
            </div>
            <div class="custom-control custom-checkbox custom-control-inline">
                <label>
                    <input type="radio" id="rdExternal" class="with-gap" name="IntExt" value="ext" /><span>ເປັນການຈັດຕັ້ງໂດຍພາກສ່ວນພາຍນອກ.</span></label>
            </div>
        </div>
        <div class="col">
            <br />
            <h6 class="grey-text">ລະຫວ່າງວັນທີ:</h6>
        </div>
        <div class="col input-field">
            <input type="text" id="txtDateStart" required class="datepicker validate" placeholder="YYYY-MM-DD" runat="server" />
            <label for="txtDateStart">ວັນທີ່ເລີ່ມຕົ້ນ</label>
        </div>
        <div class="col input-field">
            <input type="text" id="txtDateEnd" required class="datepicker validate" placeholder="YYYY-MM-DD" runat="server" />
            <label for="txtDateEnd">ວັນທີ່ສຸດທ້າຍ</label>
        </div>
        <div class="col">
            <br />
            <a class="hvr-grow-shadow btn-floating red darken-3 left z-depth-3 tooltipped" data-position="bottom"
                data-tooltip="ຄົ້ນຫາ" onclick="Search()"><i class="material-icons">search</i></a>
        </div>
    </div>
    <hr />
    <br />
    <div class="row" style="border-radius: 30px">
        <table class="striped highlight responsive-table">
            <thead>
                <tr>
                    <th class="col s1 m1 l1">ລ/ດ</th>
                    <th class="col s2 m2 l2">ຫົວຂໍ້ຈັດຝຶກອົບຮົມ</th>
                    <th class="col s1 m1 l1">ຈຳນວນຜູ້ເຂົ້າຮ່ວມລວມ</th>
                    <th class="col s1 m1 l1">ຈຳນວນຜູ້ເຂົ້າຮ່ວມຍິງ</th>
                    <th class="col s2 m2 l2">ວັນ.ເດືອນ.ປີ</th>
                    <th class="col s2 m2 l2">ພາກສ່ວນຈັດຝຶກອົບຮົມ</th>
                    <th class="col s1 m1 l1">ຈຳນວນຄັ້ງ</th>
                    <th class="col s2 m2 l2">ສະຖານທີ່ຈັດ</th>
                </tr>
            </thead>
            <tbody id="tbBody">
            </tbody>
        </table>
    </div>
    <hr />
    <div class="row">
        <div class="col">
            <a class="hvr-grow-shadow btn-floating teal darken-3 z-depth-3 tooltipped" data-position="bottom"
                data-tooltip="Export ເປັນ MS Excel"><i class="fas fa-file-export"></i></a>
        </div>
        <div class="col">
            <a class="hvr-grow-shadow btn-floating blue darken-3 z-depth-3 tooltipped" data-position="bottom"
                data-tooltip="Export ເປັນ PDF"><i class="fas fa-file-pdf"></i></a>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            $('.tooltipped').tooltip();
            $('.datepicker').datepicker({
                format: 'yyyy-mm-dd'
            });
            $('#rdInternal').prop('checked', true);
        });

        function Search() {
            var type;
            var int_or_ext = $("input[name='IntExt']:checked").val();
            var sdate = document.getElementById('<%: txtDateStart.ClientID %>').value;
            var edate = document.getElementById('<%: txtDateEnd.ClientID %>').value;
            var date_range = sdate + ' ຫາ ' + edate;

            if (sdate === '') {
                swalToast('warning', 'ເລືອກຊ່ວງວັນທີ ທີ່ຕ້ອງການເບີ່ງຂໍ້ມູນ.');
                document.getElementById('<%: txtDateStart.ClientID %>').focus();
            }

            if (edate === '') {
                swalToast('warning', 'ເລືອກຊ່ວງວັນທີ ທີ່ຕ້ອງການເບີ່ງຂໍ້ມູນ.');
                document.getElementById('<%: txtDateEnd.ClientID %>').focus();
            }

            if (int_or_ext === 'int') {
                type = ' ';
            }
            else if (int_or_ext == 'int') {
                type = 'ຮ່ວມກັບພາກສ່ວນພາຍນອກ ';
            }

            if (sdate !== '' && edate !== '') {
                //$('#lblTitle').InnerText = 'ສະຖິຕິສັງລວມສະຖາບັນ' + type + 'ຈັດຝຶກອົບຮົມລະຫວ່າງ ' + date_range;
                $('#tbBody').empty();
                $.ajax({
                    async: false,
                    type: "POST",
                    url: "<%: ResolveUrl("tcrpt01Viewer.aspx/GetRPT01Info") %>",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{type:'" + int_or_ext + "', sdate:'" + sdate + "', edate:'" + edate + "'}",
                    success: function (response) {
                        var obj = response.d;
                        var i = 1;
                        $.each(obj,
                            function (key, vl) {
                                var element = "<tr id='" + i + "'>" +
                                    "<td class='col s1 m1 l1'>" + i + "</td>" +
                                    "<td class='col s2 m2 l2'>" + vl.title + "</td>" +
                                    "<td class='col s1 m1 l1'>" + vl.total_trainee + "</td>" +
                                    "<td class='col s1 m1 l1'>" + vl.total_trainee_fmale + "</td>" +
                                    "<td class='col s2 m2 l2'>" + vl.date_range + "</td>" +
                                    "<td class='col s2 m2 l2'>" + vl.organizer + "</td>" +
                                    "<td class='col s1 m1 l1'>" + vl.total_event + "</td>" +
                                    "<td class='col s2 m2 l2'>" + vl.training_address + "</td>" +
                                    "</tr>";
                                document.getElementById('tbBody').insertAdjacentHTML("beforeend", element);
                                i++;
                            });
                    },
                    failure: function (response) {
                        swalModal('error', response.d, '');
                    }
                });
            }
        }

        document.addEventListener('DOMContentLoaded', function () {
            $('.preloader-background').delay(2500).fadeOut('slow');
            $('.preloader-wrapper')
                .delay(2500)
                .fadeOut();
        });
    </script>
</asp:Content>

<%@ Page Title="ລາຍງານທຽບແຜນການຈັດຝຶກອົບຮົມ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="tcrpt02.aspx.cs" Inherits="parti.admin.tcrpt02" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.2/css/all.css">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.debug.js" integrity="sha384-NaWTHo/8YCBYJ59830LTz/P4aQZK1sS0SneOgAvhsIl3zBu8r9RevNg5lHCHAuQ/" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/jspdf-autotable"></script>
    <script src="fonts/PhetsarathOT-normal.js" type="module"></script>
    <style>
        input {
            font-family: PhetsarathOT;
        }

        text {
            font-family: PhetsarathOT;
        }

        #tbTarget td, #tbTarget th {
            border: 1px solid #ddd;
            padding: 8px;
        }

        #tbDone td, #tbDone th {
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
        <h4>ບົດລາຍງານ: ທຽບແຜນການຈັດຝຶກອົບຮົມ</h4>
    </div>
    <hr />
    <br />
    <div class="row">
        <p class="helper-text grey-text">ຕົວຢ່າງສົກປີ: ໃນ 1ປີ ຈະມີ 4ໄຕມາດ, 1ໄຕມາດ ກວມເອົາໄລຍະ 3ເດືອນ, ປະກອບມີ: Q1, Q2, Q3, Q4; ໃຫ້ໃຊ້: 2019-01-01 ຫາ 2019-03-31 ສຳລັບ Q1.</p>
        <p class="helper-text grey-text">ສຳລັບສົກປີໃຫ້ໃສ່: 2019-01-01 ຫາ 2019-12-31 ສຳລັບປີ 2019.</p>
        <div>
            <div class="col">
                <br />
                <h6 class="grey-text">ຫລັກສູດ:</h6>
            </div>
            <div class="input-field col s12 m4 l4">
                <select id="selCourse2" runat="server"></select>
            </div>
            <div class="col s12 m2 l2">
                <div class="input-field">
                    <select id="selYearPlan" runat="server">
                        <option value="Q">ໄຕມາດ</option>
                        <option value="Y">ປີ</option>
                    </select>
                </div>
            </div>
            <div class="col">
                <div class="input-field">
                    <input placeholder="Q1-2019" id="txtQuarter" type="text" class="autocomplete validate" runat="server" autocomplete="off" />
                </div>
            </div>
            <div class="col">
                <div class="input-field">
                    <input placeholder="2019" id="txtYear" type="number" class="autocomplete validate" runat="server" autocomplete="off" />
                </div>
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
        <div class="col s12 m12 l12 center">
            <table id="tbTarget" class="striped responsive-table">
                <caption id="tcaption"></caption>
                <thead class="grey lighten-3">
                    <tr>
                        <th>ລ/ດ</th>
                        <th>ລະຫັດຫຼັກສູດ</th>
                        <th>ຊື່ຫຼັກສູດ</th>
                        <th>ແຜນເປົ້າໝາຍ</th>
                        <th>ປະຕິບັດໄດ້</th>
                    </tr>
                </thead>
                <tbody id="tbody1" class="grey lighten-3"></tbody>
            </table>
        </div>
    </div>
    <hr />
    <div class="row">
        <div class="col">
            <a class="hvr-grow-shadow btn-floating teal darken-3 z-depth-3 tooltipped" data-position="bottom"
                data-tooltip="Export ເປັນ MS Excel" onclick="exportTableToExcel('tbTarget', this.name)" id="btnExEXCEL"><i class="fas fa-file-export"></i></a>
        </div>
        <div class="col">
            <a class="hvr-grow-shadow btn-floating blue darken-3 z-depth-3 tooltipped" data-position="bottom"
                data-tooltip="Export ເປັນ PDF" onclick="exportTableToPdf(this.name)" id="btnExpPDF"><i class="fas fa-file-pdf"></i></a>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            $('select').formSelect();
            $('.tooltipped').tooltip();
            $('.datepicker').datepicker({
                format: 'yyyy-mm-dd'
            });
            $('#<%: txtYear.ClientID %>').hide('');
            $('#<%: txtQuarter.ClientID %>.autocomplete').autocomplete({
                data: {
                    "Q1-2019": null,
                    "Q2-2019": null,
                    "Q3-2019": null,
                    "Q4-2019": null,
                    "Q1-2018": null,
                    "Q2-2018": null,
                    "Q3-2018": null,
                    "Q4-2018": null
                }
            });
            $('#<%: txtYear.ClientID %>.autocomplete').autocomplete({
                data: {
                    "2000": null, "2001": null, "2002": null, "2003": null, "2004": null, "2005": null, "2006": null, "2007": null, "2008": null, "2009": null,
                    "2010": null, "2011": null, "2012": null, "2013": null, "2014": null, "2015": null, "2016": null, "2017": null, "2018": null, "2019": null,
                    "2020": null, "2021": null, "2022": null, "2023": null, "2024": null, "2025": null, "2026": null, "2027": null, "2028": null, "2029": null,
                    "2030": null, "2031": null, "2032": null, "2033": null, "2034": null, "2035": null, "2036": null, "2037": null, "2038": null, "2039": null,
                    "2040": null, "2041": null, "2042": null, "2043": null, "2044": null, "2045": null, "2046": null, "2047": null, "2048": null, "2049": null,
                    "2050": null, "2051": null, "2052": null, "2053": null, "2054": null, "2055": null, "2056": null, "2057": null, "2058": null, "2059": null
                }
            });

            $('#<%: selYearPlan.ClientID %>').on('change', function () {
                if (this.value == 'Y') {
                    $('#<%: txtYear.ClientID %>').show('500');
                    $('#<%: txtQuarter.ClientID %>').hide('500');
                } else if (this.value == 'Q') {
                    $('#<%: txtYear.ClientID %>').hide('500');
                    $('#<%: txtQuarter.ClientID %>').show('500');
                };
            });
        });

        function Search() {
            var course_id = $("#<%: selCourse2.ClientID %>").val();
            var course_name = $("#<%: selCourse2.ClientID %> option:selected").text();
            var qOry = $("#<%: selYearPlan.ClientID %>").val();
            var time_range = null;

            if (qOry === 'Q') {
                time_range = document.getElementById('<%: txtQuarter.ClientID %>').value;
            } else if (qOry === 'Y') {
                time_range = document.getElementById('<%: txtYear.ClientID %>').value;
            }

            document.getElementById('tcaption').innerHTML = '<h6><b>ລາຍງານທຽບແຜນການຈັດຝຶກອົບຮົມຂອງຫຼັກສູດ ' + course_name + ' ຂອງສົກປີ ' + time_range +  '</b></h6><br /><br />';
            document.getElementById('btnExEXCEL').name = 'ລາຍງານທຽບແຜນການຈັດຝຶກອົບຮົມຂອງຫຼັກສູດ ' + course_name + ' ຂອງສົກປີ ' + time_range;
            document.getElementById('btnExpPDF').name = 'ລາຍງານທຽບແຜນການຈັດຝຶກອົບຮົມຂອງຫຼັກສູດ ' + course_name + ' ຂອງສົກປີ ' + time_range;

            $.ajax({
                async: false,
                type: "POST",
                url: "<%: ResolveUrl("tcrpt02.aspx/yearPlanByTimeRanges") %>",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{courseID:'" + course_id + "', times_range:'" + time_range + "', QOrY:'" + qOry + "'}",
                success: function (response) {
                    var obj = response.d;
                    var i = 1;
                    $('#tbody1').empty();
                    $.each(obj,
                        function (key, vl) {
                            var element = "<tr id='" + i + "'>" +
                                "<td>" + i + "</td>" +
                                "<td>" + vl.CourseID + "</td>" +
                                "<td>" + vl.CourseName + "</td>" +
                                "<td>" + vl.Targets + "</td>" +
                                "<td>" + vl.DoneTarget + "</td>" +
                                "</tr>";
                            document.getElementById('tbody1').insertAdjacentHTML("beforeend", element);
                            i++;
                        });
                },
                failure: function (response) {
                    swalModal('error', response.d, '');
                }
            });
        }

        function complete(args) {
            $('select').formSelect();
            M.updateTextFields();
        }

        function ScrollDownCompare() {
            $('html, body').animate({
                scrollTop: $('#').offset().top
            }, 2500);
        }

        document.addEventListener('DOMContentLoaded', function () {
            $('.preloader-background').delay(2500).fadeOut('slow');
            $('.preloader-wrapper')
                .delay(2500)
                .fadeOut();
        });

        function exportTableToExcel(tableID, filename = '') {
            var downloadLink;
            var dataType = 'application/vnd.ms-excel';
            var tableSelect = document.getElementById(tableID);
            var tableHTML = tableSelect.outerHTML.replace(/ /g, '%20');

            // Specify file name
            filename = filename ? filename + '.xls' : 'excel_data.xls';

            // Create download link element
            downloadLink = document.createElement("a");

            document.body.appendChild(downloadLink);

            if (navigator.msSaveOrOpenBlob) {
                var blob = new Blob(['\ufeff', tableHTML], {
                    type: dataType
                });
                navigator.msSaveOrOpenBlob(blob, filename);
            } else {
                // Create a link to the file
                downloadLink.href = 'data:' + dataType + ', ' + tableHTML;

                // Setting the file name
                downloadLink.download = filename;

                //triggering the function
                downloadLink.click();
            }
        }

        function exportTableToPdf(filename) {
            var doc = new jsPDF('l', 'pt', 'a4');
            // It can parse html:            
            doc.addFont('PhetsarathOT');
            doc.setFont('PhetsarathOT');
            doc.autoTable({
                html: '#tbTarget',
                theme: 'striped',
                styles: { font: 'PhetsarathOT' },
                headerStyles: { fontStyle: 'PhetsarathOT' },
            });
            doc.save(filename + '.pdf');
        }
    </script>
</asp:Content>

<%@ Page Title="ແຜນການຈັດຕັ້ງປະຕິບັດ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="YearPlans.aspx.cs" Inherits="parti.admin.YearPlans" %>

<%@ Register Assembly="Syncfusion.EJ" Namespace="Syncfusion.JavaScript.DataVisualization.Models" TagPrefix="ej" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="scmYearPlans" runat="server" EnablePageMethods="true" />
    <%-- Main-CSS --%>
    <link href="Content/ej/web/gradient-lime/ej.web.all.min.css" rel="stylesheet" />
    <link href="Content/ej/web/gradient-lime/ej.theme.min.css" rel="stylesheet" />
    <link href="Content/ej/web/ej.widgets.core.min.css" rel="stylesheet" />
    <%-- Main-JS --%>
    <script src="Scripts/ej/web/ej.web.all.min.js"></script>
    <script src="Scripts/ej/common/ej.webform.min.js"></script>
    <%-- Grid jquery--%>
    <script src="Scripts/jsrender.min.js"></script>
    <script src="Scripts/jquery.easing.1.3.min.js"></script>
    <script src="Scripts/jquery.validate.min.js"></script>
    <script src="Scripts/jquery.validate.unobtrusive.min.js"></script>

    <style>
        input {
            font-family: PhetsarathOT;
        }

        text {
            font-family: PhetsarathOT;
        }

        .e-grid {
            font-family: PhetsarathOT
        }

        .e-label {
            font-family: PhetsarathOT
        }

        .e-field {
            font-family: PhetsarathOT
        }

        .e-ftrchk {
            font-family: PhetsarathOT
        }

        .e-fieldset {
            font-family: PhetsarathOT
        }

        .e-box {
            font-family: PhetsarathOT
        }

        .e-ejinputtext {
            font-family: PhetsarathOT
        }

        .e-dialog {
            min-width: 400px;
        }

        .e-dialog-content {
            height: 500px;
        }
    </style>
    <br />
    <br />
    <div class="row">
        <div class="col s12 m12 l12">
            <div class="row">
                <ej:Grid runat="server" ID="YearPlansGrid" AllowFiltering="true" AllowPaging="true" AllowResizing="true"
                    AllowSorting="true" Font-Names="PhetsarathOT" IsResponsive="true" AllowSearching="true" EnableResponsiveRow="true"
                    OnServerAddRow="YearPlansGrid_OnServerAddRow" OnServerDeleteRow="YearPlansGrid_OnServerDeleteRow"
                    OnServerEditRow="YearPlansGrid_OnServerEditRow">
                    <FilterSettings FilterType="Excel" />
                    <EditSettings AllowAdding="True" AllowEditing="True" AllowEditOnDblClick="True"
                        AllowDeleting="true" ShowDeleteConfirmDialog="true" EditMode="ExternalFormTemplate"
                        ExternalFormTemplateID="#template" FormPosition="BottomLeft"></EditSettings>
                    <ClientSideEvents ActionComplete="complete" />
                    <ToolbarSettings ShowToolbar="true" ToolbarItems="add,edit,delete,search"></ToolbarSettings>
                    <PageSettings IsResponsive="true" PageSize="10" />
                    <Columns>
                        <ej:Column Field="id" HeaderText="ລດ." IsPrimaryKey="true" IsIdentity="true" />
                        <ej:Column Field="year_plan" HeaderText="ສົກປີ" AllowEditing="True">
                            <ValidationRule>
                                <ej:KeyValue Key="required" Value="true" />
                            </ValidationRule>
                        </ej:Column>
                        <ej:Column Field="course_id" HeaderText="ຫລັກສູດ" AllowEditing="True" EditType="DropdownEdit">
                            <ValidationRule>
                                <ej:KeyValue Key="required" Value="true" />
                            </ValidationRule>
                        </ej:Column>
                        <ej:Column Field="target" HeaderText="ໂຕເລກຄາດຫມາຍ" AllowEditing="True">
                            <ValidationRule>
                                <ej:KeyValue Key="required" Value="true" />
                            </ValidationRule>
                        </ej:Column>
                    </Columns>
                </ej:Grid>
                <p class="helper-text grey-text">ຕົວຢ່າງສົກປີ: ໃນ 1ປີ ຈະມີ 4ໄຕມາດ, 1ໄຕມາດ ກວມເອົາໄລຍະ 3ເດືອນ, ປະກອບມີ: Q1, Q2, Q3, Q4; ໃຫ້ໃຊ້: Q1-2018, Q2-2019...</p>
                <p class="helper-text grey-text">ສຳລັບສົກປີໃຫ້ໃສ່ ໂຕເລກປີເລີຍໃຫ້ໃຊ້: 2018, 2019...</p>
            </div>
        </div>
        <br />
    </div>
    <div class="row">
        <div>
            <h6>ທຽບແຜນປີຫລັກສູດ</h6>
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
                    <input placeholder="Q1-2019" id="txtQuarter" type="text" class="autocomplete validate" runat="server" autocomplete="off"/>
                </div>
            </div>
            <div class="col">
                <div class="input-field">
                    <input placeholder="2019" id="txtYear" type="number" class="autocomplete validate" hidden runat="server" autocomplete="off"/>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <a class="btn waves-effect waves-light right z-depth-3" id="btnCompare" runat="server" onserverclick="btnCompare_OnServerClick">ທຽບຂໍ້ມູນ</a>
    </div>
    <br />
    <div class="row">
        <div class="col s12 m6 l6">
            <ej:Chart ID="ChartYearPlans" runat="server" IsResponsive="true" Font-Names="PhetsarathOT" OnClientLoad="onChartLoad" OnClientSeriesRendering="seriesRender">
                <PrimaryXAxis Title-Text="ສົກປີ" AxisLine-Visible="false" MajorGridLines-Visible="false" MajorTickLines-Visible="false" />
                <CommonSeriesOptions EnableAnimation="True" Opacity="0.5" Border-Color="transparent" />
                <Series>
                    <ej:Series Name="ໂຕເລກຄາດຫມາຍ" XName="PlanType" YName="Targets" Fill="rgba(135,206,235,1)" Type="Column">
                        <Marker>
                            <DataLabel Visible="True" Shape="None" TextMappingName="Targets">
                                <Font FontFamily="PhetsarathOT"></Font>
                            </DataLabel>
                        </Marker>
                    </ej:Series>
                    <ej:Series Name="ໂຕເລກທີ່ສາມາດປະຕິບັດໄດ້" XName="PlanType" YName="DoneTarget" Fill="rgba(255,204,153,1)" Type="Column">
                        <Marker>
                            <DataLabel Visible="True" Shape="None">
                                <Font FontFamily="PhetsarathOT"></Font>
                            </DataLabel>
                        </Marker>
                    </ej:Series>
                </Series>
                <Title TextAlignment="Center" Text="ທຽບໂຕເລກຄາດມຫມາຍແຜນ ແລະ ໂຕເລກທີ່ປະຕິບັດໄດ້">
                    <Font FontFamily="PhetsarathOT"></Font>
                </Title>
                <Legend Visible="true" Shape="SeriesType">
                    <Font FontFamily="PhetsarathOT"></Font>
                </Legend>
            </ej:Chart>
        </div>
        <div class="col s12 m6 l6">
            <table>
                <tbody>
                    <tr>
                        <td>
                            <p>ສົກປິ:</p>
                        </td>
                        <td>
                            <p id="lblYearPlan" runat="server" class="grey-text darken-2"></p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p>ຫລັກສູກ:</p>
                        </td>
                        <td>
                            <p id="lblCourseName" runat="server" class="grey-text darken-2"></p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p>ໂຕເລກຄາດຫມາຍແຜນ:</p>
                        </td>
                        <td>
                            <p id="lblTargets" runat="server" class="grey-text darken-2"></p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p>ໂຕເລກທີ່ສາມາດປະຕິບັດໄດ້:</p>
                        </td>
                        <td>
                            <p id="lblDoneTarget" runat="server" class="grey-text darken-2"></p>
                        </td>
                    </tr>
                </tbody>
            </table>
            <br />
            <h6 id="lblDetails" runat="server" class="center" style="font-weight: bold;"></h6>
        </div>

    </div>

    <script>
        $(document).ready(function () {
            $('select').formSelect();
            $('.tooltipped').tooltip();
            $('.datepicker').datepicker({
                format: 'yyyy-mm-dd'
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
        });

        function complete(args) {
            $('select').formSelect();
            M.updateTextFields();
        }

        function ScrollDownCompare() {
            $('html, body').animate({
                scrollTop: $('#<%: lblDetails.ClientID %>').offset().top
            }, 2500);
        }

    </script>
    <script id="template" type="text/template">
        <div class="">
            <label for="id">ລດ.</label>
            <input id="id" name="id" disabled="disabled" type="text" value="{{:id}}" />
        </div>
        <div class="">
            <label for="year_plan">ສົກປີ</label>
            <input id="year_plan" name="year_plan" type="text" value="{{:year_plan}}" />
        </div>
        <div class="">
            <label for="course_id">ຫລັກສູດ</label>
            <select id="course_id" name="course_id" runat="server"></select>
        </div>
        <div class="">
            <label for="target">ໂຕເລກຄາດຫມາຍ</label>
            <input type="number" id="target" name="target" value="{{:target}}" />
        </div>
    </script>
</asp:Content>

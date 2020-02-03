<%@ Page Title="ການເຮັດວຽກຂອງລະບົບ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Logs.aspx.cs" Inherits="parti.admin.Logs" %>

<%@ Register Assembly="Syncfusion.EJ" Namespace="Syncfusion.JavaScript.Models" TagPrefix="ej" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%-- CSS Grid, Modal --%>
    <link href="Content/ej/web/gradient-lime/ej.web.all.min.css" rel="stylesheet" />
    <link href="Content/ej/web/ej.widgets.core.min.css" rel="stylesheet" />
    <link href="Content/ej/web/gradient-lime/ej.theme.min.css" rel="stylesheet" />
    <%-- Grid jquery--%>
    <script src="Scripts/jsrender.min.js"></script>
    <script src="Scripts/jquery.easing.1.3.min.js"></script>
    <script src="Scripts/jquery.validate.min.js"></script>
    <script src="Scripts/jquery.validate.unobtrusive.min.js"></script>
    <%-- Grid ej --%>
    <script src="Scripts/ej/web/ej.web.all.min.js"></script>
    <script src="Scripts/ej/common/ej.webform.min.js"></script>

    <script type="text/javascript">
        function endAdd(args) {
            $('#<%= LogsGrid.ClientID %>').ejWaitingPopup("show");
        }
        function endDelete(args) {
            $('#<%= LogsGrid.ClientID %>').ejWaitingPopup("show");
        }
        function endEdit(args) {
            $('#<%= LogsGrid.ClientID %>').ejWaitingPopup("show");
        }
    </script>
    <%-- Grid --%>
    <style>
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
            font-family: PhetsarathOT;
            font-size: small;
        }
        /*working*/

        e-gridsearchbar {
            font-family: PhetsarathOT;
            font-size: small;
        }
    </style>
    <%--  --%>
    <%--<asp:ScriptManager runat="server"></asp:ScriptManager>--%>
    <br />
    <br />
    <div style="height: 100%; width: 100%">
        <ej:grid runat="server" id="LogsGrid" allowfiltering="true" allowpaging="true" allowresizing="true"
            allowsorting="true" font-names="Phetsarath OT" isresponsive="true" allowsearching="true"
            enableresponsiverow="true" onserverexcelexporting="usersGrid_ServerExcelExporting" onserverpdfexporting="usersGrid_ServerPdfExporting">
            <FilterSettings FilterType="Excel" />
            <ToolbarSettings ShowToolbar="true" ToolbarItems="excelExport,pdfExport,printGrid,search"></ToolbarSettings>
            <PageSettings IsResponsive="true" PrintMode="AllPages" PageSize="20" />
            <Columns>
                <ej:Column Field="id" HeaderText="ລດ" />
                <ej:Column Field="method" HeaderText="ຂໍ້ມູນກ່ຽວກັບ" />
                <ej:Column Field="log_txt" HeaderText="ລາຍລະອຽດ" />
                <ej:Column Field="date_time" HeaderText="ວັນເວລາ" />
            </Columns>
        </ej:grid>
        <br />
    </div>
</asp:Content>

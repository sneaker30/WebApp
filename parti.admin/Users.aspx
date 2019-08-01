<%@ Page Title="ຂໍ້ມູນຜູ້ໃຊ້" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="parti.admin.Users" %>

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
            $('#<%= usersGrid.ClientID %>').ejWaitingPopup("show");
        }
        function endDelete(args) {
            $('#<%= usersGrid.ClientID %>').ejWaitingPopup("show");
        }
        function endEdit(args) {
            $('#<%= usersGrid.ClientID %>').ejWaitingPopup("show");
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
        <ej:Grid runat="server" ID="usersGrid" AllowFiltering="true" AllowPaging="true" AllowResizing="true"
            AllowSorting="true" Font-Names="Phetsarath OT" IsResponsive="true" AllowSearching="true"
            EnableResponsiveRow="true" OnServerAddRow="usersGrid_ServerAddRow" OnServerEditRow="usersGrid_ServerEditRow"
            OnServerDeleteRow="usersGrid_ServerDeleteRow"
            OnServerExcelExporting="usersGrid_ServerExcelExporting" OnServerPdfExporting="usersGrid_ServerPdfExporting">
            <FilterSettings FilterType="Excel" />
            <EditSettings AllowEditing="true" AllowAdding="true" AllowDeleting="true" ShowDeleteConfirmDialog="true" EditMode="Dialog"></EditSettings>
            <ToolbarSettings ShowToolbar="true" ToolbarItems="add,edit,delete,update,cancel,excelExport,pdfExport,printGrid,search"></ToolbarSettings>
            <PageSettings IsResponsive="true" PrintMode="AllPages" PageSize="20" />
            <Columns>
                <ej:Column Field="id" HeaderText="ລດ" IsPrimaryKey="true" IsIdentity="true" AllowEditing="true" />
                <ej:Column Field="username" HeaderText="ຊື່ຜູ້ໃຊ້" EditType="StringEdit" AllowEditing="true">
                    <ValidationRule>
                        <ej:KeyValue Key="required" Value="true" />
                    </ValidationRule>
                </ej:Column>
                <ej:Column Field="passwd" HeaderText="ລະຫັດຜ່ານ" EditType="StringEdit" AllowEditing="true">
                    <ValidationRule>
                        <ej:KeyValue Key="required" Value="true" />
                    </ValidationRule>
                </ej:Column>
                <ej:Column Field="rules" HeaderText="ສິດທິ (rw:ຜູ້ບໍລິຫານ, r:ຜູ້ໃຊ້)" EditType="DropdownEdit" AllowEditing="true">
                    <ValidationRule>
                        <ej:KeyValue Key="required" Value="true" />
                    </ValidationRule>
                </ej:Column>
            </Columns>
        </ej:Grid>
        <br />
    </div>
</asp:Content>


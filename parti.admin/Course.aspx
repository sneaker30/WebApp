<%@ Page Title="ຂໍ້ມູນຫລັກສູດ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Course.aspx.cs" Inherits="parti.admin.Course" %>

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
            font-family: PhetsarathOT
        }
    </style>
    <%--  --%>
    <br />
    <br />
    <div style="height: 100%; width: 100%">
        <ej:Grid runat="server" ID="courseGrid" AllowFiltering="true" AllowPaging="true" AllowResizing="true"
            AllowSorting="true" Font-Names="PhetsarathOT" IsResponsive="true" AllowSearching="true"
            EnableResponsiveRow="true" OnServerAddRow="courseGrid_ServerAddRow" OnServerEditRow="courseGrid_ServerEditRow" OnServerDeleteRow="courseGrid_ServerDeleteRow"
            OnServerExcelExporting="courseGrid_ServerExcelExporting" OnServerPdfExporting="courseGrid_ServerPdfExporting">
            <FilterSettings FilterType="Excel" />
            <EditSettings AllowEditing="true" AllowAdding="true" AllowDeleting="true" ShowDeleteConfirmDialog="true" EditMode="Dialog"></EditSettings>
            <ToolbarSettings ShowToolbar="true" ToolbarItems="add,edit,delete,update,cancel,excelExport,pdfExport,printGrid,search"></ToolbarSettings>
            <PageSettings IsResponsive="true" PrintMode="AllPages" PageSize="20" />
            <Columns>
                <ej:Column Field="id" HeaderText="ລະຫັດຫລັກ" IsPrimaryKey="true" IsIdentity="true" AllowEditing="true" />
                <ej:Column Field="name" HeaderText="ຊື່ຫລັກສູດ" EditType="StringEdit" AllowEditing="true">
                    <ValidationRule>
                        <ej:KeyValue Key="required" Value="true" />
                    </ValidationRule>
                </ej:Column>
                <ej:Column Field="description" HeaderText="ລາຍລະອຽດ/ຫມາຍເຫດ" EditType="StringEdit" AllowEditing="true">
                    <ValidationRule>
                        <ej:KeyValue Key="required" Value="true" />
                    </ValidationRule>
                </ej:Column>
            </Columns>
        </ej:Grid>
        <br />
    </div>
</asp:Content>

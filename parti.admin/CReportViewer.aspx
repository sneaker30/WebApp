<%@ Page Title="ບົດລາຍງານ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CReportViewer.aspx.cs" Inherits="parti.admin.CReportViewer" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <CR:CrystalReportViewer ID="crptVirewer" runat="server" AutoDataBind="true" />
    </div>
</asp:Content>

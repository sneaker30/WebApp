<%@ Page Title="ຫນ້າຫລັກ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="parti.admin._Default" %>

<%@ Register Assembly="Syncfusion.EJ" Namespace="Syncfusion.JavaScript.DataVisualization.Models" TagPrefix="ej" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Main-CSS --%>
    <link href="Content/ej/web/gradient-lime/ej.web.all.min.css" rel="stylesheet" />
    <link href="Content/ej/web/gradient-lime/ej.theme.min.css" rel="stylesheet" />
    <%-- Main-JS --%>
    <script src="Scripts/ej/web/ej.web.all.min.js"></script>

    <br />
    <br />
    <!-- start row 1 Width="500" Height="450"-->
    <div class="row grey lighten-5">
        <ej:Chart ID="columnChart" runat="server" ClientIDMode="Static" IsResponsive="true" OnClientLoad="onChartLoad" 
            Font-Names="Phetsarath OT" OnClientSeriesRendering="seriesRender" BackColor="White">
            <PrimaryXAxis Title-Text="" LabelIntersectAction="Trim">
                <Font FontFamily="PhetsarathOT"></Font>
            </PrimaryXAxis>
            <PrimaryYAxis>
                <Font FontFamily="PhetsarathOT"></Font>
                <Title Text="ໂຕເລກແຜນ ແລະ ໂຕເລກທີ່ປະຕິບັດໄດ້">
                    <Font FontFamily="PhetsarathOT"></Font>
                </Title>
            </PrimaryYAxis>
            <CommonSeriesOptions EnableAnimation="True"/>
            <Title Text="ທຽບແຜນປີການຈັດຝຶກອົບຮົມໃນຊຸມປີນີ້" TextAlignment="Center">
                <Font FontFamily="PhetsarathOT"></Font>
            </Title>
            <Series>
                <ej:Series Name="ໂຕເລກຄາດຫມາຍ" XName="CourseName" YName="Targets" Fill="rgba(135,206,235,1)" Type="Column">
                    <Font FontFamily="PhetsarathOT"></Font>
                    <Marker>
                        <DataLabel Visible="True" Shape="None" TextMappingName="Targets">
                            <Font FontFamily="PhetsarathOT"></Font>
                        </DataLabel>
                    </Marker>
                    <Tooltip Visible="true" EnableAnimation="true">
                        <Font FontFamily="PhetsarathOT"></Font>
                    </Tooltip>
                </ej:Series>
                <ej:Series Name="ໂຕເລກທີ່ສາມາດປະຕິບັດໄດ້" XName="CourseName" YName="DoneTarget" Fill="rgba(255,204,153,1)" Type="Column">
                    <Font FontFamily="PhetsarathOT"></Font>
                    <Marker>
                        <DataLabel Visible="True" Shape="None" TextMappingName="DoneTarget">
                            <Font FontFamily="PhetsarathOT"></Font>
                        </DataLabel>
                    </Marker>
                     <Tooltip Visible="true" EnableAnimation="true">
                        <Font FontFamily="PhetsarathOT"></Font>
                    </Tooltip>
                </ej:Series>
            </Series>
            <Legend Shape="SeriesType" Visible="true">
                <Font FontFamily="PhetsarathOT"></Font>
            </Legend>
        </ej:Chart>
    </div>

    <div class="row grey lighten-5">
        <ej:Chart ID="pieChart" runat="server" IsResponsive="true" OnClientLoad="onChartLoad" 
            Font-Names="Phetsarath OT" OnClientSeriesRendering="seriesRender" BackColor="White">
            <Title Text="ສັງລວມການຈັດຝຶກອົບຮົມທັງຫມົດໃນຖານຂໍ້ມູນ" TextAlignment="Center">
                <Font FontFamily="PhetsarathOT"></Font>
            </Title>
            <Series>
                <ej:Series EnableAnimation="True" XName="Course" YName="Total" Type="Pie" Explode="True"
                    LabelPosition="OutsideExtended" DoughnutSize="2.0" EnableSmartLabels="True" StartAngle="145">
                    <Tooltip Visible="true" EnableAnimation="true">
                        <Font FontFamily="PhetsarathOT"></Font>
                    </Tooltip>
                    <Marker>
                        <DataLabel Visible="true" Shape="None" TextMappingName="Text" ConnectorType="Bezier" EnableContrastColor="true">
                            <Font Color="black" FontFamily="PhetsarathOT"></Font>
                        </DataLabel>
                    </Marker>
                    <Font FontFamily="PhetsarathOT"></Font>
                </ej:Series>
            </Series>
            <Legend Shape="SeriesType">
                <Font FontFamily="PhetsarathOT"></Font>
            </Legend>
        </ej:Chart>
    </div>
    <%--<!-- end roow 1-->--%>
    <div class="row">
        <div class="col s1 m2 l3"></div>
        <div class="col s10 m8 l6">
            <hr />
        </div>
        <div class="col s1 m2 l3"></div>
    </div>
    <!-- start roow 2-->
    <div class="row">
        <%-- card --%>
    </div>
    <!-- end roow 2-->
</asp:Content>

<%@ Page Title="ຂໍ້ມູນສ່ວນຕົວ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="parti.admin.UserProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .bottom-sheet {
            min-height: 80%;
        }

        .imageUpload {
            display: none;
        }

        .profileImage {
            cursor: pointer;
        }

        #profile-container {
            width: 150px;
            height: 150px;
            overflow: hidden;
            -webkit-border-radius: 50%;
            -moz-border-radius: 50%;
            -ms-border-radius: 50%;
            -o-border-radius: 50%;
            border-radius: 50%;
        }

            #profile-container img {
                width: 150px;
                height: 150px;
            }

        .img {
            width: 100px;
            height: 110px;
            object-fit: fill;
            cursor: pointer;
        }

        .card {
            display: inline-block;
            position: relative;
            width: 150px;
            margin-bottom: 50px;
            margin-right: 20px;
            border-radius: 6px;
            color: rgba(0, 0, 0, 0.87);
            background: #fff;
            box-shadow: 0 2px 2px 0 rgba(0, 0, 0, 0.14), 0 3px 1px -2px rgba(0, 0, 0, 0.2), 0 1px 5px 0 rgba(0, 0, 0, 0.12);
        }

        .card-profile {
            margin-top: 30px;
            text-align: center;
        }

        .card .card-image {
            position: relative;
            overflow: hidden;
            margin-left: 15px;
            margin-right: 15px;
            margin-top: -30px;
            border-radius: 6px;
            box-shadow: 0 16px 38px -12px rgba(0, 0, 0, 0.56), 0 4px 25px 0px rgba(0, 0, 0, 0.12), 0 8px 10px -5px rgba(0, 0, 0, 0.2);
        }

        .table {
            padding: 10px;
            margin-bottom: 0px;
            background-color: transparent;
        }

        .img {
            align-content: center;
            object-fit: cover;
        }

        .select-dropdown {
            font-family: PhetsarathOT;
        }
    </style>
    <br />
    <br />

    <div class="row">
        <div class="col s12 m3 l3" align="center">
            <div id="profile-container">
                <img id="profileImage" runat="server" src="img/avatar.png" class="img responsive-img tooltipped" data-position="left" data-tooltip="ປ່ຽນຮູບພາບ 150x150" />
            </div>
            <asp:FileUpload ID="imageUpload" runat="server" name="profile_photo" class="imageUpload" />
        </div>
        <br />
        <div class="col s12 m9 l9">
            <ul class="tabs" id="myTab">
                <li class="tab col s4 m4 l4"><a href="#PersonalInfo">ຂໍ້ມູນສ່ວນຕົວ</a></li>
                <li class="tab col s4 m4 l4"><a href="#Edocation">ການສຶກສາ</a></li>
                <li class="tab col s4 m4 l4"><a href="#UserAccount">ຂໍ້ມູນຜູ້ໃຊ້</a></li>
            </ul>
            <%-- tab1 --%>
            <div id="myTabContent">
                <div id="PersonalInfo" class="col s12 m12 l12">
                    <br />
                    <div class="row">
                        <div class="col s12 m12 l12">
                            <div class="row">
                                <div class="input-field col s12 m12 l12">
                                    <input type="text" id="txtID" runat="server" class="validate laotxt" required />
                                    <label for="txtID">ລະຫັດພະນັກງານ</label>
                                    <input type="hidden" id="txtIDHidden" runat="server"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="input-field col s12 m6 l6">
                                    <label for="txtName">ຊື່</label>
                                    <input type="text" id="txtName" runat="server" class="validate laotxt" required />
                                </div>
                                <div class="input-field col s12 m6 l6">
                                    <label for="txtfaminame">ນາມສະກຸນ</label>
                                    <input type="text" id="txtfaminame" runat="server" class="validate laotxt" required />
                                </div>
                            </div>
                            <div class="row">
                                <div class="input-field col s12 m6 l6">
                                    <label for="txtworkPlace">ບ່ອນປະຈຳການ</label>
                                    <input type="text" id="txtworkPlace" runat="server" class="validate laotxt" required />
                                    <span class="helper-text">ຕົວຢ່າງ: ກະຊວງພາຍໃນ, ກົມຄຸ້ມຄອງລັດທະກອນ, ພະແນກບໍລິຫານ</span>
                                </div>
                                <div class="input-field col s12 m6 l6">
                                    <label for="txtPosition">ຫນ້າທີ່ຮັບຜິດຊອບ</label>
                                    <input type="text" id="txtPosition" runat="server" class="validate laotxt" required />
                                    <span class="helper-text">ຕົວຢ່າງ: ຫົວຫນ້າກົມ, ຮອງກົມ, ວິຊາການ</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col s6 m4 l4">
                                    <label for="dtpBD">ວັນເດືອນປີເກີດ</label>
                                    <input id="dtpBD" type="text" class="datepicker validate laotxt" runat="server" required>
                                    <span class="helper-text" data-error="ສະເພາະວັນທີ." data-success="ວັນເດືອນປີເກີດ.">ວັນເດືອນປີເກີດ.</span>
                                </div>
                                <div class="input-field col s6 m4 l4 center">
                                    <div class="row">
                                        <p>
                                            <label>
                                                <input name="group1" type="radio" id="rdMale" runat="server" class="with-gap" checked/>
                                                <span>ຊາຍ</span>
                                            </label>
                                            <label>
                                                <input name="group1" type="radio" id="rdFamale" runat="server" class="with-gap"/>
                                                <span>ຍິງ</span>
                                            </label>
                                        </p>
                                    </div>
                                </div>
                                <div class="input-field col s12 m4 l4">
                                    <h6 style="color: grey">ຮູບພາບປະຈຳຕົວ:
                                                <label id="lblPicUrlPath" runat="server"></label>
                                    </h6>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%-- tab2 --%>
                <div id="Edocation" class="col s12 m12 l12">
                    <br />
                    <div class="input-field">
                        <label for="txtlv1">ລະດັບການສຶກສາ 1</label>
                        <input type="text" id="txtlv1" runat="server" class="validate laotxt" required />
                        <span class="helper-text">ຕົວຢ່າງ: ປະລິນຍາຕີ ເສດທະສາດ, ບໍລິຫານທຸລະກິດ.</span>
                    </div>
                    <div class="input-field">
                        <label for="txtlv2">ລະດັບການສຶກສາ 2</label>
                        <input type="text" id="txtlv2" runat="server" class="validate laotxt" />
                        <span class="helper-text">ຕົວຢ່າງ: ປະລິນຍາໂທ ວິສະວະກຳສາດ, ພາສາໂປຣແກຣມຄອມພິວເຕີ.</span>
                    </div>
                    <div class="input-field">
                        <label for="txtlv3">ລະດັບການສຶກສາ 3</label>
                        <input type="text" id="txtlv3" runat="server" class="validate laotxt" />
                        <span class="helper-text">ຕົວຢ່າງ: ປະລິນຍາເອກ ລັດທະສາດ, ພົວພັນຕ່າງປະເທດ.</span>
                    </div>
                    <div class="input-field">
                        <label for="txtlv4">ລະດັບການສຶກສາ 4</label>
                        <input type="text" id="txtlv4" runat="server" class="validate laotxt" />
                    </div>
                    <div class="input-field">
                        <label for="txtlv5">ລະດັບການສຶກສາ 5</label>
                        <input type="text" id="txtlv5" runat="server" class="validate laotxt" />
                    </div>
                </div>
                <%-- tab3 --%>
                <div id="UserAccount" class="col s12 m12 l12">
                    <br />
                    <div class="input-field">
                        <label for="txtUsername">ຊື່ຜູ້ໃຊ້</label>
                        <input type="text" id="txtUsername" runat="server" class="validate" required />
                        <span class="helper-text">ຊື່ຜູ້ໃຊ້ນີ້ຕ້ອງກົງກັບ ຂໍ້ມູນໃນ "ຂໍ້ມູນບັນຊີຜູ້ໃຊ້"</span>
                    </div>
                </div>
            </div>
            <%-- tab1 --%>
            <hr />
        </div>
    </div>

    <div class="row">
        <div class="col s12 m3 l3"></div>
        <div class="col">
            <asp:Button class="btn-small waves-effect waves-light right laotxt" ID="btnSave" runat="server" OnClick="btnSave_Click" Text="ບັນທຶກ"></asp:Button>
            <input type="hidden" id="btnState" runat="server" />
            <input type="hidden" id="avartaUrl" runat="server" />
        </div>
        <div class="col"></div>
        <div class="col"></div>
        <div class="col"></div>
        <div class="col"></div>
    </div>

    <script>

        $(document).ready(function () {
            $('.tooltipped').tooltip();
            $('.modal').modal();
            $('.tabs').tabs();
            $('.datepicker').datepicker({
                format: 'mm/dd/yyyy'
            });

            $('#<%: profileImage.ClientID %>').click(function (e) {
                $('#<%: imageUpload.ClientID %>').click();
            });

            function fasterPreview(uploader) {
                if (uploader.files && uploader.files[0]) {
                    $('#<%: profileImage.ClientID %>').attr('src', window.URL.createObjectURL(uploader.files[0]));
                }
            }

            $('#<%: imageUpload.ClientID %>').change(function () {
                fasterPreview(this);
                var thefile = document.getElementById('<%: imageUpload.ClientID %>');
                document.getElementById('<%: lblPicUrlPath.ClientID %>').innerText = thefile.value;
            });

        });       

    </script>
</asp:Content>

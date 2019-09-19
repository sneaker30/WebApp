<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="parti.admin.WebForm1" %>

<%@ Register Assembly="Syncfusion.EJ.Web" Namespace="Syncfusion.JavaScript.Web" TagPrefix="ej" %>

<!DOCTYPE html>

<html lang="en">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="X-UA-Compatible" content="IE=11">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="icon" href="~/favicon.ico" />
    <title>ເຂົ້າສູ່ລະບົບ - PARTI TIS V.1</title>

    <!-- CSS -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <!-- JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

    <style>
        @font-face {
            font-family: 'PhetsarathOT';
            src: url("fonts/PhetsarathOT.ttf") format('truetype');
        }

        html,
        body {
            font-family: PhetsarathOT;
            height: 100%;
        }

        body {
            display: -ms-flexbox;
            display: flex;
            -ms-flex-align: center;
            align-items: center;
            padding-top: 40px;
            padding-bottom: 40px;
            /*background-color: #f5f5f5;*/
            font-family: Phetsarath;
            text-align: center;
            background: url('img/bg2.png');
            background-repeat: no-repeat;
            background-position: center bottom;
            background-size: cover;
        }

        .md-form {
            font-family: PhetsarathOT;
            width: 100%;
            max-width: 400px;
            padding: 15px;
            margin: auto;
            text-align: center;
            align-items: center;
        }
    </style>
</head>

<body class="md-form">
    <%-- preloader --%>
    <form runat="server" class="md-form" align="center">
        <img class="m4" src="img/AppLogo.png" alt="#" width="344" height="172" align="center"/>
        <%--<h5>ລະບົບຄຸ້ມຄອງຂໍ້ມູນການຝຶກອົບຮົມ</h5>--%>
        <br />
        <br />
        <div class="input-field" style="width: 90%">
            <i class="material-icons prefix">account_circle</i>
            <label for="inputUsername">ຊື່ຜູ້ໃຊ້</label>
            <input type="text" id="inputUsername" runat="server" class="validate" required="required" autofocus="autofocus" align="center" />
        </div>
        <div class="input-field" style="width: 90%">
            <i class="material-icons prefix">enhanced_encryption</i>
            <label for="inputPassword">ລະຫັດຜ່ານ</label>
            <input type="password" id="inputPassword" runat="server" class="validate" required="required" align="center" />
        </div>
        <div class="md-form">
            <asp:Button ID="btLogin" runat="server" Text="Login" ToolTip="ເຂົ້າສູ່ລະບົບ" class="btn waves-effect waves-light z-depth-3" OnClick="btLogin_Click" align="center" ForeColor="WhiteSmoke" />
        </div>
        <br />
        <a onclick="swalToast('info', 'ແຈ້ງເຕືອນ: ຕິດຕໍ່ຜູ້ຄຸ້ມຄອງລະບົບເພື່ອແກ້ໄຂ ຊື່ຜູ້ໃຊ້ຂອງທ່ານ...!')" class="btn btn-flat">ລືມລະຫັດຜ່ານ!</a>
        <p class="mt-5 mb-3 text-muted">&copy; <%: DateTime.Now.Year %> - ພັດທະນາໂດຍ ສະຖາບັນຄົ້ນຄວ້າວິທະຍາສາດການປົກຄອງ ແລະ ຝຶກອົບຮົມ,​ ກະຊວງພາຍໃນ.</p>
        <br />
        <br />
    </form>
</body>
<script type="text/javascript">

    $(document).ready(function () {
        $('.waves-button-input').addClass('white-text');
    });

    document.addEventListener('DOMContentLoaded', function () {
        $('.preloader-background').delay(2500).fadeOut('slow');
        $('.preloader-wrapper')
            .delay(2500)
            .fadeOut();
    });

    function swalToast(action, msg) {
        const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 6000
        });

        if (action == 'error') {
            Toast.fire({
                type: 'error',
                title: msg
            });
        } else if (action == 'warning') {
            Toast.fire({
                type: 'warning',
                title: msg
            });
        } else if (action == 'success') {
            Toast.fire({
                type: 'success',
                title: msg
            });
        } else if (action == 'info') {
            Toast.fire({
                type: 'info',
                title: msg
            });
        }
    }
</script>
</html>

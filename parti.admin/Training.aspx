<%@ Page Title="ຂໍ້ມູນການຈັດຝຶກອົບຮົມ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Training.aspx.cs" Inherits="parti.admin.Training" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="scmTraining" runat="server" EnablePageMethods="true" />
    <link rel="stylesheet" href="https://unpkg.com/materialize-stepper@3.1.0/dist/css/mstepper.min.css">
    <script src="https://unpkg.com/materialize-stepper@3.1.0/dist/js/mstepper.min.js"></script>
    <script src="Scripts/jquery.simpleLoadMore.min.js"></script>

    <style>
        input {
            font-family: PhetsarathOT;
        }

        .card {
            width: 200px;
            border-radius: 10px;
            margin-right: 20px;
        }

        .card-image {
            width: 200px;
            height: 120px;
        }

        .img {
            width: 200px;
            height: 120px;
            object-fit: fill;
        }

        ul.stepper.horizontal {
            height: 800px;
        }

        .card-panel {
            width: 300px;
            height: 150px;
        }

        option.fontsize {
            font-size: 10px;
        }

        ul.stepper.horizontal .step .step-content .step-actions {
            position: relative;
        }
    </style>
    <br />
    <br />
    <!-- Search BOX & Main Function -->
    <div class="row">
        <div class="col s6 m6 l6 ">
            <div class="input-field">
                <label for="txtSearch">ຄົ້ນຫາ</label>
                <input id="txtSearch" runat="server" type="text" class="laotxt" autocomplete="on" />
                <span class="helper-text">ຂໍ້ມູນທີ່ສາມາດຄົ້ນຫາໄດ້: ຊື່ ແລະ ນາມສະກຸນ...</span>
            </div>
        </div>
        <div class="col">
            <br />
            <a class="hvr-grow-shadow btn-floating red darken-3 left z-depth-3 tooltipped" data-position="bottom" data-tooltip="ຄົ້ນຫາ" onclick="Search()" id="btnSearch">
                <i class="material-icons">search</i>
            </a>
        </div>
        <div class="col">
            <br />
            <a class="hvr-grow-shadow btn-floating blue tooltipped left z-depth-3" data-position="bottom" data-tooltip="ເພີ່ມ" onclick="SetTrainingInfo('-1')">
                <i class="material-icons">add</i>
            </a>
        </div>
    </div>
    <!-- Search BOX & Main Function -->
    <br />
    <br />
    <%-- Stepper --%>
    <div id="Stepper" runat="server" hidden>
        <ul class="stepper horizontal">
            <li class="step" id="step1" title="ຫົວຂໍ້">
                <div class="step-title waves-effect">ຫົວຂໍ້</div>
                <div class="step-content">
                    <div class="row">
                        <div class="input-field col s12 m12 l12">
                            <label for="txtTitle">ຫົວຂໍ້</label>
                            <input type="text" id="txtTitle" runat="server" class="validate" required />
                            <span class="helper-text">ຊື່ຫົວຂໍ້ທີ່ຈະຈັດງານ.</span>
                        </div>
                        <div class="input-field col s12 m12 l12">
                            <select class="validate" required id="selCourseID" runat="server">
                                <option value="" disabled selected></option>
                            </select>
                            <label>ກ່ຽວກັບຫລັກສູດ</label>
                            <span class="helper-text">ຫລັກສູດທີ່ກ່ຽວຂ້ອງກັບຫົວຂໍ້ການຈັດງານ.</span>
                        </div>
                        <div class="input-field col s12 m12 l12">
                            <div class="custom-control custom-checkbox custom-control-inline">
                                <label>
                                    <input type="radio" id="rdInternal" runat="server" class="with-gap" name="IntExt" value="int" /><span>ເປັນການຈັດຕັ້ງໂດຍສະຖາບັນ.</span></label>
                            </div>
                            <div class="custom-control custom-checkbox custom-control-inline">
                                <label>
                                    <input type="radio" id="rdExternal" runat="server" class="with-gap" name="IntExt" value="ext" /><span>ເປັນການຈັດຕັ້ງໂດຍພາກສ່ວນພາຍນອກ.</span></label>
                            </div>
                        </div>
                        <div class="input-field col s12 m12 l12">
                            <label for="txtDescription">ລາຍລະອຽດພາກສ່ວນພາຍນອກ</label>
                            <input type="text" class="validate" id="txtDescription" runat="server" />
                            <span class="helper-text">ພາກສ່ວນພາຍນອກທີ່ເປັນເຈົ້າການໃນການຈັດຝຶກອົບຮົມ.</span>
                        </div>
                    </div>
                    <div class="step-actions">
                        <button id="btnFocused" type="button" class="waves-effect waves-light btn next-step laotxt z-depth-3" onclick="SetTrainingID()">ຂັ້ນຕໍ່ໄປ</button>
                    </div>
                </div>
            </li>
            <li class="step" id="step2" title="ສະຖານທີ່ຈັດງານ">
                <div class="step-title waves-effect">ສະຖານທີ່ຈັດງານ</div>
                <div class="step-content">
                    <div class="row">
                        <div class="input-field col s12 m12 l12">
                            <label for="txtTitle">ສະຖານທີ່ຈັດງານ</label>
                            <input type="text" id="txtTriAddre" runat="server" class="validate" required />
                            <span class="helper-text">ສະຖານທີ່ຈັດງານ: ສະຖາບັນຄົ້ນຄວ້າວິທະຍາສາດການປົກຄອງ ແລະ ຝຶກອົບຮົມ, ກະຊວງພາຍໃນ.</span>
                        </div>
                        <div class="row">
                            <div class="input-field col s12 m6 l6">
                                <label for="txtDistrict">ເມືອງ</label>
                                <input type="text" id="txtDistrict" runat="server" class="validate autocomplete" required autocomplete="off" />
                                <span class="helper-text">ເມືອງທີ່ໃຊ້ຈັດງານ.</span>
                            </div>
                            <div class=" input-field col s12 m6 l6">
                                <label for="txtProvince">ແຂວງ</label>
                                <input type="text" id="txtProvince" runat="server" class="validate autocomplete" required autocomplete="off" />
                                <span class="helper-text">ແຂວງທີ່ໃຊ້ຈັດງານ.</span>
                            </div>
                        </div>
                        <div class="input-field col s12 m12 l12">
                            <label for="txtTitle">ຈຳນວນວັນທີ່ຈັດງານ</label>
                            <input type="number" id="txtTridays" runat="server" class="validate" required />
                            <span class="helper-text" data-error="ສະເພາະຕົວເລກ." data-success="ສະເພາະຕົວເລກ.">ສະເພາະຕົວເລກ.</span>
                        </div>
                        <div class="input-field col s12 m12 l12">
                            <input type="text" class="datepicker validate" id="dtpDate" runat="server" required placeholder="YYYY-MM-DD" />
                            <label for="dtpDate">ວັນທີ່ເລີ່ມຈັດງານ</label>
                            <span class="helper-text" data-error="ສະເພາະວັນທີ." data-success="ວັນທີ່ເລີ່ມຈັດງານ.">ວັນທີ່ເລີ່ມຈັດງານ.</span>
                        </div>
                    </div>
                    <div class="step-actions">
                        <button type="button" class="waves-effect waves-light btn next-step laotxt z-depth-3" onclick="InsertTraining()">ຂັ້ນຕໍ່ໄປ</button>
                        <button type="button" class="waves-effect waves-light btn-flat previous-step laotxt z-depth-3">ກັບຄືນ</button>
                    </div>
                </div>
            </li>
            <li class="step active" id="step3" title="ຄູຝຶກ">
                <div class="step-title waves-effect">ຄູຝຶກ</div>
                <div class="step-content">
                    <div class="row">
                        <div class="input-field col s12 m12 l12">
                            <input type="text" id="txtSearchTrainerList" onkeyup="SearchTrainer(this.value)" />
                            <label for="txtSearchTrainerList">ລາຍຊື່ຄູຝຶກ</label>
                            <span class="helper-text">ຄົ້ນຫາລາຍຊື້ຄູຝຶກທີ່ຕ້ອງການແລ້ວເລືອກເອົາ</span>
                        </div>
                        <div class="col s12 m6 l6" id="div1">
                            <br />
                            <h6>ລາຍຊື່ຄູຝຶກຂອງສະຖາບັນ</h6>
                            <hr />
                            <br />
                            <%-- Table --%>
                            <div class="row">
                                <div class="col s12 m8 l8">
                                    <table>
                                        <tbody id="tbTnerBody1" class="some-list highlight" runat="server">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <%-- Table --%>
                        </div>
                        <div class="col s12 m6 l6" id="div2">
                            <br />
                            <h6>ລາຍຊື່ຄູຝຶກທີ່ເຂົ້າຮ່ວມ</h6>
                            <hr />
                            <br />
                            <%-- Table --%>
                            <div class="row">
                                <div class="col s12 m8 l8">
                                    <table>
                                        <tbody id="tbTnerBody2" class="some-list highlight" runat="server">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <%-- Table --%>
                        </div>
                    </div>
                    <div class="step-actions">
                        <button type="button" class="waves-effect waves-light btn next-step laotxt z-depth-3" onclick="swalToast('info', 'ຂັ້ນຕອນຕໍ່ໄປເລືອກຜູ້ເຂົ້າຮ່ວມ')">ຂັ້ນຕໍ່ໄປ</button>
                        <button type="button" class="waves-effect waves-light btn-flat previous-step laotxt z-depth-3">ກັບຄືນ</button>
                    </div>
                </div>
            </li>
            <li class="step" id="step4" title="ຜູ້ເຂົ້າຮ່ວມຝຶກອົບຮົມ">
                <div class="step-title waves-effect">ຜູ້ເຂົ້າຮ່ວມຝຶກອົບຮົມ</div>
                <div class="step-content">
                    <div class="row">
                        <div class="input-field col s12 m12 l12">
                            <input type="text" id="txtSearchTraineeList" runat="server" onkeyup="SearchTrainee(this.value)" />
                            <label for="txtSearchTraineeList">ລາຍຊື່ຜູ້ຮ່ວມຝຶກອົບຮົມ</label>
                            <span class="helper-text">ຄົ້ນຫາລາຍຊື້ຜູ້ຮ່ວມຝຶກອົບຮົມທີ່ຕ້ອງການແລ້ວເລືອກເອົາ</span>
                        </div>
                        <div class="col s12 m6 l6">
                            <br />
                            <h6>ລາຍຊື່ຜູ້ຮ່ວມຝຶກອົບຮົມທີ່ມີລາຍຊື່ໃນສະຖາບັນ</h6>
                            <hr />
                            <br />
                            <table>
                                <tbody id="tbTneeBody1" class="some-list highlight" runat="server">
                                </tbody>
                            </table>
                        </div>
                        <div class="col s12 m6 l6">
                            <br />
                            <h6>ລາຍຊື່ຜູ້ຝຶກອົບຮົມທີ່ຈະເຂົ້າຮ່ວມ</h6>
                            <hr />
                            <br />
                            <table>
                                <tbody id="tbTneeBody2" class="some-list highlight" runat="server">
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="step-actions">
                        <button type="button" class="waves-effect waves-light btn laotxt z-depth-3" onclick="Complete()">ບັນທຶກ</button>
                        <input type="hidden" runat="server" id="txtTrainingID" />
                        <button type="button" class="waves-effect waves-light btn-flat previous-step laotxt z-depth-3">ກັບຄືນ</button>
                    </div>
                </div>
            </li>
        </ul>
        <hr />
    </div>
    <%-- Stepper --%>

    <%-- Card Training --%>
    <div class="row" id="cardTraining" runat="server">
    </div>
    <%-- Card Training --%>

    <%-- Customs JS --%>
    <script type="text/javascript">
        var int_or_ext;
        var itemDistrict = {};
        var itemProvince = {};

        setTimeout(function () {
            GetAutocompleteDis();
            $('#<%: txtDistrict.ClientID %>.autocomplete').autocomplete({
                data: itemDistrict,
                limit: 20, onAutocomplete: function (val) { }, minLength: 2
            });
            GetAutocompletePro();
            $('#<%: txtProvince.ClientID %>.autocomplete').autocomplete({
                data: itemProvince,
                limit: 10, onAutocomplete: function (val) { }, minLength: 2
            });
        }, 1000);

        function GetAutocompleteDis() {
            $.ajax({
                type: "POST",
                url: "<%: ResolveUrl("Training.aspx/GetDistricts") %>",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var obj = response.d;
                    $.each(obj,
                        function (key, value) {
                            itemDistrict['' + value.d_name + ''] = null;
                        });
                },
                failure: function (response) {
                    swalModal('error', response.d, '');
                }
            });
        }

        function GetAutocompletePro() {
            $.ajax({
                type: "POST",
                url: "<%: ResolveUrl("Training.aspx/GetProvinces") %>",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var obj = response.d;
                    $.each(obj,
                        function (key, value) {
                            itemProvince['' + value.p_name + ''] = null;
                        });
                },
                failure: function (response) {
                    swalModal('error', response.d, '');
                }
            });
        }

        $(document).ready(function () {
            var stepper = document.querySelector('.stepper');
            var stepperInstace = new MStepper(stepper,
                {
                    firstActive: 0,
                    stepTitleNavigation: false
                });
            $('#<%: Stepper.ClientID %>').hide();
            $('.tooltipped').tooltip();
            $('.modal').modal();
            $('.datepicker').datepicker({
                format: 'yyyy-mm-dd'
            });
            $('select').formSelect();
            $('.some-list').simpleLoadMore({
                item: 'tr',
                count: 5,
                btnHTML: '<br><br><a href="#" id="btnMore" class="load-more_btn btn-flat waves-effect tooltipped blue-text text-darken-3" data-position="left" data-tooltip="ເບີ່ງສ່ວນທີ່ເຫລືອ" onclick="ScrollDown()">ເບີ່ງສ່ວນທີ່ເຫລືອ...</a>'
            });
            $("input[type=radio]").on("click", function () {
                int_or_ext = $("input[type=radio]:checked").val();
            });
        });

        function SearchTrainer(txt) {
            $('.trTrainer:not(:contains("' + txt + '"))').hide('500');
            $('.trTrainer:contains("' + txt + '")').show();
            $('.some-list').simpleLoadMore({
                item: 'tr',
                count: 5,
                btnHTML: '<a id="btnMore" class="load-more__btn" hidden></a>'
            });
        }

        function SearchTrainee(txt) {
            $('.trTrainee:not(:contains("' + txt + '"))').hide('500');
            $('.trTrainee:contains("' + txt + '")').show();
            $('.some-list').simpleLoadMore({
                item: 'tr',
                count: 5,
                btnHTML: '<a id="btnMore" class="load-more__btn" hidden></a>'
            });
        }

        function ScrollDown() {
            $('html,body').animate({ scrollTop: 9999 }, 'slow');
        }

        function Complete() {
            swalModal('success', ' ບັນທຶກຂໍ້ມູນສຳເລັດແລ້ວ...', 'Training');
        }

        function Search() {
            $('#<%: Stepper.ClientID %>').hide();
            var txt = document.getElementById('<%: txtSearch.ClientID %>').value;
            var index = $('.card:contains("' + txt + '")').index();
            $('.card:not(:contains("' + txt + '"))').hide('500');
            $('.card:contains("' + txt + '")').show();
            $('.some-list').simpleLoadMore({
                item: 'tr',
                count: 5,
                btnHTML: '<a id="btnMore" class="load-more__btn" hidden></a>'
            });
            if (txt == '') {
                window.location.reload();
            }
        }

        function InsertTraining() {
            var action = document.getElementById('<%: txtTrainingID.ClientID %>').name;
            var id = document.getElementById('<%: txtTrainingID.ClientID %>').value;
            var title = document.getElementById('<%: txtTitle.ClientID %>').value;
            var course_id = $("#<%: selCourseID.ClientID %>").val();
            var training_address = document.getElementById('<%: txtTriAddre.ClientID %>').value;
            var training_days = document.getElementById('<%: txtTridays.ClientID %>').value;
            var training_date = document.getElementById('<%: dtpDate.ClientID %>').value;
            let current_datetime = new Date()
            let formatted_date = current_datetime.getFullYear() + "-" + (current_datetime.getMonth() + 1) + "-" + current_datetime.getDate() + " " + current_datetime.getHours() + ":" + current_datetime.getMinutes() + ":" + current_datetime.getSeconds();
            var training_district = document.getElementById('<%: txtDistrict.ClientID %>').value;
            var training_province = document.getElementById('<%: txtProvince.ClientID %>').value;
            var description = document.getElementById('<%: txtDescription.ClientID %>').value;

            SetTraining(action, id, title, course_id, int_or_ext, training_address, training_district, training_province, training_days, training_date, description, formatted_date);
        }

        function SetTraining(action, id, title, course_id, int_or_ext, training_address, training_district, training_province,
            training_days, training_date, description, date_of_modified_data) {
            $.ajax({
                type: "POST",
                url: "<%: ResolveUrl("Training.aspx/SetTraining") %>",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{action:'" + action + "', id:'" + id + "', title:'" + title + "', course_id:'" + course_id + "', int_or_ext:'" + int_or_ext +
                    "', training_address:'" + training_address + "', training_district:'" + training_district + "', training_province:'" + training_province +
                    "', training_days:'" + training_days + "', training_date:'" + training_date + "', description:'" + description + "', date_of_modified_data:'" + date_of_modified_data + "'}",
                success: function (response) {
                    swalToast('success', response.d);
                },
                failure: function (response) {
                    swalModal('error', response.d, '');
                }
            });
        }

        function SetTrainerForTraining(action, id, trainer_id, training_id) {
            $.ajax({
                type: "POST",
                url: "<%: ResolveUrl("Training.aspx/SetTrainerForTraining") %>",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{action:'" + action + "', id:'" + id + "', trainer_id:'" + trainer_id + "', training_id:'" + training_id + "'}",
                success: function (response) {
                    //swalModal('success', response.d, '');
                },
                failure: function (response) {
                    swalModal('error', response.d, '');
                }
            });
        }

        function SetTraineeForTraining(action, id, trainee_id, training_id) {
            $.ajax({
                type: "POST",
                url: "<%: ResolveUrl("Training.aspx/SetTraineeForTraining") %>",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{action:'" + action + "', id:'" + id + "', trainee_id:'" + trainee_id + "', training_id:'" + training_id + "'}",
                success: function (response) {
                    //swalModal('success', response.d, '');
                },
                failure: function (response) {
                    swalModal('error', response.d, '');
                }
            });
        }

        function DelTraining(id, training_date) {
            Swal.fire({
                title: 'ທ່ານຕ້ອງການລົບຂໍ້ມູນນີ້ແທ້ຫຼືບໍ່?',
                text: "ບໍ່ສາມາດກູ້ຄືນໄດ້!",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes',
                cancelButtonText: 'No'
            }).then((result) => {
                if (result.value) {
                    SetTraining('del', id, '', '', '', '', '', '', '', training_date, '', '');
                    SetTrainerForTraining('del', '', '', id);
                    SetTraineeForTraining('del', '', '', id);
                    window.location.reload();
                }
            });
        }

        function SetTrainingInfo(id, training_id) {
            ClearTXT();
            $('#<%: Stepper.ClientID %>').show();
            $('html, body').animate({
                scrollTop: $('#<%: Stepper.ClientID %>').offset().top
            }, 'slow');
            if (id == "-1") {
                document.getElementById('<%: txtTrainingID.ClientID %>').name = "add";
            } else {
                document.getElementById('<%: txtTrainingID.ClientID %>').name = "edit";
                $.ajax({
                    type: "POST",
                    url: "<%: ResolveUrl("Training.aspx/GetTrainingInfo") %>",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{TrainingID:'" + id + "'}",
                    success: function (response) {
                        var obj = response.d;
                        document.getElementById('<%: txtTrainingID.ClientID %>').value = obj.id;
                        //alert(obj.id);
                        document.getElementById('<%: txtTitle.ClientID %>').value = obj.title;
                        document.getElementById('<%: txtTriAddre.ClientID %>').value = obj.training_address;
                        document.getElementById('<%: txtTridays.ClientID %>').value = obj.training_days;
                        document.getElementById('<%: dtpDate.ClientID %>').value = obj.training_date;
                        document.getElementById('<%: txtDistrict.ClientID %>').value = obj.training_district;
                        document.getElementById('<%: txtProvince.ClientID %>').value = obj.training_province;
                        document.getElementById('<%: txtDescription.ClientID %>').value = obj.description;
                        if (obj.int_or_ext == 'int') {
                            $('#<%: rdInternal.ClientID %>').prop('checked', true);
                            $('#<%: rdExternal.ClientID %>').prop('checked', false);
                            int_or_ext = 'int';
                        } else if (obj.int_or_ext == 'ext') {
                            $('#<%: rdInternal.ClientID %>').prop('checked', false);
                            $('#<%: rdExternal.ClientID %>').prop('checked', true);
                            int_or_ext = 'ext';
                        }
                        $("#<%: selCourseID.ClientID %>").val(obj.course_id);
                        $('select').formSelect();
                        M.updateTextFields();
                    },
                    failure: function (response) {
                        swalModal('error', response.d, '');
                    }
                });

                $.ajax({
                    type: "POST",
                    url: "<%: ResolveUrl("Training.aspx/GetTraineeByTrainings") %>",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{id:'" + training_id + "'}",
                    success: function (response) {
                        var obj = response.d;
                        $.each(obj,
                            function (key, value) {
                                SetSelect('Tnee', value.trainee_id);
                            });
                    },
                    failure: function (response) {
                        swalModal('error', response.d, '');
                    }
                });

                $.ajax({
                    type: "POST",
                    url: "<%: ResolveUrl("Training.aspx/GetTrainerByTrainings") %>",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{id:'" + training_id + "'}",
                    success: function (response) {
                        var obj = response.d;
                        $.each(obj,
                            function (key, value) {
                                SetSelect('Tner', value.trainer_id);
                            });
                    },
                    failure: function (response) {
                        swalModal('error', response.d, '');
                    }
                });
            }
        }

        function SetSelect(who, id) {
            if (who == 'Tner') {
                $('tr[id*="1Tner"]:has(input[value="' + id + '"])').hide('500');
                $('tr[id*="2Tner"]:has(input[value="' + id + '"])').show('500');
            } else if (who == 'Tnee') {
                $('tr[id*="1Tnee"]:has(input[value="' + id + '"])').hide('500');
                $('tr[id*="2Tnee"]:has(input[value="' + id + '"])').show('500');
            }
        }

        function ClearTXT() {
            document.getElementById('<%: txtTitle.ClientID %>').value = '';
            document.getElementById('<%: txtTriAddre.ClientID %>').value = '';
            document.getElementById('<%: txtTridays.ClientID %>').value = '';
            document.getElementById('<%: dtpDate.ClientID %>').value = '';
            document.getElementById('<%: txtTrainingID.ClientID %>').value = '';
            document.getElementById('<%: txtTrainingID.ClientID %>').name = '';
            document.getElementById('<%: txtDescription.ClientID %>').value = '';
            $("#<%: selCourseID.ClientID %>").val('');
            $('tr[id*="2Tner"]').hide();
            $('tr[id*="2Tnee"]').hide();
            $('tr[id*="1Tner"]').show();
            $('tr[id*="1Tnee"]').show();
            $('.some-list').simpleLoadMore({
                item: 'tr',
                count: 5,
                btnHTML: '<a id="btnMore" class="load-more__btn" hidden></a>'
            });
            M.updateTextFields();
        }

        function UUID() {
            var dt = new Date().getTime();
            var uuid = 'xxxxx-xx-5xxx-Rxxx-xxxxxxx'.replace(/[xy]/g, function (c) {
                var r = (dt + Math.random() * 16) % 16 | 0;
                dt = Math.floor(dt / 16);
                return (c == 'x' ? r : (r & 0x3 | 0x8)).toString(16);
            });
            return uuid;
        }

        function SetTrainingID() {
            var uuid = UUID();
            var status = document.getElementById('<%: txtTrainingID.ClientID %>').name;
            var tid = document.getElementById('<%: txtTrainingID.ClientID %>').value;
            //alert(status + ' | ' + tid);
            if (status == 'add' && tid == '') {
                document.getElementById('<%: txtTrainingID.ClientID %>').value = uuid;
            }
        }

        function Select(idHid, idSho) {
            var tner1 = '#' + idHid;
            var tner2 = '#' + idSho;
            var trainingid = document.getElementById('<%: txtTrainingID.ClientID %>').value;
            var trainerid = document.getElementById('i' + idHid).value;
            if (idHid.includes('Tner')) {
                SetTrainerForTraining('add', '0', trainerid, trainingid);
                $(tner1).hide('500');
                $(tner2).show('500');
            } else if (idHid.includes('Tnee')) {
                var courseID = $("#<%: selCourseID.ClientID %>").val();
                var _id;
                var _trainee_id;
                var _course_id;
                var _course_name;
                var _title;
                var _training_address;
                var _training_date;
                var _code;

                $.ajax({
                    async: false,
                    type: "POST",
                    url: "<%: ResolveUrl("Training.aspx/checkTraineeForTrainings") %>",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{trainee_id:'" + trainerid + "', course_id:'" + courseID + "'}",
                    success: function (response) {
                        var obj = response.d;
                        $.each(obj,
                            function (key, value) {
                                _id = value.id;
                                _trainee_id = value.trainee_id;
                                _course_id = value.course_id;
                                _course_name = value.course_name;
                                _title = value.title;
                                _training_address = value.training_address;
                                _training_date = value.training_date;
                                _code = value.code;
                            });
                    },
                    failure: function (response) {
                        swalModal('error', response.d, '');
                    }
                });

                var msg = "<div class='left'><h6>ບຸກຄົນນີ້ແມ່ນເຄີຍຜ່ານການອົບຮົມໃນຫຼັກສູດນີ້ແລ້ວ!</h6><br />ຫົວຂໍ້: " + _title + "<br />ຫຼັກສູດ: " + _course_name + "<br />ສະຖານທີ: " + _training_address + "<br />ວັນທີຈັດງານ: " + _training_date + "<br />code: e3</div>";

                if (_code == 'e3') {
                    swalModal('error', msg, '');
                } else {
                    SetTraineeForTraining('add', '0', trainerid, trainingid);
                    $(tner1).hide('500');
                    $(tner2).show('500');
                }
            }
        }

        function Disselect(idHid, idSho) {
            var tner1 = '#' + idSho;
            var tner2 = '#' + idHid;
            var trainingid = document.getElementById('<%: txtTrainingID.ClientID %>').value;
            var trainerid = document.getElementById('i' + idHid).value;
            if (idHid.includes('Tner')) {
                SetTrainerForTraining('del', '0', trainerid, trainingid);
            } else if (idHid.includes('Tnee')) {
                SetTraineeForTraining('del', '0', trainerid, trainingid);
            }
            $(tner1).show('500');
            $(tner2).hide('500');
        }

    </script>
    <%-- Customs JS --%>
</asp:Content>

function Search() {
    var txt = document.getElementById('<%: txtSearch.ClientID %>').value;
    var index = $('.carousel-item:contains("' + txt + '")').index();
    $(".carousel").carousel("set", index);
    $('.carousel-item').hide();
    $('.carousel-item:contains("' + txt + '")').show();
}

function ClearTxT() {
    document.getElementById("<%: txtID.ClientID %>").value = "";
    document.getElementById("<%: txtName.ClientID %>").value = "";
    document.getElementById("<%: txtfaminame.ClientID %>").value = "";
    document.getElementById("<%: dtpBD.ClientID %>").value = "";
    document.getElementById("<%: txtworkPlace.ClientID %>").value = "";
    document.getElementById("<%: txtPosition.ClientID %>").value = "";
    document.getElementById("<%: lblPicUrlPath.ClientID %>").innerText = "";
    document.getElementById("<%: txtUsername.ClientID %>").value = "";
    document.getElementById("<%: txtlv1.ClientID %>").value = "";
    document.getElementById("<%: txtlv2.ClientID %>").value = "";
    document.getElementById("<%: txtlv3.ClientID %>").value = "";
    document.getElementById("<%: txtlv4.ClientID %>").value = "";
    document.getElementById("<%: txtlv5.ClientID %>").value = "";
    document.getElementById("<%: profileImage.ClientID %>").src = "img/avatar.png";
    document.getElementById("<%: cbMale.ClientID %>").removeAttribute("checked");
    document.getElementById("<%: cbFamale.ClientID %>").removeAttribute("checked");
    M.updateTextFields();
}

function SetTrainerInfo(id) {
    var trainerID = id;
    if (trainerID == "-1") {
        ClearTxT();
    } else {
        $.ajax({
            type: "POST",
            url: '<%: ResolveUrl("Trainers.aspx / GetTrainerInfo") %>',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{TrainerID:" + trainerID + "}",
            success: function (response) {
                var obj = response.d;
                document.getElementById("<%: txtID.ClientID %>").value = obj.id;
                document.getElementById("<%: txtName.ClientID %>").value = obj.name;
                document.getElementById("<%: txtfaminame.ClientID %>").value = obj.faminame;
                document.getElementById("<%: dtpBD.ClientID %>").value = obj.date_of_birth;
                document.getElementById("<%: txtworkPlace.ClientID %>").value = obj.work_place;
                document.getElementById("<%: txtPosition.ClientID %>").value = obj.position;
                document.getElementById("<%: lblPicUrlPath.ClientID %>").innerText = obj.picture_url;
                document.getElementById("<%: txtUsername.ClientID %>").value = obj.userame;
                document.getElementById("<%: txtlv1.ClientID %>").value = obj.lv1;
                document.getElementById("<%: txtlv2.ClientID %>").value = obj.lv2;
                document.getElementById("<%: txtlv3.ClientID %>").value = obj.lv3;
                document.getElementById("<%: txtlv4.ClientID %>").value = obj.lv4;
                document.getElementById("<%: txtlv5.ClientID %>").value = obj.lv5;
                document.getElementById("<%: profileImage.ClientID %>").src = obj.picture_url.replace("~", "");
                if (obj.sex == "m") {
                    document.getElementById("<%: cbMale.ClientID %>").checked = "checked";
                }
                else if (obj.sex == "f") {
                    document.getElementById("<%: cbFamale.ClientID %>").checked = "checked";
                }
                else {
                    document.getElementById("<%: cbMale.ClientID %>").removeAttribute("checked");
                    document.getElementById("<%: cbFamale.ClientID %>").removeAttribute("checked");
                }
                M.updateTextFields();
            },
            failure: function (response) {
                alert(response.d);
            }
        });
    }
}
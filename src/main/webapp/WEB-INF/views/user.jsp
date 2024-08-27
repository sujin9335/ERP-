<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>

        <%@include file="include/link_js.jsp" %>
            <link rel="stylesheet" href="/css/user.css">
    </head>

    <body>
        <%@include file="include/header.jsp" %>
            <div class="container text-center">
                <div class="row">
                    <div class="col">
                        <h2>유저 관리</h2>
                    </div>
                </div>
            </div>

            <div class="p-5 mb-4 bg-body-tertiary rounded-3" id="main">
                <div class="container text-center">
                    <div class="row">
                        <div class="col px-5">
                            <div class="d-flex" role="search">
                                <select id="searchType">
                                    <option value="user_name">이름</option>
                                    <option value="user_login_id">아이디</option>
                                </select>
                                <input class="form-control" type="search" placeholder="검색" aria-label="Search"
                                    id="search">
                                <button class="btn btn-outline-success col-1" onclick="list(true);">검색</button>
                                <button class="btn btn-outline-success col-1" onclick="clearSearch()">초기화</button>
                                <div>
                                </div>
                                <div class="col-lg-2">
                                    <select id="limit" onchange="changeLimit()">
                                        <option value="5">5개씩 보기</option>
                                        <option value="10">10개씩 보기</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="container-fluid py-5 text-start">
                            <div id="total"></div>
                            <table class="table text-center" id="tab">
                                <thead>
                                    <tr>
                                        <th class="col-1" scope="col">번호</th>
                                        <th class="col-2" scope="col">이름</th>
                                        <th class="col-2" scope="col">ID</th>
                                        <th class="col-3" scope="col">Mail</th>
                                        <th class="col-2" scope="col">핸드폰번호</th>
                                        <th class="col-2" scope="col">잠금해제</th>
                                    </tr>
                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                        </div>

                        <div class="container text-center">
                            <div class="row">
                                <div class="col">
                                    <div style="display: flex; justify-content: center;" id="pag">
                                        <!-- <nav aria-label="Page navigation example">
                                <ul class="pagination">
                                    <li class="page-item">
                                        <a class="page-link" href="#" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                                    <li class="page-item">
                                        <a class="page-link" href="#" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav> -->
                                    </div>
                                </div>

                            </div>
                            <div class="container">
                                <div class="row">
                                    <div class="col text-end">
                                        <button type="button" class="btn btn-secondary" data-bs-toggle="modal"
                                            data-bs-target="#staticBackdrop" onclick="editInsert()">유저 등록</button>
                                    </div>
                                </div>
                            </div>
                        </div>



                    </div>



                    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false"
                        tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered modal-custom">
                            <div class="modal-content">

                                <div class="modal-body">
                                    <div class="container text-center" id="modal">
                                        <div class="row">

                                            <div class="col-2 pt-3">
                                                <h3>아이디</h3>
                                            </div>
                                            <div class="col-8 text-start px-4 pt-3 in-title" id="login_id">
                                                admin
                                            </div>

                                            <div class="col-1 editDel">
                                                <div id="id" style="display: none;"></div>
                                                <div id="flag" style="display: none;"></div>
                                            </div>

                                            <div class="col-1">
                                                <!-- <button type="button" class="btn btn-dark" data-bs-dismiss="modal" onclick="closeModal()">닫기</button> -->
                                                <button type="button" class="btn btn-dark"
                                                    data-bs-dismiss="modal">닫기</button>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-2 pt-3 pw" style="display: none;">
                                                <h3>비밀번호</h3>
                                            </div>
                                            <div class="col-10 text-start px-4 pt-3 in-title pw" id="pw"
                                                style="display: none;">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-2 pt-3">
                                                <h3>이름</h3>
                                            </div>
                                            <div class="col-10 text-start p-4 " id="name">
                                                김수진
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-2 pt-3">
                                                <h3>핸드폰번호</h3>
                                            </div>
                                            <div class="col-10 text-start p-4" id="tel">
                                                010-9335-6987
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-2 pt-3">
                                                <h3>이메일</h3>
                                            </div>
                                            <div class="col-10 text-start p-4" id="mail">
                                                sujin_78@naver.com
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-2 pt-3">
                                                <h3>권한</h3>
                                            </div>
                                            <div class="col-3 text-start p-4">
                                                <select class="form-select form-select-sm"
                                                    aria-label="Small select example" id="auth">
                                                    <option value="1" selected>일반유저</option>
                                                    <option value="0">관리자</option>
                                                </select>
                                            </div>
                                            <div class="col-2 pt-3 del">
                                                <h3>잠금해제</h3>
                                            </div>
                                            <div class="col-3 text-start p-4 form-switch del" id="use">
                                                <input class="form-check-input ms-4" type="checkbox" role="switch"
                                                    id="flexSwitchCheckDefault">
                                            </div>
                                            <div class="col-1 pt-2 btnDel">
                                                <button type="button" class="btn btn-info edit"
                                                    onclick="editUpdate()">수정</button>
                                            </div>
                                            <div id="chBtn" class="col-1 pt-2 btnDel">
                                                <button type="button" class="btn btn-warning"
                                                    onclick="del()">삭제</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                </div>

                <script>
                    //모달창 양식 저장
                    var form;

                    //검색조건boolean
                    var searchBool = false;

                    var page_current = 1; //현재 보고있는 페이지
                    var limit = 5; //몇개씩 볼건지

                    //검색어 저장
                    var searchInput = "";

                    window.onload = function () {
                        list();
                        checkBox();
                    };

                    // function enterkey() {
                    //     if (window.event.keyCode == 13) {
                    //         list(true);
                    //     }
                    // }

                    function list(search) {
                        var param = {};

                        if (search) {
                            searchBool = true;
                            page_current = 1;
                            searchInput = $("#search").val();
                        }

                        $("#tab tbody").empty();
                        param = {
                            offset: limit * (page_current - 1), //현재 보고있는 페이지
                            listSize: limit, // 가져올 데이터의 개수
                        };

                        if (searchBool) {
                            param.searchType = $("#searchType").val();
                            param.search = searchInput
                        }

                        console.log("param");
                        console.log(param);

                        $.ajax({
                            url: "/user/list",
                            type: "POST",
                            dataType: "json",
                            contentType: "application/json",
                            data: JSON.stringify(param),
                            success: function (result) {
                                //alert("통신성공");
                                console.log(result);

                                if (result.data.length > 0) {
                                    var totalPage = Math.ceil(result.total / limit);

                                    paging(page_current, totalPage);

                                    $("#total").text("총:" + result.total + "개")
                                    if (result.data.length > 0) {
                                        for (var i = 0; i < result.data.length; i++) {
                                            var index = i + 1 + param.offset;
                                            var tmp_tr = "<tr>" +
                                                "<td class='col-1' scope='row' data-bs-toggle='modal' data-bs-target='#staticBackdrop' onclick=get(" + result.data[i].user_id + ")>" + index + "</td>" +
                                                "<td class='col-2' scope='row' data-bs-toggle='modal' data-bs-target='#staticBackdrop' onclick=get(" + result.data[i].user_id + ")>" + result.data[i].user_name + "</td>" +
                                                "<td class='col-2' scope='row' data-bs-toggle='modal' data-bs-target='#staticBackdrop' onclick=get(" + result.data[i].user_id + ")>" + result.data[i].user_login_id + "</td>" +
                                                "<td class='col-3' scope='row' data-bs-toggle='modal' data-bs-target='#staticBackdrop' onclick=get(" + result.data[i].user_id + ")>" + result.data[i].user_mail + "</td>" +
                                                "<td class='col-2' scope='row' data-bs-toggle='modal' data-bs-target='#staticBackdrop' onclick=get(" + result.data[i].user_id + ")>" + result.data[i].user_tel + "</td>";
                                            if (result.data[i].user_use == 'y') {
                                                tmp_tr += "<td class='col-2 form-switch' scope='row'><input data-value=" + result.data[i].user_id + " class='form-check-input' type='checkbox' role='switch' id='flexSwitchCheckDefault' ></td>" +
                                                    "</tr>";
                                            } else {
                                                tmp_tr += "<td class='col-2 form-switch' scope='row'><input data-value=" + result.data[i].user_id + " class='form-check-input' type='checkbox' role='switch' id='flexSwitchCheckDefault' checked></td>" +
                                                    "</tr>";
                                            }

                                            $("#tab tbody").append(tmp_tr);
                                        }
                                    }
                                } else { //검색결과 없을경우
                                    var tmp_tr = "<tr>" +
                                        "<td colspan='6' >유저가 존재하지 않습니다</td>" +
                                        "</tr>";
                                    $("#tab tbody").append(tmp_tr);

                                    //페이징 초기화
                                    $("#pag").empty();
                                }

                                checkBox();

                            },
                            error: function () {
                                alert("통신에러");
                            }
                        });


                    }




                    //페이지 이동
                    function changePage(number, totalPage) {
                        if (number == 0 || number < 0) {
                            alert("첫번째 페이지입니다");
                            return;
                        }

                        if (number > totalPage) {
                            alert("마지막 페이지입니다");
                            return;
                        }

                        page_current = number;
                        list();
                    }



                    //검색어 초기화
                    function clearSearch() {
                        page_current = 1;
                        searchBool = false;
                        $("#searchType").val("user_name");
                        $("#search").val("");
                        list();
                    }

                    //몇개씩 보기 변경
                    function changeLimit() {
                        page_current = 1;
                        limit = parseInt($("#limit").val());
                        list(searchBool);
                    }

                    //상세 출력
                    function get(id) {
                        //기존양식 저장
                        form = $("#staticBackdrop").html();

                        var param = {
                            user_id: id
                        };

                        $.ajax({
                            url: "/user/get",
                            type: "POST",
                            dataType: "json",
                            contentType: "application/json",
                            data: JSON.stringify(param),
                            success: function (result) {
                                // alert("통신성공");
                                // console.log(result);


                                $("#id").text(result.data.user_id);
                                $("#login_id").text(result.data.user_login_id);
                                $("#name").text(result.data.user_name);
                                $("#tel").text(result.data.user_tel);
                                $("#mail").text(result.data.user_mail);

                                var auth = "";
                                if (result.data.user_auth == 0) {
                                    $("#auth").val("0").prop("disabled", true);
                                } else if (result.data.user_auth == 1) {
                                    $("#auth").val("1").prop("disabled", true);
                                }

                                var us = "";
                                if (result.data.user_use == 'y') {
                                    us = "<input data-value=" + result.data.user_id + " class='form-check-input ms-4' type='checkbox' role='switch' id='flexSwitchCheckDefault' checked>";
                                } else {
                                    us = "<input data-value=" + result.data.user_id + " class='form-check-input' type='checkbox' role='switch' id='flexSwitchCheckDefault' >";
                                }
                                $("#use").html(us);

                                checkBox();
                            },
                            error: function () {
                                alert("통신에러");
                            }
                        });

                    }

                    function del() {
                        var bool = confirm("삭제 하시겠습니까?");

                        if (!bool) {
                            return;
                        }
                        var param = {
                            user_id: $("#id").text().trim()
                        };

                        $.ajax({
                            url: "/user/del",
                            type: "POST",
                            dataType: "json",
                            contentType: "application/json",
                            data: JSON.stringify(param),
                            success: function (result) {
                                // alert("통신성공");
                                // console.log(result);
                                if(result.resultUser != 1 ) {
                                    alert("유저 DB 에러")
                                }

                                $("#staticBackdrop").modal('hide');
                                list();

                            },
                            error: function () {
                                alert("통신에러");
                            }
                        });


                    }

                    function editInsert() {
                        form = $("#staticBackdrop").html();

                        clearModal();
                        $("#flag").text("A");
                        $("#pw").append("<input type='password' class='w-80 d-block m-1' id='pw_ch1' placeholder='비밀번호'>");
                        $("#pw").append("<input type='password' class='w-80 m-1' id='pw_ch2' placeholder='비밀번호 확인'>");
                        $("#pw").append("<p id='pw_comp'></p>");

                        $("#id").html("");
                        var idChBtn = $("<button>").attr("id", "idCh").attr("onclick", "checkId();").addClass("btn btn-danger").html("중복체크");
                        $("#login_id").append(idChBtn);
                        $("#modal .del").html("");

                        checkPw();
                    }

                    function editUpdate() {
                        form = $("#staticBackdrop").html();

                        var user_login_id = $("#login_id").text().trim();
                        var user_name = $("#name").text().trim();
                        var user_tel = $("#tel").text().trim();
                        var user_mail = $("#mail").text().trim();
                        var user_auth = $("#auth").val();

                        clearModal();
                        $("#flag").text("B");
                        $("#pw").append("<input type='password' class='w-80 d-block m-1' id='pw_ch1' placeholder='새 비밀번호'>");
                        $("#pw").append("<input type='password' class='w-80 m-1' id='pw_ch2' placeholder='새 비밀번호 확인'>");
                        $("#pw").append("<p id='pw_comp'></p>");

                        $("#login_id input").val(user_login_id).prop("disabled", true);
                        $("#name input").val(user_name);
                        $("#tel input").val(user_tel);
                        $("#mail input").val(user_mail);
                        $("#auth").prop("disabled", false);

                        checkPw();

                    }


                    //글쓰기, 수정 모달 양식변경
                    // function edit(type) {

                    //     form = $("#staticBackdrop").html();

                    //     if (type == 1) {//수정

                    //         var user_login_id = $("#login_id").text().trim();
                    //         var user_name = $("#name").text().trim();
                    //         var user_tel = $("#tel").text().trim();
                    //         var user_mail = $("#mail").text().trim();
                    //         var user_auth = $("#auth").val();


                    //         clearModal();
                    //         $("#flag").text("B");
                    //         $("#pw").append("<input type='password' class='w-80 d-block m-1' id='pw_ch1' placeholder='새 비밀번호'>");
                    //         $("#pw").append("<input type='password' class='w-80 m-1' id='pw_ch2' placeholder='새 비밀번호 확인'>");
                    //         $("#pw").append("<p id='pw_comp'></p>");

                    //         $("#login_id input").val(user_login_id).prop("disabled", true);
                    //         $("#name input").val(user_name);
                    //         $("#tel input").val(user_tel);
                    //         $("#mail input").val(user_mail);
                    //         $("#auth").prop("disabled", false);




                    //     } else {//쓰기
                    //         clearModal();
                    //         $("#flag").text("A");
                    //         $("#pw").append("<input type='password' class='w-80 d-block m-1' id='pw_ch1' placeholder='비밀번호'>");
                    //         $("#pw").append("<input type='password' class='w-80 m-1' id='pw_ch2' placeholder='비밀번호 확인'>");
                    //         $("#pw").append("<p id='pw_comp'></p>");

                    //         $("#id").html("");
                    //         var idChBtn = $("<button>").attr("id", "idCh").attr("onclick", "idCheck();").addClass("btn btn-danger").html("중복체크");
                    //         $("#login_id").append(idChBtn);
                    //         $("#modal .del").html("");

                    //     }

                    //     checkPw();
                    // }

                    function insert() {
                        var url = "";
                        var param = {};

                        //입력값
                        var login_id = $("#login_id input").val();
                        var name = $("#name input").val();
                        var tel = $("#tel input").val();
                        var mail = $("#mail input").val();
                        var auth = $("#auth").val();
                        var pw = $("#pw_ch2").val();

                        //A 가입, B 수정
                        if ($("#flag").text() == 'A') {
                            url = "/user/insert";
                            //아이디
                            if ($("#idCh").text().trim() != "체크해제") {
                                $("#login_id input").focus();
                                alert("중복체크 확인");
                                return;
                            }
                            //비밀번호
                            if (!strCheck(pw, "pw")) {
                                $("#pw_ch2").focus();
                                return;
                            };

                            param = {
                                user_login_id: login_id,
                                user_pw: pw,
                                user_name: name,
                                user_tel: tel,
                                user_mail: mail,
                                user_auth: auth
                            };


                        } else if ($("#flag").text() == 'B') {
                            url = "/user/update";
                            //비밀번호
                            if ($("#pw_ch1").val() != "" || $("#pw_ch2").val() != "") {
                                if ($("#pw_comp").text().trim() != "비밀번호 일치") {
                                    alert("비밀번호 불일치");
                                    return;
                                }
                                if (!strCheck(pw, "pw")) {
                                    return;
                                };
                            }

                            param = {
                                user_id: $("#id").text().trim(),
                                user_pw: pw,
                                user_name: name,
                                user_tel: tel,
                                user_mail: mail,
                                user_auth: auth
                            }
                        }

                        //사전체크
                        //이름
                        if (!strCheck(name, "name")) {
                            $("#name input").focus();
                            return;
                        };
                        //폰번호
                        if (!strCheck(tel, "tel")) {
                            $("#tel input").focus();
                            return;
                        };
                        //메일
                        if (!strCheck(mail, "mail")) {
                            $("#mail input").focus();
                            return;
                        };

                        // console.log("param");
                        // console.log(param);

                        $.ajax({
                            url: url,
                            type: "POST",
                            dataType: "json",
                            contentType: "application/json",
                            data: JSON.stringify(param),
                            success: function (result) {
                                // alert("통신성공");
                                // console.log(result);
                                if(result.resultUser != 1 ) {
                                    alert("유저 DB 에러")
                                }

                                $("#staticBackdrop").modal('hide');
                                list(searchBool);

                            },
                            error: function () {
                                alert("통신에러");
                            }
                        });
                    }

                    function clearModal() {
                        $("#flag").html("");
                        $("#pw").html("");

                        $("#login_id").html("");
                        $("#name").html("");
                        $("#tel").html("");
                        $("#mail").html("");

                        var inner_input = "<input type='text' class='w-100'>";

                        $("#login_id").append("<input type='text' class='w-80'>");
                        $("#modal .pw").show();

                        $("#name").append(inner_input);
                        $("#tel").append("<input type='text' class='w-100' placeholder='010-1234-1234 형식으로 써주세요'>");
                        $("#mail").append(inner_input);

                        $("#modal .btnDel").html("");
                        var save = $("<button>").attr("onclick", "insert();").addClass("btn btn-info").html("저장");
                        $("#chBtn").append(save);
                    }


                    //모달창 닫히면 실행
                    $('#staticBackdrop').on('hidden.bs.modal', function () {
                        closeModal();
                    });

                    function closeModal() {
                        list(searchBool);
                        $("#staticBackdrop").empty();
                        $("#staticBackdrop").append(form);
                    }

                    //비밀번호 체크                    
                    function checkPw() {
                        $('#pw_ch2').on('input', function () {
                            // console.log($(this).val());
                            if ($('#pw_ch1').val() != $('#pw_ch2').val()) {
                                $("#pw_comp").text("비밀번호 불일치").css('color', 'red');
                            } else {
                                $("#pw_comp").text("비밀번호 일치").css('color', 'green');
                            }

                        });
                        $('#pw_ch1').on('input', function () {
                            // console.log($(this).val());
                            if ($('#pw_ch1').val() != $('#pw_ch2').val()) {
                                $("#pw_comp").text("비밀번호 불일치").css('color', 'red');
                            } else {
                                $("#pw_comp").text("비밀번호 일치").css('color', 'green');
                            }

                        });
                    }

                    //아이디 중복확인
                    function checkId() {
                        var login_id = $("#login_id input").val();
                        // alert(login_id);
                        if (!strCheck(login_id, "id")) {
                            return;
                        }

                        var param = {
                            user_login_id: login_id
                        }

                        $.ajax({
                            url: "/user/idCheck",
                            type: "POST",
                            dataType: "json",
                            contentType: "application/json",
                            data: JSON.stringify(param),
                            success: function (result) {
                                // alert("통신성공");
                                // console.log(result.cnt);

                                if (!result.cnt > 0) {
                                    $("#idCh").attr("id", "idCh").text("체크해제").removeClass().addClass("btn btn-success").attr("onclick", "clearCheckId();");
                                    $("#login_id input").prop("disabled", true);
                                } else {
                                    alert("중복된 아이디 입니다");
                                }

                            },
                            error: function () {
                                alert("통신에러");
                            }
                        });
                    }

                    //중폭체크 풀기
                    function clearCheckId() {
                        $("#idCh").attr("id", "idCh").attr("onclick", "checkId();").addClass("btn btn-danger").html("중복체크");
                        $("#login_id input").prop("disabled", false);
                    }



                    function checkBox() {
                        $("input[type='checkbox']").on("change", function () {
                            var id = $(this).attr("data-value");
                            var value = 0;

                            if ($(this).prop("checked")) {
                                value = 1; //체크
                            } else {
                                value = 0; //언체크
                            }

                            var param = {
                                user_id: id,
                                value: value
                            }
                            console.log(param);


                            $.ajax({
                                url: "/user/useChange",
                                type: "POST",
                                dataType: "json",
                                contentType: "application/json",
                                data: JSON.stringify(param),
                                success: function (result) {
                                    // alert("통신성공");
                                    console.log(result);
                                    if(result.resultUser != 1 ) {
                                        alert("유저 DB 에러")
                                    }



                                },
                                error: function () {
                                    alert("통신에러");
                                }
                            });
                        });
                    }


                </script>

    </body>

    </html>
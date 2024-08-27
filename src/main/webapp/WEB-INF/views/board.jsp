<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>

        <%@include file="include/link_js.jsp" %>


            <style>


            </style>
            <link rel="stylesheet" href="/css/main.css">
    </head>

    <body>
        <%@include file="include/header.jsp" %>
            <div class="container text-center">
                <div class="row">
                    <div class="col">
                        <h2>게시판</h2>
                    </div>
                </div>
            </div>

            <div class="p-5 mb-4 bg-body-tertiary rounded-3" id="main">
                <div class="container text-center">
                    <div class="row">
                        <div class="col px-5">
                            <div class="d-flex" role="search">
                                <select id="searchType">
                                    <option value="board_title">제목</option>
                                    <option value="user_id">글쓴이</option>
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

                    </div>
                </div>


                <div class="container-fluid py-5 w70">
                    <div id="total"></div>
                    <table class="table text-center" id="tab">
                        <thead>
                            <tr>
                                <th class="col-1" scope="col">번호</th>
                                <th class="col-2" scope="col">제목</th>
                                <th class="col-4" scope="col">내용</th>
                                <th class="col-2" scope="col">작성자</th>
                                <th class="col-1" scope="col">조회수</th>
                                <th class="col-2" scope="col">날짜</th>
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
                                    data-bs-target="#staticBackdrop" onclick="editInsert()">글쓰기</button>
                            </div>
                        </div>
                    </div>
                </div>



            </div>



            <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
                aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-custom">
                    <div class="modal-content">

                        <div class="modal-body">
                            <div class="container text-center" id="modal">
                                <div class="row">

                                    <div class="col-2 pt-3">
                                        <h3>제목</h3>
                                    </div>
                                    <div class="col-7 text-start px-4 pt-3 in-title" id="board_title">
                                        <input class="w-100" type="text">
                                    </div>
                                    <div class="col-1 editDel">
                                        <div id="board_id" style="display: none;">
                                            1
                                        </div>
                                    </div>
                                    <div class="col-1 editDel">
                                        <div>
                                            조회수
                                        </div>
                                        <div id="board_view">
                                            1
                                        </div>
                                    </div>
                                    <div class="col-1">
                                        <button type="button" class="btn btn-dark" data-bs-dismiss="modal"
                                            onclick="closeModal()">닫기</button>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-2 pt-3">
                                        <h3>내용</h3>
                                    </div>
                                    <div class="col-10 text-start p-4 hi300 in-content" id="board_content">
                                        <div id="contt">

                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-2 ">
                                        <h3>글쓴이</h3>
                                    </div>
                                    <input type="hidden" id="user_id">
                                    <div class="col-10 text-start ps-4 pt-2" id="id">
                                        2
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-2">
                                        <h3>첨부파일</h3>
                                    </div>
                                    <div class="col-8" id="files">
                                        <input id="file" type="file" multiple="multiple">
                                    </div>
                                    <div class="col-1 checkUser" >
                                        <button type="button" class="btn btn-info edit" onclick="editUpdate()">수정</button>
                                    </div>
                                    <div class="col-1 checkUser">
                                        <button type="button" class="btn btn-warning del" onclick="del()">삭제</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>








            </div>

            <script>
                //세션에 저장되어있는 유저정보
                var user_id = "<%= id %>";
                var auth = "<%= auth %>";

                //토스트 텍스트 에디터
                let editor;
                var in_content;
                //모달창 폼저장
                var form;

                //데이터 전송용 폼데이터
                var formData = new FormData();
                //첨부파일 저장 arr
                var fileArr = [];

                //검색 활성화 됐는지 확인
                var searchBool = false;

                //현재 페이지
                var page_current = 1;
                //한번에 볼페이지수
                var limit = 5;

                //검색어 저장
                var searchInput = "";


                window.onload = function () {
                    list();
                }



                function list(search) {
                    var param = {};
                    //폼초기화
                    formData = new FormData();
                    fileArr = [];

                    // $("#search").val("");

                    if (search) {
                        searchBool = true;
                        page_current = 1;
                        searchInput = $("#search").val();
                    }


                    param = {
                        offset: limit * (page_current - 1), //현재 보고있는 페이지
                        listSize: limit, // 가져올 데이터의 개수
                    };



                    if (searchBool) {
                        param.searchType = $("#searchType").val();
                        param.search = searchInput;
                    }


                    console.log("검색 확인");
                    console.log(search);
                    console.log(searchType);

                    $("#tab tbody").empty();



                    console.log("param");
                    console.log(param);

                    // if (search) {
                    //     searchBool=true;
                    //     param.searchType = $("#searchType").val();
                    //     param.search = $("#search").val();
                    // }

                    $.ajax({
                        url: "/board/list",
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        data: JSON.stringify(param),
                        success: function (result) {

                            if (result.data.length > 0) {
                                // alert("통신성공");

                                var totalPage = Math.ceil(result.total / limit);

                                //검색어 입력 후 최대 페이지 이상 선택시 1페이지로 이동 
                                // if (totalPage < current) {
                                //     page_current = 1;
                                //     list(true);
                                //     return;
                                // }

                                paging(page_current, totalPage);

                                $("#total").text("총:" + result.total + "개")
                                if (result.data.length > 0) {
                                    for (var i = 0; i < result.data.length; i++) {
                                        var index = i + 1 + param.offset;
                                        //에디터로 데이터를 받아오면 태그가 포함되있어 태그 제거 후 저장
                                        var content_temp = $('<div>').html(result.data[i].board_content).text();
                                        var tmp_tr = "<tr>" +
                                            "<td class='col-1' scope='row' data-bs-toggle='modal' data-bs-target='#staticBackdrop' onclick='get(" + result.data[i].board_id + ")'>" + index + "</td>" +
                                            "<td class=‘col-2’ scope=‘row’ data-bs-toggle='modal' data-bs-target='#staticBackdrop' onclick='get(" + result.data[i].board_id + ")'>" + result.data[i].board_title + "</td>" +
                                            "<td class=‘col-4’ scope=‘row’ data-bs-toggle='modal' data-bs-target='#staticBackdrop' onclick='get(" + result.data[i].board_id + ")'>" + content_temp + "</td>" +
                                            "<td class=‘col-2’ scope=‘row’ data-bs-toggle='modal' data-bs-target='#staticBackdrop' onclick='get(" + result.data[i].board_id + ")'>" + result.data[i].user_login_id + "</td>" +
                                            "<td class=‘col-1’ scope=‘row’ data-bs-toggle='modal' data-bs-target='#staticBackdrop' onclick='get(" + result.data[i].board_id + ")'>" + result.data[i].board_view + "</td>" +
                                            "<td class=‘col-2’ scope=‘row’ data-bs-toggle='modal' data-bs-target='#staticBackdrop' onclick='get(" + result.data[i].board_id + ")'>" + result.data[i].board_date + "</td>" +
                                            "</tr>";
                                        $("#tab tbody").append(tmp_tr);
                                    }
                                }

                            } else {
                                var tmp_tr = "<tr>" +
                                    "<td colspan='6' >게시글이 존재하지 않습니다</td>" +
                                    "</tr>";
                                $("#tab tbody").append(tmp_tr);

                                //페이징 초기화
                                $("#pag").empty();
                            }
                            in_content = "";
                            fileEditArr = "";
                        },
                        error: function () {
                            alert("통신에러");
                        }
                    });


                }

                //검색 초기화
                function clearSearch() {
                    page_current = 1;
                    searchBool = false;
                    $("#searchType").val("board_title");
                    $("#limit").val("5");
                    $("#search").val("");
                    list();
                }

                // function paging(current, totalPage) {

                //     $("#pag").empty();

                //     var prev = "";
                //     var page = "";
                //     var next = "";

                //     var addPrev = "";
                //     var addNext = "";

                //     //페이지 10이하 있을때 
                //     if (totalPage > 0) {
                //         if (totalPage < 11) {

                //             //처음or끝 페이지 일때 넘어가기 비활성화
                //             if (page_current != 1) {
                //                 addPrev = " <a class='page-link' href='#' onclick='pageCh(1);' aria-label='Previous'>" +
                //                     "<span aria-hidden='true'>&laquo;</span>" +
                //                     "</a>";
                //             } else {
                //                 addPrev = " <a class='page-link disabled' href='#' onclick='pageCh(1);' aria-label='Previous'>" +
                //                     "<span aria-hidden='true'>&laquo;</span>" +
                //                     "</a>";
                //             }
                //             if (page_current != totalPage) {
                //                 addNext = "<a class='page-link' href='#' aria-label='Next' onclick='pageCh(" + totalPage + ");'>" +
                //                     "<span aria-hidden='true'>&raquo;</span>" +
                //                     "</a>";
                //             } else {
                //                 addNext = "<a class='page-link disabled' href='#' aria-label='Next' onclick='pageCh(" + totalPage + ");'>" +
                //                     "<span aria-hidden='true'>&raquo;</span>" +
                //                     "</a>";
                //             }

                //             prev =
                //                 "<nav aria-label='Page navigation example'>" +
                //                 "<ul class='pagination'>" +
                //                 "<li class='page-item'>" +
                //                 addPrev +
                //                 "</li>"
                //                 ;
                //             for (var i = 1; i < totalPage + 1; i++) {
                //                 console.log(current);
                //                 if (current == i) {
                //                     page += "<li class='page-item'><a class='page-link active' href='#' onclick='pageCh(" + i + ");'>" + i + "</a></li>";
                //                 } else {
                //                     page += "<li class='page-item'><a class='page-link' href='#' onclick='pageCh(" + i + ");'>" + i + "</a></li>";
                //                 }
                //             }

                //             next = "<li class='page-item'>" +
                //                 addNext +
                //                 "</li>" +
                //                 "</ul>" +
                //                 "</nav>"
                //                 ;

                //             html = prev + page + next;

                //             $("#pag").append(html);

                //         } else {
                //             //preChar은 1~10 을 0, 11~20 을 1 ... 같이 페이징 처리하는 방법
                //             var preChar = "";
                //             if (String(current).substr(String(current).length - 1, 1) == "0") {
                //                 preChar = String(current - 10).slice(0, -1);
                //             } else {
                //                 preChar = String(current).slice(0, -1);
                //             }

                //             addPrev = 
                //                 "<li class='page-item'>" +
                //                 " <a class='page-link' href='#' onclick='pageCh(1);' aria-label='Previous'>" +
                //                 "<span aria-hidden='true'>&laquo;</span>" +
                //                 "</a>" +
                //                 "</li>" ;

                //             addPrev +=
                //                 "<li class='page-item'>" + 
                //                 " <a class='page-link' href='#' onclick='pageCh(" + (((Number(preChar) - 1) * 10) + 1) + ","+totalPage+");' aria-label='Previous'>" +
                //                 "<span aria-hidden='true'>&lt;</span>" +
                //                 "</a>"+
                //                 "</li>" ;


                //             prev =
                //                 "<nav aria-label='Page navigation example'>" +
                //                 "<ul class='pagination'>" +

                //                 addPrev

                //                 ;

                //             for (var i = 1; i < 11; i++) {
                //                 console.log(current);
                //                 //최대 페이지(totalPage) 까지만 만드는 조건
                //                 if ((Number(preChar) * 10 + i) < Number(totalPage) + 1) {
                //                     if (current == (Number(preChar) * 10 + i)) {
                //                         page += "<li class='page-item'><a class='page-link active' href='#' onclick='pageCh(" + (Number(preChar) * 10 + i) + ","+totalPage+");'>" + (Number(preChar) * 10 + i) + "</a></li>";
                //                     } else if (i == 10) {
                //                         page += "<li class='page-item'><a class='page-link' href='#' onclick='pageCh(" + ((Number(preChar) + 1) * 10) + ","+totalPage+");'>" + ((Number(preChar) + 1) * 10) + "</a></li>";
                //                     } else {
                //                         page += "<li class='page-item'><a class='page-link' href='#' onclick='pageCh(" + (Number(preChar) * 10 + i) + ","+totalPage+");'>" + (Number(preChar) * 10 + i) + "</a></li>";
                //                     }
                //                 } else {
                //                     break;
                //                 }
                //             }

                //             addNext = 

                //                 "<a class='page-link' href='#' aria-label='Next' onclick='pageCh(" + (((Number(preChar) + 1) * 10) + 1) + ","+totalPage+");'>" +
                //                 "<span aria-hidden='true'>&gt;</span>" +
                //                 "</a>" +
                //                 "</li>" ;

                //             addNext += 
                //                 "<li class='page-item'>" +
                //                 "<a class='page-link' href='#' aria-label='Next' onclick='pageCh(" + totalPage + ","+totalPage+");'>" +
                //                 "<span aria-hidden='true'>&raquo;</span>" +
                //                 "</a>" +
                //                 "</li>";


                //             next = 
                //                 addNext +
                //                 "</ul>" +
                //                 "</nav>"
                //                 ;

                //             html = prev + page + next;

                //             // console.log(html);

                //             $("#pag").append(html);


                //         }
                //     }
                // }

                //페이지 이동(보고싶은 페이지 ,총페이지)
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
                    //console.log(page_current);
                    list();
                }

                // 5, 10개 씩 보기 변경
                function changeLimit() {
                    page_current = 1;
                    limit = parseInt($("#limit").val());
                    //alert(limit);
                    list(searchBool);
                }

                //상세
                function get(id) {
                    $("#files").empty();

                    form = $("#staticBackdrop").html();
                    // alert("detail");

                    var param = {
                        board_id: id
                    };

                    $.ajax({
                        url: "/board/get",
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        data: JSON.stringify(param),
                        success: function (result) {
                            // alert("통신성공");
                            // var con=escapeHtml(result.data[0].board_content);

                            $("#board_id").text(result.data[0].board_id);
                            $("#board_title").text(unescapeHtml(result.data[0].board_title));
                            // $("#board_content").html(unescapeHtml(result.data[0].board_content));
                            toastuiEditorRead(result.data[0].board_content);
                            in_content = result.data[0].board_content;

                            $("#user_id").val(result.data[0].user_id);
                            $("#id").text(result.data[0].user_login_id);
                            $("#board_view").text(result.data[0].board_view);

                            //수정 삭제 관리 .. 관리자는 모두 가능
                            if (result.data[0].user_id != user_id && auth != 0) {
                                $(".checkUser").empty();
                            }


                            $.each(result.files, function (index, value) {
                                var temp = $("<div>").attr("id", value.file_id).attr("class", "fs");
                                var down = $("<div>").attr("onclick", "location.href='/board/fileDown/" + value.file_id + "'").attr("data-value", value.file_name + "." + value.file_extension)
                                    .text("첨부된 파일명: " + value.file_name + "." + value.file_extension);
                                var del = $("<button>").attr("onclick", "fileDel('b','" + value.file_id + "')").text("삭제").css("display", "none");
                                // var temp=$("<div>").attr("onclick", "fileDown("+value.file_id+");").text("파일");
                                // console.log(temp);

                                temp.append(down);
                                temp.append(del);
                                $("#files").append(temp);
                            });

                        },
                        error: function () {
                            alert("통신에러");
                        }
                    });


                }

                function editInsert() {
                    form = $("#staticBackdrop").html();
                    var uploadBtn = "<button id='uploadButton' onclick='fileInputClick()'>파일 업로드</button>"

                    inner_title = "";
                    inner_content = "";
                    inner_id = $("#user_id").html().trim();
                    in_content = "";

                    $("#user_id").val(user_id);
                    // $("#modal #id").text(login_id);

                    $("#modal .editDel").empty();

                    //초기화
                    $("#modal .in-title, #modal .in-content, #files").empty();

                    $("#modal .edit").hide();

                    $("#modal .del").attr("onclick", "insert();").html("저장");
                    var input_title = $("<input>").attr("type", "text").addClass("w-100");
                    var input_content = $("<div>").attr("id", "contt");
                    var input_file = $("<input>").attr("id", "file").attr("type", "file").attr("multiple", true).css('display', 'none');
                    var input_file_span = $("<span>").attr("id", "fileName").text("");
                    var add_file = $("<div>").attr("id", "addFile");

                    $("#modal .in-title").append(input_title);
                    $("#modal .in-content").append(input_content);
                    $("#files").append(input_file);
                    $("#files").append(uploadBtn);
                    $("#files").append(input_file_span);
                    $("#files").append(add_file);

                    toastuiEditor(in_content);
                }

                function editUpdate() {
                    form = $("#staticBackdrop").html();
                    var uploadBtn = "<button id='uploadButton' onclick='fileInputClick()'>파일 업로드</button>"

                    var inner_title = $("#modal .in-title").html().trim();
                    var inner_content = $("#modal .in-content").html().trim();
                    var inner_id = $("#user_id").val();
                    var inner_file = $("#files").html().trim();

                    // alert(inner_file);

                    //초기화
                    $("#modal .in-title, #modal .in-content, #files").empty();

                    $("#modal .edit").hide();

                    $("#modal .del").attr("onclick", "insert(" + inner_id + ");").html("저장");
                    var input_title = $("<input>").attr("type", "text").attr("id", "board_title").addClass("w-100").val(inner_title);
                    var input_content = $("<div>").attr("id", "contt");
                    var input_file = $("<input>").attr("id", "file").attr("type", "file").attr("multiple", true).css('display', 'none');
                    var input_file_span = $("<span>").attr("id", "fileName").text("");
                    var add_file = $("<div>").attr("id", "addFile");


                    $("#modal .in-title").append(input_title);
                    $("#modal .in-content").append(input_content);
                    $("#files").append(inner_file);
                    $("#files").append(input_file);
                    $("#files").append(uploadBtn);
                    $("#files").append(input_file_span);
                    $("#files button").css("display", "block");
                    $("#files").append(add_file);

                    $("#file").change(function () {
                        fileSelect()
                    });

                    toastuiEditor(in_content);
                }


                // function edit(type) { //글쓰기, 수정 모달 양식변경
                //     form = $("#staticBackdrop").html();
                //     // $("#files").empty();
                //     var uploadBtn = "<button id='uploadButton' onclick='fileInputClick()'>파일 업로드</button>"

                //     if (type == 1) {//수정

                //         var inner_title = $("#modal .in-title").html().trim();
                //         var inner_content = $("#modal .in-content").html().trim();
                //         var inner_id = $("#user_id").val();
                //         var inner_file = $("#files").html().trim();

                //         // alert(inner_file);

                //         //초기화
                //         $("#modal .in-title, #modal .in-content, #files").empty();

                //         $("#modal .edit").hide();

                //         $("#modal .del").attr("onclick", "insert(" + inner_id + ");").html("저장");
                //         var input_title = $("<input>").attr("type", "text").attr("id", "board_title").addClass("w-100").val(inner_title);
                //         var input_content = $("<div>").attr("id", "contt");
                //         var input_file = $("<input>").attr("id", "file").attr("type", "file").attr("multiple", true).css('display', 'none');
                //         var input_file_span = $("<span>").attr("id", "fileName").text("");
                //         var add_file = $("<div>").attr("id", "addFile");


                //         $("#modal .in-title").append(input_title);
                //         $("#modal .in-content").append(input_content);
                //         $("#files").append(inner_file);
                //         $("#files").append(input_file);
                //         $("#files").append(uploadBtn);
                //         $("#files").append(input_file_span);
                //         $("#files button").css("display", "block");
                //         $("#files").append(add_file);

                //         $("#file").change(function () {
                //             fileSelect()
                //         });

                //     } else {//쓰기
                //         inner_title = "";
                //         inner_content = "";
                //         inner_id = $("#user_id").html().trim();
                //         in_content = "";

                //         $("#user_id").val(user_id);
                //         $("#modal #id").text(login_id);

                //         $("#modal .editDel").empty();

                //         //초기화
                //         $("#modal .in-title, #modal .in-content, #files").empty();

                //         $("#modal .edit").hide();

                //         $("#modal .del").attr("onclick", "insert();").html("저장");
                //         var input_title = $("<input>").attr("type", "text").addClass("w-100");
                //         var input_content = $("<div>").attr("id", "contt");
                //         var input_file = $("<input>").attr("id", "file").attr("type", "file").attr("multiple", true).css('display', 'none');
                //         var input_file_span = $("<span>").attr("id", "fileName").text("");
                //         var add_file = $("<div>").attr("id", "addFile");

                //         $("#modal .in-title").append(input_title);
                //         $("#modal .in-content").append(input_content);
                //         $("#files").append(input_file);
                //         $("#files").append(uploadBtn);
                //         $("#files").append(input_file_span);
                //         $("#files").append(add_file);



                //     }
                //     conntt(in_content);
                // }


                //등록, 수정 id있을경우 수정
                function insert(id) {
                    //var files = $("#file")[0].files;

                    var param = {};

                    var maxSizeBytes = 3 * 1024 * 1024;//파일 최대 사이즈

                    //파일사이즈 확인
                    for (var i = 0; i < fileArr.length; i++) {
                        if (fileArr[i].size > maxSizeBytes) {
                            alert("파일 사이즈가 3MB를 초과하는 파일이 포함되어 있습니다.");
                            return;
                        }
                        // alert("파일추가됨");
                        formData.append("files", fileArr[i]); // "files"는 서버에서 받을 파일 이름(key값)
                    }

                    console.log("인서트 fileArr");
                    for (var i = 0; i < fileArr.length; i++) {
                        console.log(fileArr[i]);
                    }

                    for (var pair of formData.entries()) {
                        console.log("===인서트 폼데이터");
                        console.log(pair[0] + ', ' + pair[1].name + ', ' + pair[1].size + ' bytes');
                        console.log("인서트 폼데이터====");
                    }

                    var bool = confirm("작성 하시겠습니까?");

                    if (!bool) {
                        return;
                    }
                    if ($("#board_title input").val().trim() == '') {
                        alert("제목이 공백입니다")
                        return;
                    }
                    if ($("#board_title input").val().length > 10) {
                        alert("제목은 10글자 까지입니다")
                        return;
                    }

                    if (editor.getMarkdown().length > 300) {
                        alert("내용은 300글자 까지입니다")
                        return;
                    }

                    if (editor.getMarkdown().length < 1) {
                        alert('에디터 내용을 입력해 주세요.');
                        return
                    }

                    param = {
                        board_id: $("#board_id").text(),
                        user_id: $("#user_id").val(),
                        board_title: escapeHtml($("#board_title input").val()),
                        board_content: editor.getHTML()

                    };

                    var url;
                    if (id == undefined) {
                        url = "/board/insert"
                    } else {
                        url = "/board/update"
                        param.file_id = [];

                        $('#files .fs').each(function (index) {
                            var value = $(this).attr('id');
                            // console.log('Index: ' + index + ', data-value: ' + value);
                            param.file_id.push(value);
                        });


                    }

                    formData.append("param", JSON.stringify(param));

                    $.ajax({
                        url: url,
                        type: "POST",
                        contentType: false, // FormData를 사용하기 때문에 false로 설정
                        processData: false, // FormData를 직렬화하지 않도록 false로 설정
                        enctype: 'multipart/form-data',
                        data: formData,
                        success: function (result) {
                            console.log("");
                            console.log("인서트보드");
                            console.log(result);
                            console.log("");

                            
                            if(result.resultBoard != 1 ) {
                                alert("게시글 DB 에러")
                            }
                            if(result.resultFileInsert != 1 && result.resultFileInsert != 0) {
                                alert("파일 DB 에러")
                            }
                            if(result.resultFileDel != undefined) {
                                if(result.resultFileDel != 1 && result.resultFileDel != 0) {
                                    alert("파일삭제 DB 에러")
                                }
                            }
                            // 파일 업로드 성공 시 추가적인 처리 작업
                            $("#staticBackdrop").modal('hide');

                            closeModal();
                        },
                        error: function () {
                            alert("통신 에러");
                        }
                    });
                }

                function del() {
                    var bool = confirm("삭제 하시겠습니까?");

                    if (!bool) {
                        return;
                    }
                    var param = {
                        board_id: $("#board_id").text().trim()
                    };

                    $.ajax({
                        url: "/board/del",
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        data: JSON.stringify(param),
                        success: function (result) {
                            // alert("통신성공");
                            // console.log("");
                            // console.log("삭제보드");
                            // console.log(result);
                            // console.log("");

                            if(result.resultBoard != 1 ) {
                                alert("게시글 DB 에러")
                            }

                            $("#staticBackdrop").modal('hide');
                            list();

                        },
                        error: function () {
                            alert("통신에러");
                        }
                    });
                }

                //모달창 닫기 실행
                function closeModal() {
                    list(searchBool);
                    $("#staticBackdrop").empty();
                    $("#staticBackdrop").append(form);
                }

                //토스트 에디터 설정
                function toastuiEditor(inner_content) {
                    //초기내용값 설정
                    inner_content.length > 0 ? $('#contt').html(inner_content) : $('#contt').html('');

                    editor = new toastui.Editor({
                        el: document.querySelector('#contt'), // 에디터를 적용할 요소 (컨테이너)
                        height: '400px',                        // 에디터 영역의 높이 값 (OOOpx || auto)
                        initialEditType: 'wysiwyg',            // 최초로 보여줄 에디터 타입 (markdown || wysiwyg)
                        // initialValue: content,     // 내용의 초기 값으로, 반드시 마크다운 문자열 형태여야 함
                        previewStyle: 'vertical'                // 마크다운 프리뷰 스타일 (tab || vertical)
                    });


                }

                //읽기전용
                function toastuiEditorRead(inner_content) {
                    //초기내용값 설정
                    inner_content.length > 0 ? $('#contt').html(inner_content) : $('#contt').html('');

                    editor = new toastui.Editor.factory({
                        el: document.querySelector('#contt'), // 에디터를 적용할 요소 (컨테이너)
                        height: '400px',                        // 에디터 영역의 높이 값 (OOOpx || auto)
                        initialEditType: 'wysiwyg',
                        initialValue: inner_content,
                        viewer: true
                    });


                }


                // function inputFile() {
                //     var files = $("#file")[0].files; // 파일 인풋에서 첫 번째 파일 가져오기
                //     var formData = new FormData();


                //     var maxSizeBytes = 3 * 1024 * 1024;//파일 최대 사이즈

                //     for (var i = 0; i < files.length; i++) {
                //         console.log(files[i].size);
                //         if (files[i].size > maxSizeBytes) {
                //             alert("파일 사이즈가 3MB를 초과하는 파일이 포함되어 있습니다.");
                //             return;
                //         }
                //         // alert("파일추가됨");
                //         formData.append("files", files[i]); // "files"는 서버에서 받을 파일 파라미터 이름
                //     }
                //     console.log("파일확인");
                //     for (var pair of formData.entries()) {
                //         var key = pair[0]; // key는 formData에 append된 이름 ("files")
                //         var value = pair[1]; // value는 각 파일 객체

                //         if (value instanceof File) {
                //             console.log("File name:", value.name);
                //             console.log("File size:", value.size);
                //             console.log("File type:", value.type);
                //             console.log("Last modified date:", value.lastModifiedDate);
                //             console.log("==========");
                //         }
                //     }

                //     $.ajax({
                //         url: "/board/fileUpload",
                //         type: "POST",
                //         contentType: false, // FormData를 사용하기 때문에 false로 설정
                //         processData: false, // FormData를 직렬화하지 않도록 false로 설정
                //         enctype: 'multipart/form-data',
                //         data: formData,
                //         success: function (result) {
                //             console.log(result);
                //             // 파일 업로드 성공 시 추가적인 처리 작업
                //         },
                //         error: function () {
                //             alert("통신 에러");
                //         }
                //     });

                // }

                //파일 다운 
                // function fileDown(file_id) {
                //     var param = {
                //         file_id: file_id
                //     };

                //     $.ajax({
                //         url: "/board/fileDown",
                //         type: "POST",
                //         dataType: "json",
                //         contentType: "application/json",
                //         data: JSON.stringify(param),
                //         success: function (result) {
                //             console.log(result);
                //         },
                //         error: function () {
                //             alert("통신 에러");
                //         }
                //     });

                // }

                //모달 실행됐을때 처리
                $('#staticBackdrop').on('shown.bs.modal', function () {
                    $("#file").change(function () {
                        fileSelect()
                    });
                });


                //formData 데이터에 데이터 넣기
                var count = 0;
                function fileSelect() {
                    var files = $("#file")[0].files;

                    //파일 중복확인
                    for (var i = 0; i < files.length; i++) {
                        var fileName = files[i].name;
                        // console.log("선택된파일");
                        // console.log(files[i].size);

                        //수정시 기존파일로 생성된 div 태그와 이름 중복확인
                        $('#files div').each(function () {
                            var dataValue = $(this).attr('data-value');
                            // console.log(dataValue);
                            if (dataValue == fileName) {
                                $("#file").val('');
                                alert("첨부된 파일에 중복된 파일이있습니다");
                                return;
                            }
                        });

                        //기존 선택되서 fileArr에 올라와있는 파일명 중복확인
                        for (var j = 0; j < fileArr.length; j++) {
                            // console.log("@@@@@@@@@@@@@@@@");
                            // console.log("파일 어레이 목록: " +fileArr[j].name);
                            // console.log("@@@@@@@@@@@@@@@@");
                            if (fileArr[j].name == fileName) {
                                $("#file").val('');
                                alert("중복된 파일명입니다");
                                return;
                            }
                        }
                        // alert("파일추가됨");


                    }

                    //중복처리후 넣어야 중간에 삽입되고 끝나는걸 방지
                    for (var i = 0; i < files.length; i++) {
                        var fileName = files[i].name;
                        var fileInfo = $("<div>").attr("id", "f" + count).text("파일명: " + fileName + " 파일크기: " + files[i].size + "바이트");
                        var del = $("<button>").attr("onclick", "fileDel('a','" + count + "' , '" + fileName + "')").text("삭제");
                        $("#addFile").append(fileInfo);
                        fileInfo.append(del);
                        fileArr.push(files[i]);
                        count++;
                    }

                    //fileArr 파일 확인
                    console.log("===============");
                    console.log("fileArr확인");
                    // alert(fileArr.length);

                    for (var i = 0; i < fileArr.length; i++) {
                        console.log(fileArr[i]);
                    }
                    console.log("===============");


                    $("#file").val('');
                }

                //파일 목록에서 지우기
                function fileDel(type, id, name) {

                    if (type == 'a') {
                        for (var i = 0; i < fileArr.length; i++) {
                            if (fileArr[i].name == name) {
                                fileArr.splice(i, 1);
                            }
                        }
                        $("#files #f" + id).remove();
                    }

                    if (type == 'b') {
                        $("#files #" + id).remove();
                    }

                }

                //버튼 클릭시 (input file 실행)
                function fileInputClick() {
                    $('#file').click();
                }



                //이전 파일 삽입&삭제
                // function fileSelect() {
                //     $("#addFile").empty();
                //     var files = $("#file")[0].files;

                //     for (var i = 0; i < files.length; i++) {
                //         // console.log("선택된파일");
                //         // console.log(files[i].size);
                //         var fileName = files[i].name;
                //         var fileInfo = $("<div>").attr("id", "f" + i).text("파일명: " + fileName + " 파일크기: " + files[i].size + "바이트");
                //         var del = $("<button>").attr("onclick", "fileDel('a','" + i + "' , '" + fileName + "')").text("삭제");
                //         $("#addFile").append(fileInfo);
                //         fileInfo.append(del);

                //         // alert("파일추가됨");
                //     }
                // }

                // function fileDel(type, id, name) {
                //     var dataTransfer = new DataTransfer();
                //     var files = $("#file")[0].files;

                //     if (type == 'a') { //인풋파일에 있는것 삭제
                //         for (var i = 0; i < files.length; i++) {
                //             if (files[i].name !== name) {
                //                 dataTransfer.items.add(files[i]);
                //                 // console.log("비교");
                //                 // console.log(files[i].name);
                //                 // console.log(name);
                //                 // console.log();
                //             }
                //         }
                //         $("#file")[0].files = dataTransfer.files;
                //         $("#files #f" + id).remove();
                //     }

                //     if (type == 'b') {
                //         $("#files #" + id).remove();
                //     }

                // }




            </script>
    </body>

    </html>
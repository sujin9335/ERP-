//정규식 사용 문자체크(확인문자, (id, pw, mail, tel), 몇글자, 쓰일곳)
function strCheck(str, type, number, title) {

    if (type == "id") {
        if (!/^[A-Za-z0-9][A-Za-z0-9]*$/.test(str)) {
            alert("아이디는 영어, 숫자만 가능합니다");
            return false;
        }
        if (str.length > 8) {
            alert("아이디는 8글자 이하만 가능합니다");
            return false;
        }
    }

    if (type == "pw") {
        if (!/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{4,}$/.test(str)) {
            alert("비밀번호 4글자 이상, 영문, 숫자, 특수문자 사용");
            return false;
        }
        if (str.length > 16) {
            alert("비밀번호는 16글자 이하만 가능합니다");
            return false;
        }
    }

    if (type == "tel") {
        if (!/^01(?:0|1|[6-9])-(?:\d{4})-\d{4}$/.test(str)) {
            alert("핸드폰 번호에 문제가 있습니다");
            return false;
        }
    }

    if (type == "mail") {
        if (!/^[\w.%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/.test(str)) {
            alert("이메일 주소에 문제가 있습니다");
            return false;
        }
    }

    if (type == "name") {
        if (str.length > 10) {
            alert("이름은 10글자 이하입니다");
            return false;
        }
        if (!/^[A-Za-z가-힣]+$/.test(str)) {
            alert("이름은 한글, 영어만 사용가능합니다(특수기호, 공백사용불가");
            return false;
        }
    }

    if (type == "comm") {
        if (str == "") {
            alert(title + "에 공백은 사용불가입니다");
            return false;
        }

        if (str.length > number) {
            alert(title + "은 " + number + "글자 이하입니다");
            return false;
        }
    }

    if (type == "check") {
        if (str == "") {
            alert(title + "를 입력해주세요");
            return false;
        }
    }


    return true;
}

function escapeHtml(text) {
    return text
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
}

function unescapeHtml(text) {
    return text
        .replace(/&amp;/g, "&")
        .replace(/&lt;/g, "<")
        .replace(/&gt;/g, ">")
        .replace(/&quot;/g, "\"")
        .replace(/&#039;/g, "'");
}

//페이지네이션
function paging(current, totalPage) {
    //페이지 초기화
    $("#pag").empty();

    var prev = "";
    var page = "";
    var next = "";

    var addPrev = "";
    var addNext = "";

    if (totalPage > 0) {
        if (totalPage < 11) {

            //<< >> 끝일경우 클릭 비활성화
            if (page_current != 1) {
                addPrev = " <a class='page-link' href='#' onclick='changePage(1);' aria-label='Previous'>" +
                    "<span aria-hidden='true'>&laquo;</span>" +
                    "</a>";
            } else {
                addPrev = " <a class='page-link disabled' href='#' onclick='changePage(1);' aria-label='Previous'>" +
                    "<span aria-hidden='true'>&laquo;</span>" +
                    "</a>";
            }
            if (page_current != totalPage) {
                addNext = "<a class='page-link' href='#' aria-label='Next' onclick='changePage(" + totalPage + ");'>" +
                    "<span aria-hidden='true'>&raquo;</span>" +
                    "</a>";
            } else {
                addNext = "<a class='page-link disabled' href='#' aria-label='Next' onclick='changePage(" + totalPage + ");'>" +
                    "<span aria-hidden='true'>&raquo;</span>" +
                    "</a>";
            }


            prev =
                "<nav aria-label='Page navigation example'>" +
                "<ul class='pagination'>" +
                "<li class='page-item'>" +
                addPrev +
                "</li>"
                ;
            for (var i = 1; i < totalPage + 1; i++) {
                console.log(current);
                if (current == i) {
                    page += "<li class='page-item'><a class='page-link active' href='#' onclick='changePage(" + i + ");'>" + i + "</a></li>";
                } else {
                    page += "<li class='page-item'><a class='page-link' href='#' onclick='changePage(" + i + ");'>" + i + "</a></li>";
                }
            }

            next = "<li class='page-item'>" +
                addNext +
                "</li>" +
                "</ul>" +
                "</nav>"
                ;

            html = prev + page + next;

            $("#pag").append(html);

        } else { //10페이지 넘어갔을때 처리방법
            //preChar은 1~10 을 0, 11~20 을 1 ... 같이 페이징 처리하는 방법
            var preChar = "";
            if (String(current).substr(String(current).length - 1, 1) == "0") {
                preChar = String(current - 10).slice(0, -1);
            } else {
                preChar = String(current).slice(0, -1);
            }

            addPrev =
                "<li class='page-item'>" +
                " <a class='page-link' href='#' onclick='changePage(1);' aria-label='Previous'>" +
                "<span aria-hidden='true'>&laquo;</span>" +
                "</a>" +
                "</li>";

            addPrev +=
                "<li class='page-item'>" +
                " <a class='page-link' href='#' onclick='changePage(" + (((Number(preChar) - 1) * 10) + 1) + "," + totalPage + ");' aria-label='Previous'>" +
                "<span aria-hidden='true'>&lt;</span>" +
                "</a>" +
                "</li>";

            prev =
                "<nav aria-label='Page navigation example'>" +
                "<ul class='pagination'>" +

                addPrev

                ;

            for (var i = 1; i < 11; i++) {
                console.log(current);
                //최대 페이지(totalPage) 까지만 만드는 조건
                if ((Number(preChar) * 10 + i) < Number(totalPage) + 1) {
                    if (current == (Number(preChar) * 10 + i)) {
                        page += "<li class='page-item'><a class='page-link active' href='#' onclick='changePage(" + (Number(preChar) * 10 + i) + "," + totalPage + ");'>" + (Number(preChar) * 10 + i) + "</a></li>";
                    } else if (i == 10) {
                        page += "<li class='page-item'><a class='page-link' href='#' onclick='changePage(" + ((Number(preChar) + 1) * 10) + "," + totalPage + ");'>" + ((Number(preChar) + 1) * 10) + "</a></li>";
                    } else {
                        page += "<li class='page-item'><a class='page-link' href='#' onclick='changePage(" + (Number(preChar) * 10 + i) + "," + totalPage + ");'>" + (Number(preChar) * 10 + i) + "</a></li>";
                    }
                } else {
                    break;
                }
            }

            addNext =

                "<a class='page-link' href='#' aria-label='Next' onclick='changePage(" + (((Number(preChar) + 1) * 10) + 1) + "," + totalPage + ");'>" +
                "<span aria-hidden='true'>&gt;</span>" +
                "</a>" +
                "</li>";

            addNext +=
                "<li class='page-item'>" +
                "<a class='page-link' href='#' aria-label='Next' onclick='changePage(" + totalPage + "," + totalPage + ");'>" +
                "<span aria-hidden='true'>&raquo;</span>" +
                "</a>" +
                "</li>";

            next =
                addNext +
                "</ul>" +
                "</nav>"
                ;

            html = prev + page + next;

            $("#pag").append(html);


        }
    }


}



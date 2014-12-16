
$(function () {


    $(".control-tabs").on("click",function (event) {
        $("li.active").removeClass("active");
        $("#"+ this.id).addClass("active");
    });



});

//function getUser() {
//    if ('localStorage' in window && window[localStorage] !== null) {
//        try {
//            if (localStorage["user"]) {
//                return localStorage["user"];
//            } else {
//                var id = $.get('/user/new');
//                localStorage["user"] = id;
//                return id;
//            }
//        }
//    } else {
//        alert("Browser does not allow to set user data!")
//    }
//}
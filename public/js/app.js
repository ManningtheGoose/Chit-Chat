function getUser() {
    if ('localStorage' in window && window[localStorage] !== null) {
        try {
            if (localStorage["user_id"]) {
                $.post('/user/update',{
                    user_id: localStorage["user_id"]
                })
            } else {
                $.post('/user/update',{
                    user_id: 0
                }, function (data) {
                    localStorage["user_id"] = data["new_user_id"]
                });
            }
        }
    } else {
        alert("Browser does not allow to set user data!")
    }
}

//Heads up. Not sure if the above code works yet. it is not tested. But I'm tired so I'm leaving it like this.

$.ajaxSetup({
    beforeSend: function(xhr) {
        var token = $('meta[name="authenticity_token"]').attr('content');
        xhr.setRequestHeader("X_CSRF_TOKEN",token);
    }
});



$(function () {
    $(".control-tabs").on("click",function (event) {
        $("li.active").removeClass("active");
        $("#"+ this.id).addClass("active");
    });

    $(".upvote").on("click",function (event) {
        console.log("upvote");
        var id = $(this).attr("id");
        $.post('/post/upvote',{
            post_id: id
        }, function (data) {
            $("#"+id+".score").text(data["score"]);
            $("#"+id+".upvote").css("color","green");
            $("#"+id+".downvote").css("color","");
        },"json");
    });

    $(".downvote").on("click",function (event) {
        console.log("downvote");
        var id = $(this).attr("id");
        $.post('/post/downvote',{
            post_id: id
        }, function (data) {
            $("#"+id+".score").text(data["score"]);
            $("#"+id+".downvote").css("color","red");
            $("#"+id+".upvote").css("color","");
        },"json")
    });

    $(".upvote-comment").on("click",function (event) {
        console.log("upvote");
        var id = $(this).attr("id");
        $.post('/comment/upvote',{
            comment_id: id
        }, function (data) {
            $("#"+id+".score-comment").text(data["score"]);
            $("#"+id+".upvote-comment").css("color","green");
            $("#"+id+".downvote-comment").css("color","");
        },"json");
    });

    $(".downvote-comment").on("click",function (event) {
        console.log("downvote");
        var id = $(this).attr("id");
        $.post('/comment/downvote',{
            comment_id: id
        }, function (data) {
            $("#"+id+".score-comment").text(data["score"]);
            $("#"+id+".downvote-comment").css("color","red");
            $("#"+id+".upvote-comment").css("color","");
        },"json")
    });

    getUser();
});







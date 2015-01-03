$.ajaxSetup({
    beforeSend: function(xhr) {
        var token = $('meta[name="authenticity_token"]').attr('content');
        xhr.setRequestHeader("X_CSRF_TOKEN",token);
    }
});

$(function () {
    $("#submit-post").addClass("disabled");

    $(".control-pills").on("click",function (event) {
        $("li.active.order").removeClass("active");
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

    $("#submit-post").on("click", function (event) {

        $("#location-status").text("Posting...");

        event.preventDefault();

        if ("geolocation" in navigator) {

            navigator.geolocation.getCurrentPosition(function (position) {

                var latitude = position.coords.latitude;
                var longitude = position.coords.longitude;
                console.log(latitude);
                console.log(longitude);

                $("#latitude").attr('value',latitude);
                $("#longitude").attr('value',longitude);

                $("#post-form").submit();

            }, function () {

                alert("unable to fetch your current location");
                $("#location-status").text("Post Failed");
                return false
            })

        } else {
            alert("cannot get location!");
            $("#location-status").text("Post Failed");
            return false
        }
    });

    var height = $("#order-select").css("height");
    var position = $("#order-select").css("margin-top");

    console.log(height);
    console.log(position);

    $(".delete-btn").on("click",function (event) {
        console.log("delte");
        console.log(this.id);
       $("#"+ this.id+".delete-form").submit();
    });
});

function refreshLocation (old_lat,old_long) {
    $("#location-status").text("Locating...");

    if ("geolocation" in navigator) {
        navigator.geolocation.getCurrentPosition(function (position) {
            var latitude = position.coords.latitude;
            var longitude = position.coords.longitude;
            console.log(latitude);
            console.log(longitude);

            $("#user-latitude").attr('value',latitude);
            $("#user-longitude").attr('value',longitude);

            if (latitude != old_lat || longitude != old_long) {
                $("#location-form").submit();
            }

            $("#submit-post").removeClass("disabled");
            $("#location-status").text("Located!");


        }, function () {
            alert("unable to fetch your current location");
            $("#location-status").text("Couldn't get Location");
        })
    } else {
        alert("your browser does not support location!");
        $("#location-status").text("Couldn't get Location");
    }
}
$(document).on("turbolinks:load", function () {
  $("#card-preview").click(function(){
    previewCard();
  });
});

function previewCard() {
  var text = $("#card-description").val();
  if ( text )
    $(".preview").html(marked(text))
  else
    $(".preview").html("Nothing to preview...");
}

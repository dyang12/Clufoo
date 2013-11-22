$(document).ready(function() {
	$("button.new").on("click", function() {
		var formId = $("table.table-header").attr("data-id");

		$.ajax({
				url: "/forms/" + formId + "/entries/new",
				type: "get",
				success: function(data) {
					var form = data.substring(data.indexOf("<div class=\"entry-form\""), data.lastIndexOf("</form>")) +"</form></div>";
					form = form.replace("entry-form", "entry-form-short");
					$(".inline-block").html(form);
				}
			});
	});
	
	$("button.edit").on("click", function() {
		var id = $(".entry-form-short").attr("data-id");
		
		$.ajax({
			url: "/entries/" + id + "/edit",
			type: "get",
			success: function(data) {
				var form = data.substring(data.indexOf("<div class=\"entry-form\""), data.lastIndexOf("</form>")) +"</form></div>";
				form = form.replace("entry-form", "entry-form-short");
				$("div.span7").html(form);
			}
		});
	});
	
	$("button.email").on("click", function() {
		
	});
	
	$("button.delete").on("click", function() {
		var id = $(".entry-form-short").attr("data-id");
		
		$.ajax({
			url: "/entries/" + id,
			type: "post",
			data: {"_method":"delete"},
			success: function(data) {
				page = data.substring(data.indexOf("<body>"), data.indexOf("</html>"));
				$("body").html(page);
			}
		});
	});
});
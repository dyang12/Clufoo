$(document).ready(function() {
  $('#new-entry').on('click', function(event) {
  	event.preventDefault();
		
		var formId = $("table.table-header").attr("data-id");
		
		$.ajax({
			url: "/forms/" + formId + "/entries/new",
			type: "get",
			success: function(data) {
				var form = data.substring(data.indexOf("<div class=\"entry-form\""), data.lastIndexOf("</form>")) +"</form></div>";
				form = form.replace("entry-form", "entry-form-short");
				$("#entry-view").html(form);
			}
		});
  });
	
	$('.entry-table').on('click', 'tr', function(event) {
		
		var id = $(event.currentTarget).attr("data-id");
		var entrySidebar = JST['entry_sidebar'];
		
		$.ajax({
			url: "/entries/" + id,
			type:"get",
			success: function(data) {
				var form = data.substring(data.indexOf("<div class=\"entry-form\""), data.lastIndexOf("</div>"));
				form = form.substring(0, form.indexOf("</div>")).replace("entry-form", "entry-form-short");
				$("#entry-view").empty();
				$("#entry-view").html("<div class=\"span7\">" + form + "</div></div><div class=\"span4\">" + entrySidebar() + "</div>");
			}
		});
	});
});
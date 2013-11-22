$(document).ready(function() {
	$("#field-<%= id %>").on("submit", function(event) {
		event.preventDefault();
		
		var data = $(event.target).serializeJSON();
		field = data.field_<%= id %>;
		$("li.field-<%= id %> label.bold").text(field.label);
		
		if (field.type == "select") {
			for (var i = 1; i <= field.choices.length; i++) {
				
				$("li.field-<%= id %> #select #choice-" + i).text(field.choices[i-1]);
			}
		}
		else if (field.type == "radio_button" || field.type == "check_box") {
			for (var i = 1; i <= field.choices.length; i++) {
				$("li.field-<%= id %> .choices .choice-" + i + " label").text(field.choices[i-1]);
			}
			
		}
	});
});
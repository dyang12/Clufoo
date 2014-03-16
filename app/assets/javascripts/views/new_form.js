$(document).ready(function() {
	var numFields = 0;
	var currClick = null;
	var currField = null;
	
	$("#text-field-btn").on("click", function (event) {
		var textField = JST["text_field"]();
		
		$("#fields").append("<li class=\"field-" + numFields + "\">" + textField + "</li>");
		
		var template = JST["edit_field"];
		var fieldForm = template ({
			id: numFields,
			type: "text_field"
		});
		
		$("#edit-field .tab-form").append(fieldForm);
		numFields++;
	});
	
	$("#text-area-btn").on("click", function (event) {
		var textArea = JST["text_area"];
		$("#fields").append("<li class=\"field-" + numFields + "\">" + textArea() + "</li>");
		
		var template = JST["edit_field"];
		var fieldForm = template ({
			id: numFields,
			type: "text_area"
		});
		
		$("#edit-field .tab-form").append(fieldForm);
		numFields++;
	});
	
	$("#checkbox-btn").on("click", function (event) {
		var checkbox = JST["checkbox"];
		$("#fields").append("<li class=\"field-" + numFields + "\">" + checkbox() + "</li>");

		var template = JST["edit_field"];
		var fieldForm = template ({
			id: numFields,
			type: "check_box"
		});
		
		$("#edit-field .tab-form").append(fieldForm);
		numFields++;
	});
	
	$("#dropdown-btn").on("click", function (event) {
		var dropdown = JST["dropdown"];
		$("#fields").append("<li class=\"field-" + numFields + "\">" + dropdown() + "</li>");
		
		var template = JST["edit_field"];
		var fieldForm = template ({
			id: numFields,
			type: "select"
		});
		
		$("#edit-field .tab-form").append(fieldForm);
		numFields++;
	});
	
	$("#radio-btn").on("click", function (event) {
		var multipleChoice = JST["radio_button"];
		$("#fields").append("<li class=\"field-" + numFields + "\">" + multipleChoice() + "</li>");
		
		var template = JST["edit_field"];
		var fieldForm = template ({
			id: numFields,
			type: "radio_button"
		});
		
		$("#edit-field .tab-form").append(fieldForm);
		numFields++;
	});
	
	$("ul#fields").on("click", "li", function (event) {
		if(currClick) {
			currClick.toggleClass("clicked");
		}
		if(currField != null) {
			$("#field-" + currField).toggleClass("hidden-field-form displayed-field-form")
		}
		
		currClick = $(event.currentTarget)
		currClick.toggleClass("clicked");
		
		currField = currClick[0].className.substring(6,7);
		
		$("li.active").toggleClass("active");
		$("li.edit-field-tab").toggleClass("active");
		
		$("div.active").toggleClass("active in");
		$("div#edit-field").toggleClass("active in");
		
		$("#field-" + currField).toggleClass("hidden-field-form displayed-field-form")
	});
	
	$("#form").on("click", function (event) {
		var title = $('#form-title').text();
		var description = $('#form-description').text();
		
		if(currClick) {
			currClick.toggleClass("clicked");
		}
		
		currClick = $(event.currentTarget)
		currClick.toggleClass("clicked");
		
		$("li.active").toggleClass("active");
		$("li.edit-form-tab").toggleClass("active");
		
		$("div.active").toggleClass("active in");
		$("div#edit-form").toggleClass("active in");
		
		$('#form-title-attr')[0].value = title;
		$('#form-description-attr').text(description);
	});
	
	$("#myTab .add-field-tab").on("click", function(event) {
		if(currClick) {
			currClick.toggleClass("clicked");
			currClick = null
		}
	});
	
	$("#myTab .edit-form-tab").on("click", function(event) {
		var title = $('#form-title').text();
		var description = $('#form-description').text();
		
		if(currClick) {
			currClick.toggleClass("clicked");
			currClick = null
		}
		
		currClick = $("#form");
		currClick.toggleClass("clicked");
		
		$('#form-title-attr')[0].value = title;
		$('#form-description-attr').text(description);
	});
	
	$("#myTab .edit-field-tab").on("click", function(event) {
		if(currClick) {
			currClick.toggleClass("clicked");
			currClick = null
		}
		
		if(currField != null) {
			if ($("#field-" + currField)[0].className == "displayed-field-form") {
				$("#field-" + currField).toggleClass("hidden-field-form displayed-field-form")
			}
		}
		
		if ($("ul#fields").html() == "") {
			var textField = JST["text_field"];
			$("#fields").append("<li class=\"field-" + numFields + "\">" + textField() + "</li>");
			
			var template = JST["edit_field"];
			var fieldForm = template ({
				id: numFields,
				type: "text_field"
			});
		
			$("#edit-field .tab-form").append(fieldForm);
			numFields++;
		}
		
		currClick = $("ul#fields li.field-0");
		currField = 0;
		$("#field-0").toggleClass("hidden-field-form displayed-field-form");
		currClick.toggleClass("clicked");
	});
	
	$("#save-form-attributes").on("submit", function(event) {
		event.preventDefault();
	
		var data = $(event.target).serializeJSON();
	
		$('#form-title').text(data.form.title);
		$('#form-description').text(data.form.description);
	});
	
	$("#create-form-btn").on("click", function(event) {
		var form = $("#save-form-attributes").serializeJSON().form;
		var fields = [];
		
		for (var i = 0; i < numFields; i++) {
			var field = $("#field-" + i).serializeJSON();
			fields.push(field);
		}
		
		numFields = 0;
		
		$.ajax({
			url: "/forms",
			type: "post",
			data: {
				form: form,
				fields: fields
			},
			success: function(data) {
				if(data["title"] || data["fields"]) {
					
				} else {
					window.location.replace("/forms");
				}
			}
		});
	});
	
	
	$("#update-form-btn").on("click", function(event) {
		var form = $("#save-form-attributes").serializeJSON().form;
		var fields = [];
		var formId = $("#form").attr("data-id");
		numFields = $("#edit-field").attr("data-id");
		
		for (var i = 0; i < numFields; i++) {
			var field = $("#field-" + i).serializeJSON();
			fields.push(field);
		}
		
		numFields = 0;
		
		$.ajax({
			url: "/forms/" + formId,
			type: "put",
			data: {
				form: form,
				fields: fields
			},
			success: function(data) {
				if(data["title"] || data["fields"]) {
					
				} else {
					window.location.replace("/forms");
				}
			}
		});
	});
});
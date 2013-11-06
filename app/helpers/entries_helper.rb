module EntriesHelper
  def display_attribute(entry, field)
    if entry.response_data[field.id.to_s].is_a?(Array)
      entry.response_data[field.id.to_s].join(", ")
    else
      entry.response_data[field.id.to_s]
    end
  end
end

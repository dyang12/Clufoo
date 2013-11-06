module EntriesHelper
  def display_attribute(entry, field)
    if entry.response_data[field.id.to_s].is_a?(Hash)
      entry.response_data[field.id.to_s].keys.join(", ")
    else
      entry.response_data[field.id.to_s]
    end
  end
end

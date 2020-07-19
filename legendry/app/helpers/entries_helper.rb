module EntriesHelper
  def entry_header(entry)
    levels = entry.number_description.count('.') + 1
    "<h#{levels}> #{entry.number_description} #{entry.title} </h#{levels}>"
  end
end

# frozen_string_literal: true

def pagination(data)
  {
    total_entries: data&.total_entries,
    previous_page: data&.previous_page,
    current_page: data&.current_page,
    next_page: data&.next_page,
    per_page: data&.per_page,
    offset: data&.offset,
    total_pages: data&.total_pages
  }
end

def str_to_int(string)
  string.to_i if string.to_i.to_s == string
rescue StandardError
  nil
end

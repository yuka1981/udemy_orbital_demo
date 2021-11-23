module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Orbit Feedback Application'
    # puts "page_title: #{page_title.empty?}"

    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end

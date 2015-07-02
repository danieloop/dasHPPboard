module ApplicationHelper
  require 'fileutils'
  
	def title
    base_title = "dasHPPboard"
    if @title.nil?
      base_title
    else
      "#{base_title} - #{@title}"
    end
  end
end

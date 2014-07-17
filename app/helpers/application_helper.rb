module ApplicationHelper
	def flash_class(level)
	  case level
	     when 'notice' then "alert alert-success"
	     when 'error' then "alert alert-danger"
	  end
	end
end

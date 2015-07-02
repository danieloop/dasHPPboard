module SearchHelper
	require 'json'
	require 'fileutils'
	
	def queryExists(query)
		returnValue = false
		if File.exists?(Rails.root.to_s+"/public/tmpQuery/"+query.upcase)
			returnValue = true
		end
		return returnValue
	end

	def queryPath(query)
		return Rails.root.to_s+"/public/tmpQuery/"+query.upcase
	end

	def tmpJson(query,data)
		f = File.open(Rails.root.to_s+"/public/tmpQuery/"+query.upcase,'w')
		f.write(data.to_json)
		f.close
		return Rails.root.to_s+"/public/tmpQuery/"+query.upcase
	end
end

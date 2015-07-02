class NextprotsController < ApplicationController
	def index
		@nextprots = Nextprot.all
	end
end

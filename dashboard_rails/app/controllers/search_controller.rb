class SearchController < ApplicationController
	helper_method :queryExists?
	helper_method :queryPath
	helper_method :tmpJson
	helper_method :delayedRequest
	helper_method :addURLToJSON

	respond_to :html, :json

	def search
		@title = "Search"
	end
	
	def queryExists?(query)
		returnValue = false
		if File.exists?(Rails.root.to_s+"/public/tmpQuery/"+query.upcase)
			returnValue = true
		end
		return returnValue
	end

	def queryPath(query)
		return "/tmpQuery/"+query.upcase
	end

	def tmpJson(query,data)
		f = File.open(Rails.root.to_s+"/public/tmpQuery/"+query.upcase,'w')
		f.write(data.to_json)
		f.close
		return "/tmpQuery/"+query.upcase
	end

	def delayedRequest(where,searchQuery)
		return Experiment.all.where("#{where} LIKE ?", "%#{searchQuery}%")
	end

	def addURLToJSON(input,inputQuery)
		inputQuery = inputQuery.to_a.map(&:serializable_hash)
		inputQuery.each do |eAr|
			#eAr["url"] = "<a href=\"?div=#{eAr["divIdBox"]}&smpdiv=#{eAr["experimentId"]}&over=#{eAr["divIdentifier"]}&cellt=#{eAr["cellType"]}&chrom=#{eAr["chromosome"]}\" target=\"_parent\">Link</a>"
			eAr["url"] = "<a href=\"http://sphppdashboard.cnb.csic.es/?div=#{eAr["divIdBox"]}&smpdiv=#{eAr["experimentId"]}&over=#{eAr["divIdentifier"]}&cellt=#{eAr["cellType"]}&chrom=#{eAr["chromosome"]}\" target=\"_parent\">Link</a>"
		end
		queryHash = {}
		queryHash["data"]=inputQuery
		queryPath = tmpJson(input,queryHash)
		return queryPath
	end

	def results
		@title = "Search"
		input = params[:query]
		@genes=Gene.all
		@proteins=Protein.all
		@nextprots=Nextprot.all
		queryGn = @genes.find_by(name: input)
		queryGe = @genes.find_by(ensembl: input)
		queryU = @proteins.find_by(uniprot: input)
		queryN = @nextprots.find_by(nextprotID: input)
		@geneResults = nil
		@uniprotResults = nil
		@nextprotResults = nil
		#Si ha encontrado un gen
		@queryExperiments = []
		if !queryGn.nil? or !queryGe.nil?
			gen = !queryGn.nil? ? queryGn : queryGe
			@geneResults = gen
			@relatedProteinNames = ""
			if !gen.proteins.nil?
				@relatedProteinNames = gen.proteins.map{|e| e.uniprot}.join(", ")
			end
			@relatedNextprotNames = ""
			if !gen.nextprots.nil?
				@relatedNextprotNames = gen.nextprots.first
			end
			if queryExists?(input)
				@queryPath = queryPath(input)
			else
				@queryExperiments = delayedRequest("genes",gen.ensembl)
				@queryPath = addURLToJSON(input,@queryExperiments)
			end
		#si ha encontrado identificador uniprot
		elsif !queryU.nil?
			@uniprotResults = queryU
			@relatedGeneNames = ""
			if !queryU.gene.nil?
				@relatedGeneNames = queryU.gene
			end
			@relatedNextprotNames = ""
			queryNAux = @nextprots.find_by(nextprotID: "NX_"+input)
			if !queryNAux.nil?
				@relatedNextprotNames = queryNAux
			end
			if queryExists?(input)
				@queryPath = queryPath(input)
			else
				@queryExperiments = delayedRequest("uniprots",queryU.uniprot)
				@queryPath = addURLToJSON(input,@queryExperiments)
			end
		#si ha encontrado identificador nextprot
		elsif !queryN.nil?
			@nextprotResults = queryN
			@relatedGeneNames = ""
			if !queryN.gene.nil?
				@relatedGeneNames = queryN.gene
			end
			@relatedUniprotNames = ""
			queryUAux = @proteins.find_by(uniprot: input[3..-1])
			if !queryUAux.nil?
				@relatedUniprotNames = queryUAux
			end
			if queryExists?(input)
				@queryPath = queryPath(input)
			else
				@queryExperiments = delayedRequest("nextprots",queryN.nextprotID)
				@queryPath = addURLToJSON(input,@queryExperiments)
			end
		else
			@input=input
		end
	end
end

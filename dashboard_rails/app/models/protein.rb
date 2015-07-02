class Protein < ActiveRecord::Base
	belongs_to :gene
	validates :uniprot, presence: true, uniqueness: {case_sensitive: false}, format: {with: /\A[\w\d]+\z/, message: "only valid Uniprot identifiers"}
	validates :curated, :inclusion => {:in =>[true,false]}
end

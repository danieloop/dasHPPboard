class Nextprot < ActiveRecord::Base
	belongs_to :gene
	validates :nextprotID, presence: true, uniqueness: {case_sensitive: false}, format: {with: /\ANX_[\w\d]+\z/, message: "only valid Nextprot identifiers"}
	validates :missing, :inclusion => {:in =>[true,false]}
end

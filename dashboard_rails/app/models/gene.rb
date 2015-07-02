class Gene < ActiveRecord::Base
	has_many :proteins
	has_many :nextprots
	validates :ensembl, presence: true, uniqueness: {case_sensitive: false}, format: { with: /\AENSG\d+\z|\ALRG_\d+\z|\Aunknown\z/, message: "only valid Ensembl Human Genes"}
end

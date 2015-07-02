class Experiment < ActiveRecord::Base
	validates :cellType, presence: true
	validates :project, presence: true
	validates :cellName, presence: true
	validates :experimentType, presence: true
	validates :compartment, presence: true
	validates :fraction, presence: true
	validates :experimentId, presence: true
	validates :divIdentifier, presence: true
	validates :divIdBox, presence: true
	validates :chromosome, presence: true
end

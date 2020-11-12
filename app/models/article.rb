class Article < ApplicationRecord

	#associations

	has_many :comments, dependent: :destroy

	#validations

	validates :name, presence: true
	validates :author, presence: true

end

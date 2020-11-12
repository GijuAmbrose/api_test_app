class	Comment	<	ApplicationRecord

	#associations

	belongs_to	:article

	#validations

	validates :comment, presence: true
end

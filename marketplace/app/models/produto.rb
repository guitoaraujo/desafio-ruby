class Produto < ApplicationRecord
	belongs_to :user
	belongs_to :loja
end

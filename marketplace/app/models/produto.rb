class Produto < ApplicationRecord
	include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

	belongs_to :user
	belongs_to :loja
	

end

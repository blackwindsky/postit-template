class Category < ActiveRecord::Base
	has_many :post_categories, dependent: :destroy
	has_many :posts, through: :post_categories

	validates :name, presence: true
end
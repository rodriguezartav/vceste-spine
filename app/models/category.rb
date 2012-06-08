class Category < ActiveRecord::Base
  attr_accessible :description, :parent, :post_count, :slug, :title
end

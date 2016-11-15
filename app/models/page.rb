# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  site_id    :integer
#

class Page < ActiveRecord::Base
	validates_uniqueness_of :slug
	belongs_to :site
end

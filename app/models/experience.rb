class Experience < ActiveRecord::Base
	belongs_to :user
	has_many :comments, :as => :commentable

	validates :name, :description, :start_time, :end_time, presence: :true
end

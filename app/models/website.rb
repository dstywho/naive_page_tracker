class Website < ActiveRecord::Base
 has_many :visits

 validates :url, :presence => true
end

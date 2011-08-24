class Visit < ActiveRecord::Base
  named_scope :uniques, :conditions => {:unique=> true}

  belongs_to :website
end

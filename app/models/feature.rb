class Feature < ActiveRecord::Base
validates_presence_of :name
belongs_to :store

end

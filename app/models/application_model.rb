class ApplicationModel < ActiveRecord::Base
  self.abstract_class = true

  include RegularScopes
end

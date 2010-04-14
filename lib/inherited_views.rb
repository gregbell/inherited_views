require 'formtastic'
require 'will_paginate'

module InheritedViews
  
  autoload :Base,         'inherited_views/base'
  autoload :Helpers,      'inherited_views/helpers'
  autoload :TableBuilder, 'inherited_views/table_builder'
  
end


ActionView::Base.send :include, InheritedViews::Helpers
ActionView::Base.send :include, Formtastic::SemanticFormHelper
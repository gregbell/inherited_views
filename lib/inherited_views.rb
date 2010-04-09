require 'formtastic'

module InheritedViews
  
  autoload :Base,     'inherited_views/base'
  autoload :Helpers,  'inherited_views/helpers'
  
end


ActionView::Base.send :include, InheritedViews::Helpers
ActionView::Base.send :include, Formtastic::SemanticFormHelper
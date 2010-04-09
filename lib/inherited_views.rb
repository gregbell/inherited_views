require 'formtastic'

module InheritedViews
  
  autoload :Base,     'inherited_views/base'
  autoload :Helpers,  'inherited_views/helpers'
  
end


# Add our helpers to ActionController's list
# ActionController::Base.helper(InheritedViews::Helpers)

ActionView::Base.send :include, InheritedViews::Helpers
ActionView::Base.send :include, Formtastic::SemanticFormHelper
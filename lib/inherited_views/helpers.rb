module InheritedViews
  module Helpers
    
    
    # Tries to render the partial, if it doesn't exist, we will
    # try to find the partial in the default views folder for this
    # controller.
    # 
    # Example:
    # 
    # in app/views/users/index.html.erb
    # <%= render_partial_or_default 'item', :collection => @items %>
    # 
    # First it will try to reder 'app/views/users/_item.html.erb'. If 
    # this file doesn't exist, it will lookup _item.html.erb in the
    # default views folder.    
    def render_partial_or_default(name, options = {})
      render options.merge(:partial => name)
    rescue ActionView::MissingTemplate
      render options.merge(:partial => "#{controller.class.default_views}/#{name}")
    end
    
  end
end
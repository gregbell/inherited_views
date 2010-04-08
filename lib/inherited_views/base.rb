require 'inherited_resources'

module InheritedViews
  class Base < InheritedResources::Base
    
    
    # Set the name of the folder of the default views to use
    # within the view path.
    # 
    # For example, if I want to set the default views for my
    # application to app/views/my_defaults/*.html.erb I would
    # 
    #   InheritedViews::Base.default_views = 'my_defaults'
    # 
    # You can also override for one specific controller from
    # within it:
    # 
    #   class UsersController < InheritedViews::Base
    #     self.default_views = "my_default_admin_views"
    #   end
    # 
    # which would then use app/views/my_default_admin_views
    # 
    class_inheritable_accessor :default_views
    self.default_views = 'inherited_views_default'
    
    # Add our default views to the base path
    ActionController::Base.append_view_path File.expand_path('../default_views', __FILE__)
    
    
    
    # 
    #  Actions
    # 
    
    def index
      super do |format|
        format.html { render_or_default 'index' }
      end
    end
    
    protected
    
    def index_table_columns
      resource_class.content_columns.collect{|column| column.name.to_sym  }
    end
    helper_method :index_table_columns
    
    private

    # All the magic lives here :)
    # 
    # This method tries to render the view you pass it, otherwise it
    # renders the view from the default view folder
    # 
    def render_or_default(name, args = {})
      render name, args
    rescue ActionView::MissingTemplate
      render "#{self.class.default_views}/#{name}", args
    end
    
  end
end
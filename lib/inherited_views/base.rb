require 'inherited_resources'

module InheritedViews
  class Base < ::InheritedResources::Base
    
    
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
    
    include TableBuilder
    
    # 
    #  Actions
    # 
    
    def index
      super do |format|
        format.html { render_or_default 'index' }
      end
    end
    
    def new
      super do |format|
        format.html { render_or_default 'new' }
      end
    end
    
    def create
      create! do |success, failure|
        failure.html { render_or_default 'new' }
      end
    end
    
    def show
      super do |format|
        format.html { render_or_default 'show' }
      end
    end
    
    def edit
      super do |format|
        format.html { render_or_default 'edit' }
      end
    end
    
    def update
      update! do |success, failure|
        failure.html { render_or_default 'edit' }
      end
    end
    
    
    protected
    
    # Overriding so that we have pagination by default
    def collection
      get_collection_ivar || set_collection_ivar(end_of_association_chain.paginate(:page => params[:page]))
    end
    

    def show_view_columns
      resource_class.columns.collect{|column| column.name.to_sym  }
    end
    helper_method :show_view_columns
    
    def resource_name
      resource_class.human_name
    end
    helper_method :resource_name
    
    def resources_name
      resource_name.pluralize
    end
    helper_method :resources_name
    
    private

    # All the magic lives here :)
    # 
    # This method tries to render the view you pass it, otherwise it
    # renders the view from the default view folder
    # 
    def render_or_default(name, args = {})
      render name, args
    rescue ActionView::MissingTemplate
      render args.merge(:template => "#{self.class.default_views}/#{name}", :prefix => '')
    end
    
  end
end

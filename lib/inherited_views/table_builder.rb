module InheritedViews
  module TableBuilder
    
    def self.included(base)
      base.extend ClassMethods
      base.class_inheritable_accessor :table_config
      base.table_config = {}
      base.send :helper_method, :index_table_columns
    end
    
    def table_config
      self.class.table_config
    end
        
    def index_table_columns
      table_config[:columns] || self.class.default_table_columns
    end
    
    module ClassMethods
      
      def default_table_columns
        resource_class.content_columns.collect{|column| column.name.to_sym  }
      end
      
      def table(*columns)
        options = columns.extract_options!        
        
        if options[:except]
          options[:except] = options[:except].is_a?(Array) ? options[:except] : [options[:except]]
          columns = default_table_columns
          options[:except].each{|c| columns.delete(c) }
        end
        
        self.table_config = options.merge(:columns => columns)
      end
      
    end
  end
end
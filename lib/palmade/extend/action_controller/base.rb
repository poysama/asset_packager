class ActionController::Base
  @@rails_asset_packager = nil
  cattr_accessor :rails_asset_packager

  class << self
    attr_reader :default_assets

    def asset_manager(su = false, create_if_needed = false)
      if su
        superclass.asset_manager
      else
        if defined?(@asset_manager)
          @asset_manager
        elsif create_if_needed
          @asset_manager = rails_asset_packager.create_am(self)
        elsif self == ActionController::Base
          nil
        else
          superclass.asset_manager
        end
      end
    end
    
    def javascript_include(*sources)
      asset_include('javascripts', *sources)
    end
    
    def stylesheet_include(*sources)
      asset_include('stylesheets', *sources)
    end
    
    def before_filter_javascript(*sources)
      before_filter { |cont| cont.javascript_include(*sources) }
    end
    
    def before_filter_stylesheet(*sources)
      before_filter { |cont| cont.stylesheet_include(*sources) }
    end
    
    protected
    
    def asset_include(asset_type, *sources)
      asset_manager(false, true).update_asset(asset_type, *sources)
    end
    
    def process_with_asset_packager(*args)
      asset_before_process_hook(*args)
      process_without_asset_packager(*args)
    end
    alias_method_chain :process, :asset_packager
    
    private

    def asset_before_process_hook(*args)
      @default_assets ||= { }

      unless defined?(@processed_default_assets) && @processed_default_assets
        [ 'stylesheets', 'javascripts' ].each do |asset_type|
          asset_controller = 'controllers/' + controller_path
          if rails_asset_packager.asset_exists?(asset_type, asset_controller)
            @default_assets[asset_type] ||= [ ]
            @default_assets[asset_type] << asset_controller
          end
        end

        @processed_default_assets = true
      end
    end
  end
end

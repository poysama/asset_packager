class ActionController::Base
  hide_action :asset_manager, :javascript_include, :stylesheet_include, :asset_deflate_ok?, 
    :asset_in_production?, :asset_include, :asset_managers

  helper_method :asset_manager, :asset_managers, :asset_in_production?, :asset_deflate_ok?
  before_render :asset_before_render_hook

  def asset_manager(create_if_needed = false)
    if defined?(@asset_manager)
      @asset_manager
    elsif create_if_needed
      @asset_manager = rails_asset_packager.create_instance_am(self)
    else
      self.class.asset_manager
    end
  end
  
  def asset_managers
    asset_managers = [ ]
    asset_managers << @asset_manager if defined?(@asset_manager) && !@asset_manager.nil?
    asset_managers += self.class.asset_managers
    asset_managers
  end
  
  def javascript_include(*sources)
    asset_include('javascripts', *sources)
  end
  
  def stylesheet_include(*sources)
    asset_include('stylesheets', *sources)
  end
  
  def asset_deflate_ok?
    if !asset_deflate_disabled? && 
      request.env.include?('HTTP_ACCEPT_ENCODING') &&
      request.env['HTTP_ACCEPT_ENCODING'].split(/\s*\,\s*/).include?('deflate')
      true
    else
      false
    end
  end

  def asset_in_production?
    ENV['ASSET_PACKAGER_FORCE_PRODUCTION'] || RAILS_ENV == "production"
  end

  def asset_include(asset_type, *sources)
    self.class.asset_include_to_am(asset_manager(true), asset_type, *sources)
  end


  protected

  def prevent_default_assets?
    defined?(@asset_manager_prevent_defaults) && @asset_manager_prevent_defaults
  end
  
  def prevent_default_assets!(prevent = true)
    @asset_manager_prevent_defaults = prevent
  end
  
  def asset_deflate_disabled?
    (ENV.include?('ASSET_PACKAGER_DISABLE_DEFLATE_CHECKING') &&
    ENV['ASSET_PACKAGER_DISABLE_DEFLATE_CHECKING'] == '1')
  end
  
  private

  def asset_before_render_hook(*params)
    unless prevent_default_assets?
      unless defined?(@processed_default_assets) && @processed_default_assets
        # first, let's figure out if we're going to use layouts
        # the code that follows was copied from layouts.rb of the ActionController code
        layout = nil
        options = params.first
        template_with_options = options.is_a?(Hash)
        if apply_layout?(template_with_options, options)
          layout = pick_layout(template_with_options, options, nil)
        end
  
        [ 'javascipts', 'stylesheets' ].each do |asset_type|
          # check for layout assets
          unless layout.nil?
            if rails_asset_packager.asset_exists?(asset_type, layout)
              asset_include(asset_type, layout, :set => 'default')
            end
          end
  
          # check for controller assets
          if self.class.default_assets[asset_type] && 
            self.class.default_assets[asset_type].size > 0
            asset_include(asset_type, self.class.default_assets[asset_type], :set => 'default')
          end
  
          # check for action assets
          if rails_asset_packager.asset_exists?(asset_type, default_template_name)
            asset_include(asset_type, default_template_name, :set => 'default')
          end
        end

        @processed_default_assets = true
      end
    end
    
    true
  end
end

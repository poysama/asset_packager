class ActionView::Base
  def javascript_tags(options = { })
    asset_tags('javascripts', options)
  end
  
  def stylesheet_tags(options = { })
    asset_tags('stylesheets', options)
  end
  
  protected
  
  def asset_tags(asset_type, options)
    asset_options = { :rendered => false, :mark_rendered => true }
    asset_options.update(options)

    case
    when options.include?(:set)
      asset_options[:set] = options[:set]
    when options.include?(:package)
      asset_options[:package] = options[:package]
    end

    unless asset_manager.nil?
      assets = asset_manager.find_assets(asset_type, asset_options.stringify_keys)
      assets.each do |asset|
        
      end unless assets.nil? || assets.empty?
    end
  end

  private

  # WATCH OUT!!!
  # the following are overrides, and may not work with Rails version, later than 1.2.3
  def compute_public_path(source, dir, ext, options = { })
    source = source.dup
    source << ".#{ext}" if File.extname(source).blank?
    unless source =~ %r{^[-a-z]+://}
      source = "/#{dir}/#{source}" unless source[0] == ?/

      asset_id = rails_asset_id(source)
      source << '?' + asset_id unless asset_id.blank?

      if use_asset_host
        source = "#{compute_asset_host(source)}#{@controller.request.relative_url_root}#{source}"
      else
        source = "#{@controller.request.relative_url_root}#{source}"
      end
    end
    source
  end

  def compute_asset_host(source) 
    # TODO: Add support for multi-version asset hosts

    if host = ActionController::Base.asset_host 
      host % (source.hash % 4)
    end
  end

  def rails_asset_id(source)
    unless asset_in_production?
      ENV["RAILS_ASSET_ID"] || 
        File.mtime("#{RAILS_ROOT}/public/#{source}").to_i.to_s rescue ""
    end
  end
end

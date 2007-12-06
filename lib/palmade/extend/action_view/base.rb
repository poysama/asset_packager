class ActionView::Base
  def javascript_tags(options = { })
    asset_tags('javascripts', options)
  end
  
  def stylesheet_tags(options = { })
    asset_tags('stylesheets', options)
  end

  protected

  def asset_tags(asset_type, options)
    asset_options = { :rendered => false }
    asset_options.update(options)

    case
    when options.include?(:set)
      asset_options[:set] = options[:set]
    when options.include?(:package)
      asset_options[:package] = options[:package]
    end
    
    # this flag only affects the packaged assets
    compiled = if asset_in_production?
      if asset_deflate_ok?
        Palmade::AssetPackager::COMPILED_Z
      else
        Palmade::AssetPackager::COMPILED
      end
    else
      false
    end

    assets = spider_am(asset_type, asset_options)
    assets.collect do |asset|
      asset.rendered = true

      case asset.source(compiled)
      when String
        render_asset(asset_type, asset.source)
      when Array
        asset.source.collect do |as|
          render_asset(asset_type, as)
        end.join("\n")
      end
    end.join("\n") unless assets.nil? || assets.empty?
  end


  private

  def render_asset(asset_type, as)
    case asset_type
    when 'javascripts'
      javascript_include_tag(as)
    when 'stylesheets'
      stylesheet_link_tag(as)
    end
  end

  def spider_am(asset_type, asset_options = { })
#    assets = [ ]
#    unless asset_managers.empty?
#      asset_managers.each do |am|
#        assets += am.find_assets(asset_type, asset_options.stringify_keys) || [ ]
#      end
#    end

    # only get the instance asset_manager, to set the rendered flag properly
    # the commented version above, is not thread-safe!!!
    unless asset_manager.nil?
      asset_manager.find_assets(asset_type, asset_options.stringify_keys)
    else
      [ ]
    end
  end

  # WATCH OUT!!!
  # the following are overrides, and may not work with Rails version, later than 1.2.3
  def compute_public_path(source, dir, ext, options = { })
    options.stringify_keys!
    options['use_asset_host'] = true unless options.include?('use_asset_host')

    source = source.dup
    source << ".#{ext}" if File.extname(source).blank?
    unless source =~ %r{^[-a-z]+://}
      source = "/#{dir}/#{source}" unless source[0] == ?/

      asset_id = rails_asset_id(source)
      source << '?' + asset_id unless asset_id.blank?

      if options['use_asset_host']
        source = "#{compute_asset_host(source)}#{@controller.request.relative_url_root}#{source}"
      else
        source = "#{@controller.request.relative_url_root}#{source}"
      end
    end
    source
  end

  def compute_asset_host(source) 
    # TODO: Add support for multi-version asset hosts
    asset_version = ActionController::Base.asset_version || 0

    if host = ActionController::Base.asset_host 
      host % [ (source.hash % 4), asset_version ]
    end
  end

  def rails_asset_id(source)
    unless asset_in_production?
      ENV["RAILS_ASSET_ID"] || 
        File.mtime("#{RAILS_ROOT}/public/#{source}").to_i.to_s rescue ""
    end
  end
end

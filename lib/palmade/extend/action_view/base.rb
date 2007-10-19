class ActionView::Base
  def javascript_tags(options = { })
    asset_tags('javascripts', options)
  end
  
  def stylesheet_tags(options = { })
    asset_tags('stylesheets', options)
  end
  
  protected
  
  def asset_tags(asset_type, options)
    
  end
end

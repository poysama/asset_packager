module Palmade::AssetPackager::Types; end

class Palmade::AssetPackager::Base
  def get_asset_type_class(asset_type)
    "Palmade::AssetPackager::Types::#{asset_type.classify}".constantize
  end
end

require File.join(File.dirname(__FILE__), 'types/abstract')
require File.join(File.dirname(__FILE__), 'types/compress')
require File.join(File.dirname(__FILE__), 'types/javascript')
require File.join(File.dirname(__FILE__), 'types/stylesheet')
require File.join(File.dirname(__FILE__), 'types/image')

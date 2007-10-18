require 'zlib'

module Palmade::AssetPackager::Types
  class Abstract
    DEFLATE_LEVEL = 9

    def deflate(source_content, target)
      File.open(target, 'w') do |f|
        z = Zlib::Deflate.deflate(source_content, DEFLATE_LEVEL)
        f.write z[2..-5]
      end
    end
  end
end

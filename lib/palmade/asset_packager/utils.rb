module Palmade::AssetPackager
  class Utils

    def self.stringify_keys(hash)
      hash.inject({}) do |options, (key, value)|
        options[key.to_s] = value
        options
      end
    end

  end
end

module Palmade::AssetPackager::Types
  class Abstract
    DEFAULT_TARGET_PATH = 'compiled'

    class Error < StandardError; end
    class NotImplemented < Error; end
    class AssetFileNotFound < Error; end

    attr_accessor :logger
    attr_accessor :asset_root
    attr_accessor :target_path
    attr_accessor :package_name

    def asset_type
      raise NotImplemented, "Not implemented (asset_type)"
    end

    def asset_extension
      raise NotImplemented, "Not implemented (asset_extension)"
    end

    def build
      raise NotImplemented, "Not implemented (build)"
    end
    
    def delete
      File.delete(target_filename) if File.exists?(target_filename)
      File.delete(target_filename_z) if File.exists?(target_filename_z)
    end

    def initialize(ap, package_name, asset_root, logger)
      @ap = ap
      @package_name = package_name
      @logger = logger
      @asset_root = asset_root
    end

    def target_path
      @target_path ||= File.join(asset_root, asset_type, DEFAULT_TARGET_PATH)
    end

    def options; @options ||= { }; end
    def assets; @assets ||= [ ]; end

    def update(source_list)
      source_list.each do |sl|
        case sl
        when Hash
          options.update(sl)
        when String
          parse_source_line(sl)
        end
      end
    end

    def post_parse
      if options['include']
        case options['include']
        when String
          include_assets_from(options['include'])
        when Array
          options['include'].each do |inc|
            include_assets_from(inc)
          end
        end
      end
    end

    protected
      def target_filename
        File.join(target_path, "#{package_name}.#{asset_extension}")
      end
      
      def target_filename_z
        File.join(target_path, "#{package_name}.#{asset_extension}.z")
      end

      def include_assets_from(package_name)
        logger.debug("Including assets from #{package_name}, #{asset_type} to #{@package_name}")
        apt = @ap.find_package(package_name, asset_type)        
        unless apt.nil?
          assets.concat(apt.assets)
        end
      end

      def find_asset(a)
        possible_name = File.join(asset_root, "#{a}.#{asset_extension}")
        return possible_name if File.exists?(possible_name)

        possible_name = File.join(asset_root, a)
        return possible_name if File.exists?(possible_name)

        return nil
      end

      def asset_path(asset)
        File.join(@asset_root, asset)
      end

      def split_options(sl)
        line_params = sl.to_s.split(',')
        line_options = line_params.size > 1 ? line_params[1, line_params.size - 1] : nil

        [ line_params[0], line_options ]
      end

      def parse_source_line(sl)
        line_source, line_options = split_options(sl)

        # full-path, relative to ASSET_ROOT
        if line_source =~ /^(\/([^\/]+\/)+)(.*)$/
          url_path = $~[1].chop
          source_name = $~[3]
        # relative to ASSET_ROOT/#{asset_type}
        elsif line_source =~ /^(([^\/]+\/)+)(.*)$/
          url_path = File.join("/#{asset_type}", $~[1].chop)
          source_name = $~[3]
        else
          url_path = "/#{asset_type}"
          source_name = line_source
        end

        source_names = source_name.split('|')
        for source_name in source_names
          if line_options
            assets << { :source => File.join(url_path, source_name), :options => line_options }
          else
            assets << File.join(url_path, source_name)
          end
        end
      end
  end
end

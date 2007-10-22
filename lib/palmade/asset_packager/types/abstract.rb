module Palmade::AssetPackager::Types
  class Abstract
    DEFAULT_TARGET_PATH = 'compiled'
    OPTIONS = [ 'include' ]
    SOURCE_OPTIONS = [ 'set' ]
    VALID_SOURCE_PARAMS = [ 'package' ]

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

    def destroy
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
      @target_path ||= File.join(asset_root, asset_type, DEFAULT_TARGET_PATH, package_name)
    end

    def options; @options ||= { }; end
    def assets; @assets ||= [ ]; end
    
    def update_options(opts)
      options.update(opts)
    end

    def update_asset(source, source_options = { })
      case source
      when Hash
        source.stringify_keys!
        source_options.update(source.split!(SOURCE_OPTIONS) || { })

        parse_source_hash(source.stringify_keys, source_options)
      when String
        parse_source_line(source, source_options)
      when Array
        source.each { |sl| update_asset(sl, source_options) }
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

    def find_assets(asset_options)
      # options can be set, rendered
      found_assets = [ ]
      assets.each do |asset|
        incld = true

        if incld && asset_options.include?('set')
          unless asset.part_of_set?(asset_options['set'])
            incld = false
          end
        end

        if incld && asset_options.include?('rendered')
          unless asset_options['rendered'] == asset.rendered
            incld = false
          end
        end

        found_assets << asset if incld
      end

      found_assets
    end

    def get_assets_from(package_name)
      apt = @ap.find_package(package_name, asset_type)
      apt.assets unless apt.nil?
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
        include_assets(apt) unless apt.nil?
      end

      def include_assets(apt)
        assets.concat(apt.assets)
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

      def parse_source_hash(sh, sh_options = { })
        sh.assert_valid_keys(VALID_SOURCE_PARAMS)
        sh_options.assert_valid_keys(SOURCE_OPTIONS)

        if sh.include?('package')
          assets << Palmade::AssetPackager::AssetBase.new(self, "package:#{sh['package']}", sh_options)
        end
      end

      def parse_source_line(sl, sl_options = { })
        sl_options.assert_valid_keys(SOURCE_OPTIONS)

        line_source, line_options = split_options(sl)
        sl_options.update({ :line_options => line_options }) unless line_options.nil? || line_options.empty?

        url_path = nil
        # full-path, relative to ASSET_ROOT
        if line_source =~ /^package\:\s*(.+)\s*$/
          source_name = "package:#{$~[1]}"
        elsif line_source =~ /^(\/([^\/]+\/)+)(.*)$/
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
          asset_path = url_path.nil? ? source_name : File.join(url_path, source_name)
          assets << Palmade::AssetPackager::AssetBase.new(self, asset_path, sl_options)
        end
      end
  end
end

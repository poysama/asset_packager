module Palmade::AssetPackager
  class AssetBase
    attr_reader :options
    attr_accessor :rendered
    alias :rendered? :rendered

    def initialize(apt, source, options = { })
      @apt = apt
      @options = options
      @source = source
      @rendered = false
    end

    def set
      @options['set']
    end

    def part_of_set?(st)
      case @options['set']
      when String
        @options['set'] == st
      when Array
        @options['set'].include?(st)
      when nil
        false
      end
    end

    def source(compiled = false)
      if @source =~ /^package\:\s*(.+)\s*$/
        @resolved_assets ||= get_assets_from_package($~[1], compiled)
      else
        @source
      end
    end

    def reset
      @resolved_assets = nil
    end

    def exists?
      if @source =~ /^package\:\s*(.+)\s*$/
        !plist.split(/\|/).collect do |pname|
          @apt.find_package(pname).nil?
        end.include?(:true)
      else
        File.exists?(File.join(@apt.asset_root, @source))
      end
    end

    def package?
      @source =~ /^package\:\s*.+\s*$/
    end

    private

    def get_assets_from_package(plist, compiled)
      plist.split(/\|/).collect do |package_name|
        this_assets = @apt.get_assets_from(package_name, compiled)
        this_assets.collect { |ta| ta.source }.flatten unless this_assets.nil? || this_assets.empty?
      end.flatten.compact
    end
  end
end

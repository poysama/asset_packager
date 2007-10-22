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

    def source
      if @source =~ /^package\:\s*(.+)\s*$/
        @resolved_assets ||= $~[1].split(/\|/).collect do |package_name|
          this_assets = @apt.get_assets_from(package_name)
          this_assets.collect { |ta| ta.source }.flatten unless this_assets.nil? || this_assets.empty?
        end.flatten.compact
      else
        @source
      end
    end

    def reset
      @resolved_assets = nil
    end
  end
end

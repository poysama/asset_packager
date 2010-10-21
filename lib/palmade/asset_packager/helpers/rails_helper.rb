module Palmade::AssetPackager
  module Helpers::RailsHelper
    def self.setup(configuration)
      if configuration.frameworks.include?(:action_controller) &&
        configuration.frameworks.include?(:action_view)

        ActionController::Base.send(:extend, Mixins::ActionControllerHelper)
        ActionController::Base.send(:include, Mixins::ActionControllerInstanceHelper)
        ActionView::Base.send(:include, Mixins::ActionViewHelper)

        # include cell extensions
        configuration.after_initialize do
          if defined?(Palmade::Cells)
            Palmade::Cells::Base.send(:include, Mixins::CellsHelper)
          end
        end
      end
    end

    # this is called, right after the framework are loaded, to support the
    # additional config options attached to the ActionController framework
    # e.g. config.action_controller.asset_version = 0
    def self.add_configuration_options(configuration)
      if configuration.frameworks.include?(:action_controller)
        class << ActionController::Base
          cattr_accessor :asset_version
          cattr_accessor :asset_skip_relative_url_root
          self.asset_version = 0
          self.asset_skip_relative_url_root = false
        end
      end
    end
  end
end

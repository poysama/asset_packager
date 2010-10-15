require File.expand_path("../spec_helper", __FILE__)

gem 'actionpack', '1.13.6'
require 'action_controller'
require 'action_view'
require 'ostruct'

configuration = OpenStruct.new
configuration.frameworks = [:action_controller, :action_view]
Palmade::AssetPackager::Helpers.use(:RailsHelper, configuration)
Palmade::AssetPackager::Helpers::RailsHelper.add_configuration_options(configuration)
Palmade::AssetPackager::RailsPackager.new(File.dirname(__FILE__)).run('rails_attach')

describe "ActionController 1.13.6" do
  context "with AssetPackager extensions" do

    it "should have new configuration options" do
      ActionController::Base.should respond_to(:asset_version)
      ActionController::Base.should respond_to(:asset_skip_relative_url_root)
    end

    it "should have correct default configuration values" do
      ActionController::Base.asset_version.should == 0
      ActionController::Base.asset_skip_relative_url_root.should == false
    end

    it "should have new methods attached" do
      instance = ActionController::Base.new
      methods = [ :javascript_include,
                  :stylesheet_include,
                  :asset_include ]
      methods.each do |meth|
        ActionController::Base.should respond_to(meth)
        instance.should respond_to(meth)
      end
    end

  end
end

describe "ActionView 1.13.6" do
  context "with AssetPackager extensions" do

    RAILS_ENV = "production"
    ENV['ASSET_PACKAGER_DISABLE_DEFLATE_CHECKING'] = '1'

    before(:all) do
      @controller = ActionController::Base.new
      @view = ActionView::Base.new(nil, {}, @controller)
      @view.class.send(:include, @controller.class.master_helper_module)
    end

    it "should have new methods attached" do
      instance = ActionView::Base.new
      methods = [ :javascript_include,
                  :stylesheet_include,
                  :javascript_tags,
                  :stylesheet_tags ]
      methods.each do |meth|
        instance.should respond_to(meth)
      end
    end

    it "should render individual javascripts" do
      @view.javascript_include('base')
      @view.javascript_tags.should == "<script src=\"/javascripts/base.js\" type=\"text/javascript\"></script>"
    end

  end
end

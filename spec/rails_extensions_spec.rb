require "spec/spec_helper"

configuration = OpenStruct.new
configuration.frameworks = [:action_controller, :action_view]
rails_root = File.join('spec', 'rails')

Palmade::AssetPackager::Helpers.use(:RailsHelper, configuration)
Palmade::AssetPackager::Helpers::RailsHelper.add_configuration_options(configuration)
Palmade::AssetPackager::RailsPackager.new(rails_root).run('rails_attach')

describe "ActionController" do
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

describe "ActionView" do
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

    it "should render regular assets" do
      @view.javascript_include('some_regular_js')
      @view.stylesheet_include('some_regular_css')
      @view.javascript_tags.should == "<script src=\"/javascripts/some_regular_js.js\" type=\"text/javascript\"></script>"
      @view.stylesheet_tags.should match /<link href="\/stylesheets\/some_regular_css.css" media="screen" rel="Stylesheet" type="text\/css" \/>/i
    end

    it "should render compiled assets" do
      @view.javascript_include('package:base')
      @view.stylesheet_include('package:base')
      @view.javascript_tags.should == "<script src=\"/javascripts/compiled/base/base.js\" type=\"text/javascript\"></script>"
      @view.stylesheet_tags.should match /<link href="\/stylesheets\/compiled\/base\/base.css" media="screen" rel="Stylesheet" type="text\/css" \/>/i
    end

  end
end

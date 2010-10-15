require "spec_helper"

describe "RailsPackager" do

  before :all do
    @rails_path = File.join(File.dirname(__FILE__), 'rails')
    @assets_path = File.join(@rails_path, 'public')

    @rails_packager = Palmade::AssetPackager::RailsPackager.new(@rails_path)
    @rails_packager.logger = Logger.new(StringIO.new)
    @rails_packager.initialize_asset_packager
  end

  it "should detect available assets" do
    @rails_packager.asset_exists?('javascripts', 'available').should == true
    @rails_packager.asset_exists?('stylesheets', 'available').should == true
  end

  it "should detect missing assets" do
    @rails_packager.asset_exists?('javascripts', 'missing').should == false
    @rails_packager.asset_exists?('stylesheets', 'missing').should == false
  end

  it "should package assets" do
    @rails_packager.build
    File.exists?(File.join(@assets_path, 'javascripts/compiled/base/base.js')).should == true
    File.exists?(File.join(@assets_path, 'javascripts/compiled/base/base.js.z')).should == true
    File.exists?(File.join(@assets_path, 'stylesheets/compiled/base/base.css')).should == true
    File.exists?(File.join(@assets_path, 'stylesheets/compiled/base/base.css.z')).should == true
  end

  it "should compile correctly" do
    correct_path = File.join(@rails_path, 'correct')
    files = [
      'javascripts/compiled/base/base.js',
      'javascripts/compiled/base/base.js.z',
      'stylesheets/compiled/base/base.css',
      'stylesheets/compiled/base/base.css.z'
    ]

    files.each do |filename|
      compiled = File.read(File.join(@assets_path, filename))
      correct = File.read(File.join(correct_path, filename))

      compiled.should == correct
    end
  end

  it "should cleanup compiled assets" do
    @rails_packager.delete
    File.exists?(File.join(@assets_path, 'javascripts/compiled/base/base.js')).should == false
    File.exists?(File.join(@assets_path, 'javascripts/compiled/base/base.js.z')).should == false
    File.exists?(File.join(@assets_path, 'stylesheets/compiled/base/base.css')).should == false
    File.exists?(File.join(@assets_path, 'stylesheets/compiled/base/base.css.z')).should == false
  end

end

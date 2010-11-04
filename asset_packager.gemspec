# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{asset_packager}
  s.version = "0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["palmade"]
  s.date = %q{2010-11-03}
  s.default_executable = %q{rails_packer}
  s.description = %q{An asset_packager for use with Rails and other frameworks}
  s.email = %q{}
  s.executables = ["rails_packer"]
  s.extra_rdoc_files = ["COPYING", "LICENSE", "README", "lib/palmade/asset_packager.rb", "lib/palmade/asset_packager/asset_base.rb", "lib/palmade/asset_packager/base.rb", "lib/palmade/asset_packager/base_package.rb", "lib/palmade/asset_packager/base_parser.rb", "lib/palmade/asset_packager/helpers.rb", "lib/palmade/asset_packager/helpers/rails_helper.rb", "lib/palmade/asset_packager/jsmin.rb", "lib/palmade/asset_packager/manager.rb", "lib/palmade/asset_packager/mixins.rb", "lib/palmade/asset_packager/mixins/action_controller_helper.rb", "lib/palmade/asset_packager/mixins/action_controller_instance_helper.rb", "lib/palmade/asset_packager/mixins/action_view_helper.rb", "lib/palmade/asset_packager/mixins/cells_helper.rb", "lib/palmade/asset_packager/rails_packager.rb", "lib/palmade/asset_packager/types.rb", "lib/palmade/asset_packager/types/abstract.rb", "lib/palmade/asset_packager/types/compress.rb", "lib/palmade/asset_packager/types/image.rb", "lib/palmade/asset_packager/types/javascript.rb", "lib/palmade/asset_packager/types/stylesheet.rb", "lib/palmade/asset_packager/utils.rb"]
  s.files = ["CHANGELOG", "COPYING", "LICENSE", "Manifest", "README", "Rakefile", "asset_packager.gemspec", "bin/rails_packer", "lib/palmade/asset_packager.rb", "lib/palmade/asset_packager/asset_base.rb", "lib/palmade/asset_packager/base.rb", "lib/palmade/asset_packager/base_package.rb", "lib/palmade/asset_packager/base_parser.rb", "lib/palmade/asset_packager/helpers.rb", "lib/palmade/asset_packager/helpers/rails_helper.rb", "lib/palmade/asset_packager/jsmin.rb", "lib/palmade/asset_packager/manager.rb", "lib/palmade/asset_packager/mixins.rb", "lib/palmade/asset_packager/mixins/action_controller_helper.rb", "lib/palmade/asset_packager/mixins/action_controller_instance_helper.rb", "lib/palmade/asset_packager/mixins/action_view_helper.rb", "lib/palmade/asset_packager/mixins/cells_helper.rb", "lib/palmade/asset_packager/rails_packager.rb", "lib/palmade/asset_packager/types.rb", "lib/palmade/asset_packager/types/abstract.rb", "lib/palmade/asset_packager/types/compress.rb", "lib/palmade/asset_packager/types/image.rb", "lib/palmade/asset_packager/types/javascript.rb", "lib/palmade/asset_packager/types/stylesheet.rb", "lib/palmade/asset_packager/utils.rb", "spec/rails/config/asset_packages.yml", "spec/rails/correct/javascripts/compiled/base/base.js", "spec/rails/correct/javascripts/compiled/base/base.js.z", "spec/rails/correct/stylesheets/compiled/base/base.css", "spec/rails/correct/stylesheets/compiled/base/base.css.z", "spec/rails/public/javascripts/available.js", "spec/rails/public/javascripts/complete.js", "spec/rails/public/javascripts/regular_file.js", "spec/rails/public/javascripts/testing.with_dot.js", "spec/rails/public/stylesheets/available.css", "spec/rails/public/stylesheets/folder/stylesheet.custom.css", "spec/rails/public/stylesheets/simple.css", "spec/rails2_tests/rails_extensions.rb", "spec/rails_extensions.rb", "spec/rails_packager.rb", "spec/spec_helper.rb", "spec/utils.rb", "test/test_helper.rb"]
  s.homepage = %q{}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Asset_packager", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{palmade}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{An asset_packager for use with Rails and other frameworks}
  s.test_files = ["test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

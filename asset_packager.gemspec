# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{asset_packager}
  s.version = "0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["palmade"]
  s.date = %q{2010-10-11}
  s.description = %q{An asset_packager for use with Rails and other frameworks}
  s.email = %q{}
  s.executables = ["asset_packer", "rails_packer"]
  s.extra_rdoc_files = ["COPYING", "lib/asset_packager/init.rb", "lib/asset_packer.rb", "lib/palmade/asset_packager/asset.rb", "lib/palmade/asset_packager/asset_base.rb", "lib/palmade/asset_packager/base.rb", "lib/palmade/asset_packager/base_package.rb", "lib/palmade/asset_packager/base_parser.rb", "lib/palmade/asset_packager/helpers/rails_helper.rb", "lib/palmade/asset_packager/helpers.rb", "lib/palmade/asset_packager/jsmin.rb", "lib/palmade/asset_packager/manager.rb", "lib/palmade/asset_packager/package.rb", "lib/palmade/asset_packager/parser.rb", "lib/palmade/asset_packager/rails_packager.rb", "lib/palmade/asset_packager/types/abstract.rb", "lib/palmade/asset_packager/types/compress.rb", "lib/palmade/asset_packager/types/image.rb", "lib/palmade/asset_packager/types/javascript.rb", "lib/palmade/asset_packager/types/stylesheet.rb", "lib/palmade/asset_packager/types.rb", "lib/palmade/asset_packager.rb", "lib/palmade/extend/action_controller/base.rb", "lib/palmade/extend/action_controller/instance.rb", "lib/palmade/extend/action_view/base.rb", "lib/palmade/extend/cells/base.rb", "lib/palmade/jsmin.rb", "lib/palmade/rails_packager.rb", "LICENSE", "README"]
  s.files = ["bin/asset_packer", "bin/rails_packer", "CHANGELOG", "COPYING", "lib/asset_packager/init.rb", "lib/asset_packer.rb", "lib/palmade/asset_packager/asset.rb", "lib/palmade/asset_packager/asset_base.rb", "lib/palmade/asset_packager/base.rb", "lib/palmade/asset_packager/base_package.rb", "lib/palmade/asset_packager/base_parser.rb", "lib/palmade/asset_packager/helpers/rails_helper.rb", "lib/palmade/asset_packager/helpers.rb", "lib/palmade/asset_packager/jsmin.rb", "lib/palmade/asset_packager/manager.rb", "lib/palmade/asset_packager/package.rb", "lib/palmade/asset_packager/parser.rb", "lib/palmade/asset_packager/rails_packager.rb", "lib/palmade/asset_packager/types/abstract.rb", "lib/palmade/asset_packager/types/compress.rb", "lib/palmade/asset_packager/types/image.rb", "lib/palmade/asset_packager/types/javascript.rb", "lib/palmade/asset_packager/types/stylesheet.rb", "lib/palmade/asset_packager/types.rb", "lib/palmade/asset_packager.rb", "lib/palmade/extend/action_controller/base.rb", "lib/palmade/extend/action_controller/instance.rb", "lib/palmade/extend/action_view/base.rb", "lib/palmade/extend/cells/base.rb", "lib/palmade/jsmin.rb", "lib/palmade/rails_packager.rb", "LICENSE", "Manifest", "Rakefile", "README", "test_bin/console", "asset_packager.gemspec"]
  s.homepage = %q{}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Asset_packager", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{palmade}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{An asset_packager for use with Rails and other frameworks}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

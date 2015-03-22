## Redmine Views Hooks
require 'redmine_danthes/hooks/add_danthes_client_javascript'

## Set up autoload of patches
Rails.configuration.to_prepare do

  ## Redmine JBox Deployer Libs and Patches
  rbfiles = Rails.root.join('plugins', 'redmine_danthes', 'lib', 'redmine_danthes', '**', '*.rb')
  Dir.glob(rbfiles).each do |file|
    # Exclude Redmine Views Hooks from Rails loader to avoid multiple calls to hooks on reload in dev environment.
    require_dependency file unless File.dirname(file) == Rails.root.join('plugins', 'redmine_danthes', 'lib', 'redmine_danthes', 'hooks').to_s
  end

end

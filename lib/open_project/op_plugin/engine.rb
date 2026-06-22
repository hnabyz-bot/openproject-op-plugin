require 'open_project/plugins'

module OpenProject
  module OpPlugin
    class Engine < ::Rails::Engine
      engine_name :openproject_op_plugin

      include OpenProject::Plugins::ActsAsOpEngine

      register 'openproject-op-plugin',
               author_url: 'https://github.com/your-org/openproject-op-plugin',
               should_render_global_custom_styles: true,
               bundled: false do

        project_module :op_plugin do
          permission :view_op_plugin, { 'op_plugin/entries' => %i[index] }
          permission :manage_op_plugin, { 'op_plugin/entries' => %i[new create edit update destroy] },
                     require: :member
        end

        menu :project_menu,
             :op_plugin,
             { controller: '/op_plugin/entries', action: :index },
             caption: :'project_module_op_plugin',
             after: :overview,
             icon: 'op-plugin'
      end

      initializer 'op_plugin.subscribe_to_notifications' do
        # Subscribe to OpenProject events
        # ActiveSupport::Notifications.subscribe('op.work_package.updated') do |data|
        # end
      end

      config.to_prepare do
        # Extend OpenProject models / services here
        # WorkPackage.include(OpenProject::OpPlugin::Patches::WorkPackagePatch)
      end
    end
  end
end

import { NgModule } from '@angular/core';
import { OpPluginModule } from './op-plugin.module';

// OpenProject plugin entry point.
// Symlinked to: $OPENPROJECT_ROOT/frontend/src/app/features/plugins/linked/op-plugin/
//
// The Angular CLI builds this as part of the core application.
// Import paths use 'core-app/' prefix (resolved via tsconfig.base.json in OP core).

@NgModule({
  imports: [OpPluginModule],
})
export class PluginModule {}

// Called by OpenProject core after Angular bootstraps.
// Use this to register field types, hooks, and custom elements.
window.OpenProject?.getPluginContext?.().then((context: unknown) => {
  // Example: register a work package tab
  // const ctx = context as OpenProjectPluginContext;
  // ctx.hooks.register('workPackageSingleTab', {
  //   id: 'op-plugin-tab',
  //   component: OpPluginTabComponent,
  //   title: 'Op Plugin',
  // });
});

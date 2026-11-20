import Component from "@glimmer/component";
import { fn } from "@ember/helper";
import { action } from "@ember/object";
import { service } from "@ember/service";
import DButton from "discourse/ui-kit/d-button";
import { i18n } from "discourse-i18n";

export default class QuickReplies extends Component {
  @service appEvents;

  get replies() {
    return (settings.quick_replies || []).filter((reply) => reply.text?.trim());
  }

  @action
  insert(text) {
    this.appEvents.trigger("composer:insert-text", text);
  }

  <template>
    {{#if this.replies.length}}
      <div
        aria-label={{i18n (themePrefix "quick_replies.title")}}
        class="quick-replies"
        role="group"
      >
        {{#each this.replies as |reply|}}
          <DButton
            class="quick-replies__bubble"
            @action={{fn this.insert reply.text}}
            @preventFocus={{true}}
            @translatedAriaLabel={{i18n
              (themePrefix "quick_replies.insert")
              text=reply.text
            }}
            @translatedLabel={{if reply.label reply.label reply.text}}
            @translatedTitle={{reply.text}}
          />
        {{/each}}
      </div>
    {{/if}}
  </template>
}

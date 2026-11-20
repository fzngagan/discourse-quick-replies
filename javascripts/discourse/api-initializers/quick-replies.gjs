import { apiInitializer } from "discourse/lib/api";
import QuickReplies from "../components/quick-replies.gjs";

export default apiInitializer((api) => {
  if (!settings.user_in_quick_replies_groups) {
    return;
  }

  api.renderInOutlet("composer-after-composer-editor", QuickReplies);
});

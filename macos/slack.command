#!/bin/bash

SLACK_THEME_FILE=/Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/ssb-interop.js
SLACK_THEME_CSS_SOURCE=https://cdn.jsdelivr.net/gh/laCour/slack-night-mode@master/css/raw/black.css

if ! grep -q "$SLACK_THEME_CSS_SOURCE" $SLACK_THEME_FILE; then
  cat <<EOT >> $SLACK_THEME_FILE

document.addEventListener('DOMContentLoaded', function() {
  let tt__customCss = '.menu ul li a:not(.inline_menu_link) {color: #fff !important;}'
  $.ajax({
    url: '$SLACK_THEME_CSS_SOURCE',
    success: function(css) {
      \$('<style></style>').appendTo('head').html(css + tt__customCss);
    }
  });
});
EOT
fi

echo ""
echo "Copy and paste these values to your Slack settings Sidebar Theme section:"
echo "#171717,#404245,#424242,#ECF0F1,#4A4A4A,#FAFAFA,#2ECC71,#00A362"

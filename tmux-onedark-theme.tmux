#!/bin/bash
onedark_black="#282c34"
onedark_blue="#0f80d5"
onedark_yellow="#e5c07b"
onedark_red="#e06c75"
onedark_white="#aab2bf"
onedark_white2="#bfc7d4"
onedark_green="#98c379"
onedark_visual_grey="#3e4452"
onedark_comment_grey="#5c6370"

get() {
   local option=$1
   local default_value=$2
   local option_value="$(tmux show-option -gqv "$option")"

   if [ -z "$option_value" ]; then
      echo "$default_value"
   else
      echo "$option_value"
   fi
}

set() {
   local option=$1
   local value=$2
   tmux set-option -gq "$option" "$value"
}

setw() {
   local option=$1
   local value=$2
   tmux set-window-option -gq "$option" "$value"
}

set "status" "on"
set "status-justify" "left"

set "status-left-length" "100"
set "status-right-length" "100"
# All styles below use the modern *-style options (tmux 3.2+). The old
# -fg/-bg/-attr options were removed from tmux and did nothing; values come
# from this palette or from the kitty-harmonized colors that previously lived
# in tmux.conf — consolidated here so the theme is the single visual source.

set "message-style" "fg=$onedark_black,bg=$onedark_green"
set "message-command-style" "fg=$onedark_black,bg=$onedark_blue,bold"

setw "window-status-separator" ""

# activity (agent/build output while away): theme blue, bold.
# bell: theme red — both flag-only in the status line.
setw "window-status-activity-style" "fg=$onedark_comment_grey,bold,italics"
setw "window-status-bell-style" "fg=$onedark_red,bold"
setw "window-status-style" "fg=$onedark_white,bg=$onedark_black"

# pane content dimming
set "window-style" "fg=#d6d6d6,bg=#202020"
set "window-active-style" "fg=#FFFFFF,bg=#000000"

setw "mode-style" "bg=#003f72"

set "pane-border-style" "fg=#505050,bg=#202020"
set "pane-active-border-style" "fg=#808080,bg=#202020"
setw "pane-border-lines" "heavy"
set "pane-border-indicators" "colour"
set "pane-scrollbars-style" "bg=#202020,fg=#323F4E"

set "display-panes-style" "fg=$onedark_blue,bg=$onedark_black"

# popups / menus (tmux-fzf, display-popup, display-menu)
set "popup-style" "bg=#1c1e23"
set "popup-border-style" "fg=#63f2f1,bg=#100E23"
set "popup-border-lines" "rounded"
set "menu-style" "bg=#1c1e23"
set "menu-selected-style" "bg=#003f72,fg=#FFFFFF,bold"
set "menu-border-style" "fg=#63f2f1,bg=#100E23"
set "menu-border-lines" "rounded"

# cursor
set "cursor-style" "blinking-bar"
set "cursor-colour" "$onedark_white2"

set "status-bg" "$onedark_black"
set "status-fg" "$onedark_white"

set "@prefix_highlight_fg" "$onedark_black"
set "@prefix_highlight_bg" "$onedark_green"
set "@prefix_highlight_copy_mode_attr" "fg=$onedark_black,bg=$onedark_green,bold,italics"
set "@prefix_highlight_output_prefix" "  "

status_widgets=$(get "@onedark_widgets")
time_format=$(get "@onedark_time_format" "%R")
date_format=$(get "@onedark_date_format" "%d/%m/%Y")

set "status-right" "#[fg=$onedark_white,bg=$onedark_black,nounderscore,noitalics]${time_format}  ${date_format} #[fg=$onedark_visual_grey,bg=$onedark_black]#[fg=$onedark_visual_grey,bg=$onedark_visual_grey]#[fg=$onedark_white, bg=$onedark_visual_grey]${status_widgets} #[fg=$onedark_green,bg=$onedark_visual_grey,nobold,nounderscore,noitalics]#[fg=$onedark_black,bg=$onedark_green,bold] #h #[fg=$onedark_yellow, bg=$onedark_green]#[fg=$onedark_red,bg=$onedark_yellow]"

set "status-left" "#[fg=$onedark_black,bg=$onedark_green,bold] #S #[fg=$onedark_black,bg=$onedark_green,bold,italics]#{prefix_highlight}#[fg=$onedark_green,bg=$onedark_black,nobold,nounderscore,noitalics]"

set "window-status-format" "#[fg=$onedark_black,bg=$onedark_black,nobold,nounderscore,noitalics]#[fg=$onedark_white,bg=$onedark_black] #I  #{?window_activity_flag,#[fg=$onedark_white bg=$onedark_black bold italics]#W ,#[fg=$onedark_white bg=$onedark_black]#W }#{?window_bell_flag,#[fg=$onedark_red]● ,#{?window_activity_flag,#[fg=$onedark_blue]● ,○ }}#[fg=$onedark_green,bg=$onedark_black]#{pane_current_command} #[fg=$onedark_black,bg=$onedark_black,nobold,nounderscore,noitalics]"

set "window-status-current-format" "#[fg=$onedark_black,bg=$onedark_visual_grey,nobold,nounderscore,noitalics]#[fg=$onedark_white2,bg=$onedark_visual_grey,bold] #I  #{?window_zoomed_flag,#[fg=$onedark_yellow] ,}#W#{?window_zoomed_flag,#[fg=$onedark_yellow] , }#{?window_bell_flag,#[fg=$onedark_red]● ,#{?window_activity_flag,#[fg=$onedark_blue]● ,● }}#[fg=$onedark_green,bg=$onedark_visual_grey]#{pane_current_command} #[fg=$onedark_visual_grey,bg=$onedark_black,nobold,nounderscore,noitalics]"

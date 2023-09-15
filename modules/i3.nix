{ config, pkgs, ... }: {
  text = ''
    # For the benefit of emacs users: -*- shell-script -*-
    #
    #  _ _____                    __ _
    # (_)___ /    ___ ___  _ __  / _(_) __ _
    # | | |_ \   / __/ _ \| '_ \| |_| |/ _` |
    # | |___) | | (_| (_) | | | |  _| | (_| |
    # |_|____/   \___\___/|_| |_|_| |_|\__, |
    #                                  |___/

    # Default modkey
    set $mod Mod4

    exec --no-startup-id xrandr --output DP-4 --mode 1920x1080 --pos 0x0 --rotate normal --output primary --mode 1920x1080 --pos 1920x0 --rotate normal

    # default font
    font pango:Fira Code 8

    # Start XDG autostart .desktop files using dex. See also
    # https://wiki.archlinux.org/index.php/XDG_Autostart
    exec --no-startup-id dex --autostart --environment i3

    # xss-lock grabs a logind suspend inhibit lock and will use i3lock to lock the
    # screen before suspend. Use loginctl lock-session to lock your screen.
    exec --no-startup-id xss-lock --transfer-sleep-lock -- i3lock --nofork

    # NetworkManager is the most popular way to manage wireless networks on Linux,
    # and nm-applet is a desktop environment-independent system tray GUI for it.
    exec --no-startup-id nm-applet

    # Use pactl to adjust volume in PulseAudio.
    set $refresh_i3status killall -SIGUSR1 i3status
    # bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10% && $refresh_i3status
    # bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10% && $refresh_i3status

    # bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status
    # bindsym XF86AudioMicMute exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status

    # Use Mouse+$mod to drag floating windows to their wanted position
    floating_modifier $mod

    # change focus
    bindsym $mod+j focus left
    bindsym $mod+k focus down
    bindsym $mod+l focus up
    bindsym $mod+semicolon focus right

    # alternatively, you can use the cursor keys:
    bindsym $mod+Left focus left
    bindsym $mod+Down focus down
    bindsym $mod+Up focus up
    bindsym $mod+Right focus right

    # move focused window
    bindsym $mod+Shift+j move left
    bindsym $mod+Shift+k move down
    bindsym $mod+Shift+l move up
    bindsym $mod+Shift+semicolon move right

    # alternatively, you can use the cursor keys:
    bindsym $mod+Shift+Left move left
    bindsym $mod+Shift+Down move down
    bindsym $mod+Shift+Up move up
    bindsym $mod+Shift+Right move right

    # split in horizontal orientation
    bindsym $mod+h split h

    # split in vertical orientation
    bindsym $mod+Shift+v split v

    # enter fullscreen mode for the focused container
    bindsym $mod+f fullscreen toggle

    # change container layout (stacked, tabbed, toggle split)
    bindsym $mod+s layout stacking
    bindsym $mod+w layout tabbed
    bindsym $mod+Shift+e layout toggle split

    # toggle tiling / floating
    bindsym $mod+Shift+space floating toggle

    # change focus between tiling / floating windows
    bindsym $mod+Alt+space focus mode_toggle

    # focus the parent container
    bindsym $mod+a focus parent

    # focus the child container
    #bindsym $mod+d focus child

    # Define names for default workspaces for which we configure key bindings later on.
    # We use variables to avoid repeating the names in multiple places.
    # Name the workspaces
    set $workspace1 "1:  "
    set $workspace2 "2:  "
    set $workspace3 "3:  "
    set $workspace4 "4:  "
    set $workspace5 "5:  "
    set $workspace6 "6:  "
    set $workspace7 "7:  "
    set $workspace8 "8: ♫ "
    set $workspace9 "9:  "
    set $workspace0 "10:  "

    set $ws1 "1"
    set $ws2 "2"
    set $ws3 "3"
    set $ws4 "4"
    set $ws5 "5"
    set $ws6 "6"
    set $ws7 "7"
    set $ws8 "8"
    set $ws9 "9"
    set $ws10 "10"

    # Always open workspaces in certain outputs
    workspace "1:  " output primary
    workspace "2:  " output primary
    workspace "3:  " output primary
    workspace "4:  " output primary
    workspace "5:  " output primary
    workspace "7:  " output DP-4
    workspace "8: ♫ " output DP-4
    workspace "9:  " output DP-4
    workspace "10:  " output DP-4

    # switch to workspace
    bindsym $mod+1 workspace number $ws1
    bindsym $mod+2 workspace number $ws2
    bindsym $mod+3 workspace number $ws3
    bindsym $mod+4 workspace number $ws4
    bindsym $mod+5 workspace number $ws5
    bindsym $mod+6 workspace number $ws6
    bindsym $mod+7 workspace number $ws7
    bindsym $mod+8 workspace number $ws8
    bindsym $mod+9 workspace number $ws9
    bindsym $mod+0 workspace number $ws10

    # move focused container to workspace
    bindsym $mod+Shift+1 move container to workspace number $ws1
    bindsym $mod+Shift+2 move container to workspace number $ws2
    bindsym $mod+Shift+3 move container to workspace number $ws3
    bindsym $mod+Shift+4 move container to workspace number $ws4
    bindsym $mod+Shift+5 move container to workspace number $ws5
    bindsym $mod+Shift+6 move container to workspace number $ws6
    bindsym $mod+Shift+7 move container to workspace number $ws7
    bindsym $mod+Shift+8 move container to workspace number $ws8
    bindsym $mod+Shift+9 move container to workspace number $ws9
    bindsym $mod+Shift+0 move container to workspace number $ws10

    # Multimedia keys
    bindsym XF86AudioPlay exec playerctl play-pause
    bindsym XF86AudioNext exec playerctl next
    bindsym XF86AudioPrev exec playerctl previous
    bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status
    bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10% && $refresh_i3status
    bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10% && $refresh_i3status
    bindsym XF86AudioMicMute exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status
    bindsym XF86MonBrightnessUp exec xbacklight -inc 10
    bindsym XF86MonBrightnessDown exec xbacklight -dec 10
    bindsym XF86ScreenSaver exec --no-startup-id xset dpms force off
    bindsym XF86PowerOff exec --no-startup-id systemctl poweroff
    bindsym XF86HomePage exec --no-startup-id firefox
    bindsym XF86Mail exec --no-startup-id thunderbird
    bindsym XF86Explorer exec --no-startup-id thunar
    bindsym XF86Calculator exec --no-startup-id gnome-calculator
    bindsym XF86Launch1 exec --no-startup-id spotify
    bindsym XF86Launch2 exec --no-startup-id discord
    bindsym XF86WLAN exec --no-startup-id nmcli radio wifi
    bindsym XF86Favorites exec --no-startup-id rofi -show drun -columns 3
    bindsym XF86Search exec --no-startup-id rofi -show drun -columns 3
    bindsym XF86Launch3 exec --no-startup-id code
    bindsym XF86Launch4 exec --no-startup-id copyq toggle
    bindsym XF86Launch5 exec --no-startup-id kdeconnect-indicator
    bindsym XF86Display exec --no-startup-id xrandr --output DP-4 --auto --right-of primary --rotate normal
    bindsym XF86KbdBrightnessUp exec --no-startup-id xbacklight -inc 10
    bindsym XF86KbdBrightnessDown exec --no-startup-id xbacklight -dec 10
    bindsym XF86RFKill exec --no-startup-id nmcli radio all
    bindsym XF86MyComputer exec --no-startup-id pcmanfm
    bindsym XF86AudioMedia exec --no-startup-id obsidian

    # reload the configuration file
    bindsym $mod+Shift+c reload
    # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
    bindsym $mod+Shift+Ctrl+r restart

    # resize window (you can also use the mouse for that)
    # Resize window (you can also use the mouse for that)
    mode "resize"
    {
        # Resize with the arrow keys
        bindsym Left  resize shrink width  1 px or 1 ppt
        bindsym Down  resize grow   height 1 px or 1 ppt
        bindsym Up    resize shrink height 1 px or 1 ppt
        bindsym Right resize grow   width  1 px or 1 ppt

        # Back to normal: Enter or Escape
        bindsym Return mode "default"
        bindsym Escape mode "default"
    }

    bindsym $mod+Shift+r mode "resize"

    # class                 border  bground text    indicator child_border
    client.focused          #6272A4 #6272A4 #F8F8F2 #6272A4   #6272A4
    client.focused_inactive #44475A #44475A #F8F8F2 #44475A   #44475A
    client.unfocused        #282A36 #282A36 #BFBFBF #282A36   #282A36
    client.urgent           #44475A #FF5555 #F8F8F2 #FF5555   #FF5555
    client.placeholder      #282A36 #282A36 #F8F8F2 #282A36   #282A36
    client.background       #F8F8F2

    bar {
            status_command i3status
    }

    for_window [class="kruler"] floating enable
    for_window [class="copyq"] floating enable

    # start a terminal
    bindsym $mod+Return exec kitty

    #bindsym $mod+p mode "$mode_system"

    # kill focused window
    bindsym $mod+q kill

    # start dmenu (a program launcher)
    bindsym $mod+space exec rofi -show drun -columns 3

    # own binds
    bindsym $mod+b exec brave
    bindsym $mod+Shift+b exec bitwarden
    bindsym $mod+c exec code
    bindsym $mod+d exec discord
    bindsym $mod+Shift+e exec element-desktop
    bindsym $mod+x exec kitty
    bindsym $mod+e exec thunar
    bindsym $mod+n exec obsidian
    bindsym $mod+z exec thunderbird
    bindsym $mod+p exec lua /etc/nixos/scripts/powermenu.lua
    bindsym $mod+r exec kruler
    bindsym $mod+Ctrl+r exec peek
    bindsym $mod+v exec copyq toggle
    bindsym $mod+Shift+q xkill

    # Switch to the next desktop
    bindsym $mod+Ctrl+Right workspace next

    # Switch to the previous desktop
    bindsym $mod+Ctrl+Left workspace prev

    # Startup programs
    exec - -no-startup-id pgrep - x polybar || polybar
    exec_always --no-startup-id /etc/nixos/scripts/default.sh
    exec_always --no-startup-id picom --config ~/.config/picom/picom.conf
    exec_always --no-startup-id xinput --set-prop "Synaptics TM3289-021" "libinput Natural Scrolling Enabled" 1
    exec "setxkbmap -layout us,de"
    exec "setxkbmap -option 'grp:alt_shift_toggle'"
    exec --no-startup-id kdeconnect-indicator
    exec --no-startup-id variety
    exec --no-startup-id discord
    exec --no-startup-id spotify
    exec --no-startup-id notify-send "Welcome back $USER!"
  '';
}

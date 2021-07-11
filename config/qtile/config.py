# Imports
import os
import re
import socket
import subprocess
from libqtile import qtile
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from typing import List  # noqa: F401

# Autostart script from ~/.config/qtile/autostart.sh
@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~/')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

mod = "mod4"
mod1 = "mod1"
mod2 = "control"
mod3 = "shift"
#home =  os.path.expanduser('~')
terminal = "st"

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),

    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),

    Key([mod], "space", lazy.layout.next(),desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),

    # Toggle Floating
    Key([mod, "shift"], "t", lazy.window.toggle_floating()),


    # Launch user defined terminal
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),

    # Keybinding to kill focused windows
    Key([mod], "x", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),

    # Keybinding to restart Qtile
    Key([mod], "q", lazy.restart(), desc="Restart Qtile"),

    # Keybindings to launch user defined programs
    Key([mod], "p", lazy.spawn("dmenu_run -fn 'Ubuntu-16' -nb '#282a2e' -sb '#5f819d'"), desc="launch dmenu"),
    Key([mod], "w", lazy.spawn("firefox-esr"), desc="launch firefox-esr"),
    Key([mod], "f", lazy.spawn("pcmanfm"), desc="launch pcmanfm"),

    # Audio controls
    Key([], "XF86AudioMute", lazy.spawn("hush")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("quieter")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("louder")),


    # Keybindings to close Qtile or "logout"
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),

    # ALT KEY Keybindings to launch alternative programs
    Key([mod1], "b", lazy.spawn("wal"), desc="launch wal script"),
    Key([mod1], "f", lazy.spawn("st -e vifm"), desc="launch vifm"),
    Key([mod1], "w", lazy.spawn("brave-browser"), desc="launch brave-browser"),
    Key([mod1], "e", lazy.spawn("geany"), desc="launch geany"),
    Key([mod], "y", lazy.spawn("scrot"), desc="take screenshot"),
    Key([mod], "s", lazy.spawn("xmenu.sh && scrot"), desc="launch xmenu"),

]


groups= [
                Group("1",
                      label="",
                     # spawn='firefox',
                      ),

                Group("2",
                      label="",
                      ),

                Group("3",
                      label="",
                      ),

                Group("4",
                      label="",
                      ),

                Group("5",
                      label=""),

                Group("6",
                      label="",
                      ),

                Group("7",
                      label="",
                      ),

                Group("8",
                      label=""),

                Group("9",
                      label="",
                      matches=[Match(wm_class=["zoom"]),
                               ],
                      ),

                Group("0",
                      label=""),
]

for i in range(len(groups)):
   keys.append(Key([mod], str((i)), lazy.group[str(i)].toscreen()))
   keys.append(Key([mod, "shift"], str((i)), lazy.window.togroup(str(i), switch_group=True)))

#LAYOUTS
layouts = [
    # layout.Stack(num_stacks=2),
    # layout.Columns(margin=7, border_width=4, border_focus="#ffffff", border_normal="#4c566a", ),
    # layout.Matrix(),
    # layout.RatioTile(margin=7)
    # layout.Tile(margin=7, border_width=3, border_focus="#ffffff", border_normal="#4c566a", new_client_position='top', ratio=0.55),
    # layout.VerticalTile(),
    # layout.Zoomy(
    #    margin=7,
    #    columnwidth=300,
    #),
    #layout.TreeTab(
    #        active_bg = 'ffffff',
    #        active_fg = '000000',
    #        bg_color = '293136',
    #        font = 'novamono for powerline',
    #        fontsize = 15,
    #        panel_width = 200,
    #        inactive_bg = 'a1acff',
    #        inactive_fg = '000000',
    #        sections = ['Qtile'],
    #        section_fontsize = 18,
    #       section_fg = 'ffffff',
    #        section_left = 70
    #),
    layout.MonadTall(margin=15, border_width=0, border_focus="#bc7cf7", border_normal="#4c566a"),
    layout.MonadWide(margin=15, border_width=0, border_focus="#bc7cf7", border_normal="#4c566a"),
    layout.Bsp      (margin=10, border_width=0, border_focus="#bc7cf7", border_normal="#4c566a", fair=False),
    layout.Max(),
]


colors =  [

        ["#1c1c1c", "#1c1c1c"], # color 0
        ["#373b41", "#373b41"], # color 1
        ["#c5c8c6", "#c5c8c6"], # color 2
        ["#a54242", "#a54242"], # color 3
        ["#5f819d", "#5f819d"], # color 4
        ["#373b41", "#373b41"], # color 5
        ["#b294bb", "#b294bb"], # color 6
        ["#81a2be", "#81a2be"], # color 7
        ["#e2c5dc", "#e2c5dc"], # color 8
        ["#5e8d87", "#5e8d87"]] # color 9

widget_defaults = dict(
    font='Inconsolata for powerline',
    fontsize=18,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Sep(
                    padding=6,
                    linewidth=0,
                    background=colors[3],
                ),

                widget.TextBox(
                    text='  ',
                    font="Ubuntu Nerd Font",
                    fontsize='18',
                    background=colors[3],
                    foreground=colors[0],
                    mouse_callbacks={'Button1': lambda: qtile.cmd_spawn("xmenu.sh")},
                    ),
                widget.TextBox(
                    text='\ue0be',
                    font="Inconsolata for powerline",
                    fontsize='33',
                    padding=0,
                    background=colors[3],
                    foreground=colors[0],
                ),

                #widget.TextBox(
                #    text='|',
                #    padding=0,
                #    foreground=colors[5],
                #),

                widget.GroupBox(
                    font="Ubuntu Nerd Font",
                    fontsize=16,
                    margin_y=3,
                    margin_x=6,
                    padding_y=7,
                    padding_x=6,
                    borderwidth=4,
                    active=colors[4],
                    inactive=colors[2],
                    rounded=False,
                    highlight_color=colors[2],
                    highlight_method="block",
                    this_current_screen_border=colors[7],
                    block_highlight_text_color=colors[0],
                ),

                #widget.TextBox(
                #    text='|',
                #    padding=0,
                #    foreground=colors[5],
                #),

                widget.Prompt(
                    background=colors[8],
                    foreground=colors[0],
                    font="Ubuntu Nerd Font",
                    fontsize=18,
                ),

                widget.Chord(
                    chords_colors={
                        'launch': ("#ff0000", "#ffffff"),
                    },
                        name_transform=lambda name: name.upper(),
                ),

                widget.TextBox(
                    text='\ue0be',
                    font="Inconsolata for powerline",
                    fontsize='33',
                    padding=0,
                    background=colors[0],
                    foreground=colors[4],
                ),

                widget.WindowName(
                    background=colors[4],
                        ),

                widget.TextBox(
                    text='\ue0be',
                    font="Inconsolata for powerline",
                    fontsize='33',
                    padding=0,
                    background=colors[4],
                    foreground=colors[0],
                ),


                widget.Spacer(),

               widget.TextBox(
                    text='\ue0be',
                    font="Inconsolata for powerline",
                    fontsize='33',
                    padding=0,
                    background=colors[0],
                    foreground=colors[7],
                ),

                widget.CurrentLayoutIcon(
                    custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
                    scale=0.45,
                    padding=0,
                    background=colors[7],
                    font="Ubuntu Nerd Font",
                    fontsize='14',
                ),

                widget.CurrentLayout(
					background=colors[7],
                ),
                 widget.TextBox(
                    text='\ue0be',
                    font="Inconsolata for powerline",
                    fontsize='33',
                    padding=0,
                    background=colors[7],
                    foreground=colors[3],
                ),

                widget.DF(
	            fmt = ' {}',
                    font="Ubuntu Nerd Font",
                    fontsize = 14,
	            partition = '/home',
	            format = '{uf}{m} ({r:.0f}%)',
	            visible_on_warn = False,
	            background = colors[3],
	            padding = 5,
	            mouse_callbacks={'Button1': lambda: qtile.cmd_spawn("st -e storage.sh")},
				),

                widget.TextBox(
                    text='\ue0be',
                    font="Inconsolata for powerline",
                    fontsize='33',
                    padding=0,
                    background=colors[3],
                    foreground=colors[6],
                ),

                widget.Systray(
                    background=colors[6],
                    icons_size=18,
                    padding=4,
                ),

                widget.Sep(
                    padding=8,
                    linewidth=0,
                    background=colors[6],
                ),

                widget.TextBox(
                    text='\ue0be',
                    font="Inconsolata for powerline",
                    fontsize='33',
                    padding=0,
                    background=colors[6],
                    foreground=colors[8],
                ),

                widget.Sep(
                    padding=6,
                    linewidth=0,
                    background=colors[8],
                ),

                widget.TextBox(
                    text=" ",
                    font="Ubuntu Nerd Font",
                    fontsize=14,
                    foreground=colors[0],
                    background=colors[8],
                    padding=0,
                    mouse_callbacks={'Button1': lambda: qtile.cmd_spawn("st -e htop")},
                ),

                widget.Memory(
                    background=colors[8],
                    foreground=colors[0],
                    font="Inconsolata for powerline",
                    fontsize=18,
                    format='{MemUsed: .0f} MB',
                    mouse_callbacks={'Button1': lambda: qtile.cmd_spawn("st -e htop")},
                ),

                widget.TextBox(
                    text='\ue0be',
                    font="Inconsolata for powerline",
                    fontsize='33',
                    padding=0,
                    background=colors[8],
                    foreground=colors[9],
                ),

                widget.TextBox(
                    text="蓼",
                    background=colors[9],
                    foreground=colors[0],
                ),

                widget.Volume(
                    background=colors[9],
                    foreground=colors[0],
                    font="Inconsolata for powerline",
                    fontsize=18,
                    mouse_callbacks={'Button3': lambda: qtile.cmd_spawn("st -e pulsemixer")},
                ),

                widget.TextBox(
                    text='\ue0be',
                    font="Inconsolata for powerline",
                    fontsize='33',
                    padding=0,
                    background=colors[9],
                    foreground=colors[4],
                ),

                widget.TextBox(
                    text=' ',
                    font="Ubuntu Nerd Font",
                    fontsize='14',
                    padding=0,
                    background=colors[4],
                    foreground=colors[0],
                ),

                widget.Clock(
                    font="Inconsolata for powerline",
                    foreground=colors[0],
                    background=colors[4],
                    fontsize=18,
                    format='%d %b, %A',
                ),

                widget.Sep(
                    padding=6,
                    linewidth=0,
                    background=colors[4],
                ),

                widget.TextBox(
                    text='\ue0be',
                    font="Inconsolata for powerline",
                    fontsize='33',
                    padding=0,
                    background=colors[4],
                    foreground=colors[7],
                ),

                widget.TextBox(
                    text=' ',
                    font="Inconsolata for powerline",
                    fontsize='18',
                    padding=0,
                    background=colors[7],
                    foreground=colors[0],
                ),

                widget.Clock(
                    font="Inconsolata for powerline",
                    foreground=colors[0],
                    background=colors[7],
                    fontsize=18,
                    format='%I:%M %p'
                ),

                widget.TextBox(
                    text='\ue0be',
                    font="Inconsolata for powerline",
                    fontsize='33',
                    padding=0,
                    background=colors[7],
                    foreground=colors[3],
                ),

                widget.Sep(
                    padding=6,
                    linewidth=0,
                    background=colors[3],
                ),
            ],
        36,
            opacity=0.95,
            background=colors[0],
            #margin=[8,2,0,2]
            ),
       ),
    ]

def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)

def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)

def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

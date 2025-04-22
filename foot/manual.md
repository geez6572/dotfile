foot.ini(5)                                               File Formats Manual                                              foot.ini(5)

NAME
       foot.ini - configuration file for foot(1)

DESCRIPTION
       foot  uses  the standard unix configuration format, with section based key/value pairs. The default section is usually unnamed,
       i.e. not prefixed with a [section]. However it can also be explicitly named [main], say if it needs to be reopened after any of
       the other sections.

       foot will search for a configuration file in the following locations, in this order:

           •   XDG_CONFIG_HOME/foot/foot.ini (defaulting to $HOME/.config/foot/foot.ini if unset)
           •   XDG_CONFIG_DIRS/foot/foot.ini (defaulting to /etc/xdg/foot/foot.ini if unset)

       An example configuration file containing all options with their default value  commented  out  will  usually  be  installed  to
       /etc/xdg/foot/foot.ini.

       Options are set using KEY=VALUE pairs:

           [colors]
           background=000000
           foreground=ffffff

       Empty values (KEY=) are not supported. String options do allow the empty string to be set, but it must be quoted: KEY="")

SECTION: main
       shell
           Executable  to  launch.  Typically  a  shell.  Default:  $SHELL if set, otherwise the user's default shell (as specified in
           /etc/passwd). You can also pass arguments. For example /bin/bash --norc.

       login-shell
           Boolean. If enabled, the shell will be launched as a login shell, by prepending a '-' to argv[0]. Default: no.

       term
           Value to set the environment variable TERM to. Default: foot

       font, font-bold, font-italic, font-bold-italic
           Comma separated list of fonts to use, in fontconfig format. That is, a font name followed by a list of colon-separated  op‐
           tions.  Most  noteworthy  is :size=n (or :pixelsize=n), which is used to set the font size. Note that the font size is also
           affected by the dpi-aware option.

           Examples:
               •   Dina:weight=bold:slant=italic
               •   Courier New:size=12
               •   Fantasque Sans Mono:fontfeatures=ss01
               •   Meslo LG S:size=12, Noto Color Emoji:size=12
               •   Courier New:pixelsize=8

           For each option, the first font is the primary font. The remaining fonts are fallback fonts that will be  used  whenever  a
           glyph cannot be found in the primary font.

           The  fallback fonts are searched in the order they appear. If a glyph cannot be found in any of the fallback fonts, the dy‐
           namic fallback list from fontconfig (for the primary font) is searched.

           font-bold, font-italic and font-bold-italic allow custom fonts to be used for bold/italic/bold+italic fonts. If left uncon‐
           figured, the bold/italic variants of the regular font(s) specified in font are used.  Note:  you  may  have  to  tweak  the
           size(s) of the custom bold/italic fonts to match the regular font.

           To disable bold and/or italic fonts, set e.g. font-bold to exactly the same value as font.

           size  is in points (as defined by the FontConfig format). To set a pixel size, use pixelsize instead. Note that pixel sizes
           are unaffected by DPI aware rendering (see dpi-aware), but are affected by desktop scaling.

           Default: monospace:size=8 (font), not set (font-bold, font-italic, font-bold-italic).

       font-size-adjustment
           Amount, in points, pixels or percent, to increment/decrement the font size when zooming in our out.

           Examples:
               font-size-adjustment=0.5   # Adjust by 0.5 points
               font-size-adjustment=10px  # Adjust by 10 pixels
               font-size-adjustment=7.5%  # Adjust by 7.5 percent

           Default: 0.5

       include
           Absolute path to configuration file to import.

           The import file has its own section scope. I.e. the including configuration is still in the default section after  the  in‐
           clude, regardless of which section the included file ends in.

               •   The path must be an absolute path, or start with ~/.
               •   Multiple include directives are allowed, but only one path per directive.
               •   Nested imports are allowed.

           Default: not set.

       line-height
           An absolute value, in points, that override line height from the font metrics.

           You can specify a height in pixels by using the px suffix: e.g. line-height=12px.

           Warning:  when  changing  the  font size at runtime (i.e. zooming in our out), foot will change the line height by the same
           percentage. However, due to rounding, it is possible the line height will be "too small" for some font sizes, causing  e.g.
           underscores to "disappear".

           See also: vertical-letter-offset.

           Default: not set.

       letter-spacing
           Spacing between letters, in points. A positive value will increase the cell size, and a negative value shrinks it.

           You can specify a letter spacing in pixels by using the px suffix: e.g. letter-spacing=2px.

           See also: horizontal-letter-offset.

           Default: 0.

       horizontal-letter-offset, vertical-letter-offset
           Configure  the  horizontal  and  vertical offsets used when positioning glyphs within cells, in points, relative to the top
           left corner.

           To specify an offset in pixels, append px: e.g. horizontal-letter-offset=2px.

           Default: 0.

       underline-offset
           Use a custom offset for underlines. The offset is, by default, in points and relative the font's baseline. A positive value
           positions the underline under the baseline, while a negative value positions it above the baseline.

           To specify an offset in pixels, append px: underline-offset=2px.

           If left unset (the default), the offset specified in the font is used, or estimated by foot if the font lacks underline po‐
           sitioning information.

           Default: unset.

       underline-thickness
           Use a custom thickness (height) for underlines. The thickness is, by default, in points.

           To specify a thickness in pixels, append px: underline-thickness=1px.

           If left unset (the default), the thickness specified in the font is used.

           Default: unset

       strikeout-thickness
           Use a custom thickness (height) for strikeouts. The thickness is, by default, in points.

           To specify a thickness in pixels, append px: strikeout-thickness=1px.

           If left unset (the default), the thickness specified in the font is used.

           Default: unset

       box-drawings-uses-font-glyphs
           Boolean. When disabled, foot generates box/line drawing characters itself. The are several advantages to doing this instead
           of using font glyphs:

               •   No antialiasing effects where e.g. line endpoints appear dimmed down, or blurred.
               •   Line- and box characters are guaranteed to span the entire cell, resulting in a gap-less appearance.
               •   No alignment issues, i.e. lines are centered when they should be.
               •   Many fonts lack some, or all, of the line- and box drawing characters, causing fallback fonts to be used, which re‐
                   sults in out-of-place looking glyphs (for example, badly sized).

           When enabled, box/line drawing characters are rendered using font glyphs. This may result in a more uniform look,  in  some
           use cases.

           When disabled, foot will render the following Unicode codepoints by itself:

               •   U+02500 - U+0259F
               •   U+02800 - U+028FF
               •   U+1Fb00 - U+1FB9B

           Default: no.

       dpi-aware
           Boolean.

           When  set  to  yes, fonts are sized using the monitor's DPI, making a font of a given size have the same physical size, re‐
           gardless of monitor. In other words, if you drag a foot window between different monitors, the font size remains the same.

           In this mode, the monitor's scaling factor is ignored; doubling the scaling factor will not double the font size.

           When set to no, the monitor's DPI is ignored. The font is instead sized using the monitor's scaling  factor;  doubling  the
           scaling factor does double the font size.

           Note that this option typically does not work with bitmap fonts, which only contains a pre-defined set of sizes, and cannot
           be dynamically scaled. Whichever size (of the available ones) that best matches the DPI or scaling factor, will be used.

           Also  note  that  if  the  font  size  has  been  specified in pixels (:pixelsize=N, instead of :size=N), DPI scaling (dpi-
           aware=yes) will have no effect (the specified pixel size will be used as is). But, if the monitor's scaling factor is  used
           to size the font (dpi-aware=no), the font's pixel size will be multiplied with the scaling factor.

           Default: no

       pad
           Padding between border and glyphs, in pixels (subject to output scaling), in the form XxY.

           This  will  add at least X pixels on both the left and right sides, and Y pixels on the top and bottom sides. The grid con‐
           tent will be anchored in the top left corner. I.e. if the window manager forces an odd window size on foot, the  additional
           pixels will be added to the right and bottom sides.

           To instead center the grid content, append center (e.g. pad=5x5 center).

           Default: 0x0.

       resize-delay-ms

           Time,  in  milliseconds, of "idle time" before foot performs text reflow, and sends the new window dimensions to the client
           application while doing an interactive resize of a foot window. Idle time in this context is a period  of  time  where  the
           window size is not changing.

           In  other  words,  while you are fiddling with the window size, foot does not send the updated dimensions to the client. It
           also does a fast "truncating" resize of the grid, instead of actually reflowing the contents. Only when you pause the  fid‐
           dling for resize-delay-ms milliseconds is the client updated, and the contents properly reflowed.

           Emphasis  is  on  while here; as soon as the interactive resize ends (i.e. when you let go of the window border), the final
           dimensions is sent to the client, without any delays.

           Setting it to 0 disables the delay completely.

           Default: 100.

       resize-by-cells
           Boolean.

           When set to yes, the window size will be constrained to multiples of the cell size (plus any configured padding). When  set
           to no, the window size will be unconstrained, and padding may be adjusted as necessary to accommodate window sizes that are
           not multiples of the cell size.

           This  option  only  applies  to floating windows. Sizes of maxmized, tiled or fullscreen windows will not be constrained to
           multiples of the cell size.

           Default: yes

       resize-keep-grid
           Boolean.

           When set to yes, the window size will be adjusted with changes in font size to preserve the dimensions of  the  text  grid.
           When set to no, the window size will remain constant and the text grid will be adjusted as necessary to fit the window.

           This option only applies to floating windows.

           Default: yes

       initial-window-size-pixels
           Initial  window  width  and height in pixels (subject to output scaling), in the form WIDTHxHEIGHT. The height includes the
           titlebar when using CSDs. Mutually exclusive to initial-window-size-chars.

           Note that this option may not work as expected if fractional scaling is being used, due to the fact that  many  compositors
           do not report the correct scaling factor until after a window has been mapped.

           Default: 700x500.

       initial-window-size-chars
           Initial window width and height in characters, in the form WIDTHxHEIGHT. Mutually exclusive to initial-window-size-pixels.'

           Note  that  if  you have a multi-monitor setup, with different scaling factors, there is a possibility the window size will
           not be set correctly. If that is the case, use initial-window-size-pixels instead.

           And, just like initial-window-size-pixels, this option may not work as expected if fractional scaling is  being  used  (see
           initial-window-size-pixels for details).

           Default: not set.

       initial-window-mode
           Initial window mode for each newly spawned window: windowed, maximized or fullscreen. Default: windowed.

       title
           Initial window title. Default: foot.

       locked-title
           Boolean. If enabled, applications are not allowed to change the title at run-time. Default: no.

       app-id
           Value  to  set  the app-id property on the Wayland window to. The compositor can use this value to e.g. group multiple win‐
           dows, or apply window management rules. Default: foot (normal mode), or footclient (server mode).

       bold-text-in-bright
           Semi-boolean. When enabled, bold text is rendered in a brighter color (in addition to using a  bold  font).  The  color  is
           brightened by increasing its luminance.

           If set to palette-based, rather than a simple yes|true, colors matching one of the 8 regular palette colors will be bright‐
           ened using the corresponding bright palette color. Other colors will not be brightened.

           Default: no.

       word-delimiters
           String  of  characters that act as word delimiters when selecting text. Note that whitespace characters are always word de‐
           limiters, regardless of this setting. Default: ,│‘|:"'()[]{}<>

       selection-target
           Clipboard target to automatically copy selected text to. One of none, primary, clipboard or both. Default: primary.

       workers
           Number of threads to use for rendering. Set to 0 to disable multithreading. Default: the number of available  logical  CPUs
           (including SMT). Note that this is not always the best value. In some cases, the number of physical cores is better.

       utmp-helper
           Path to utmp logging helper binary.

           When starting foot, an utmp record is created by launching the helper binary with the following arguments:

               add $WAYLAND_DISPLAY

           When foot is closed, the utmp record is removed by launching the helper binary with the following arguments:

               del $WAYLAND_DISPLAY

           Set to none to disable utmp records. Default: /usr/lib/utempter/utempter.

SECTION: environment
       This  section  is used to define environment variables that will be set in the client application, in addition to the variables
       inherited from the terminal process itself.

       The format is simply:

       name=value

       Note: do not set TERM here; use the term option in the main (default) section instead.

SECTION: bell
       urgent
           When set to yes, foot will signal urgency to the compositor through the XDG activation protocol whenever BEL  is  received,
           and the window does NOT have keyboard focus.

           If the compositor does not implement this protocol, the margins will be painted in red instead.

           Applications can enable/disable this feature programmatically with the CSI ? 1042 h and CSI ? 1042 l escape sequences.

           Default: no

       notify
           When set to yes, foot will emit a desktop notification using the command specified in the notify option whenever BEL is re‐
           ceived.  By  default, bell notifications are shown only when the window does not have keyboard focus. See desktop-notifica‐
           tions.inhibit-when-focused.

           Default: no

       visual
           When set to yes, foot will flash the terminal window. Default: no

       command
           When set, foot will execute this command when BEL is received. Default: none

       command-focused
           Whether to run the command on BEL even while focused. Default: no

SECTION: desktop-notifications
       command
           Command to execute to display a notification.

           Template arguments
               ${title} and ${body} will be replaced with the notification's actual title and body (message content).

               ${app-id} is replaced with the value of the command line option --app-id, and defaults to foot (normal mode), or  foot‐
               client (server mode).

               ${window-title} is replaced with the current window title.

               ${icon}  is  replaced  by the icon specified in the notification request, or the empty string if no icon was specified.
               Can be used with e.g. notify-send's --icon option, or preferably, by setting the image-path  hint  (with  e.g.  notify-
               send's --hint option).

               ${category} is replaced by the notification's catogory. Can be used together with e.g. notify-send's --category option.

               ${urgency}  is replaced with the notifications urgency; low, normal or critical. Can be used together with e.g. notify-
               send's --urgency option.

               ${expire-time} is replaced with the notification specified notification timeout. Can be used together with e.g. notify-
               send's --expire-time option.

               ${replace-id} is replaced by the notification daemon assigned ID that the notification replaces/updates.  For  this  to
               work,  foot needs to know the externally assigned IDs of previously emitted notifications, see the 'stdout' section be‐
               low. Can be used together with e.g. notify-send's --replace-id option.

               ${muted} is replaced by either true or false, depending on whether the  notification  has  requested  all  notification
               sounds be muted. It is intended to set the suppress-sound hint (with e.g. notify-send's --hint option).

               ${sound-name} is replaced by sound-name requested by the notification. This should be a name from the freedesktop sound
               naming  specification,  but  this  is not something that foot enforces. It is intended to set the sound-name hint (with
               e.g. notify-send's --hint option).

               ${action-argument} will be expanded to the command-action-argument option, for each notification action. There will al‐
               ways be at least one action, the "default" action. Foot uses this to enable window focusing, and reporting notification
               activation to applications that requested such events.

               Applications can also define their own custom notification actions. See the command-action-argument option for details.

           Ways to trigger notifications
               Applications can trigger notifications in the following ways:

               •   OSC 777: \e]777;notify;<title>;<body>\e\\
               •   OSC 99: \e]99;;<title>\e\\ (this  is  just  a  bare  bones  example;  this  protocol  has  lots  of  features,  see
                   https://sw.kovidgoyal.net/kitty/desktop-notifications)

               By  default, notifications are inhibited if the foot window has keyboard focus. See desktop-notifications.inhibit-when-
               focused.

           Window activation (focusing)
               Foot can focus the window when the notification is 'activated'. It can also send an event back to the  client  applica‐
               tion,  notifying  it  that the notification has been 'activated', This typically happens when the default action is in‐
               voked, and/or when the notification is clicked, but exact behavior depends on the notification daemon in use,  and  how
               it has been configured.

               For  this  to work, foot needs to know when the notification was activated (as opposed to just dismissed), and it needs
               an XDG activation token.

               There are two parts to handle this. First, the notification must define an action. For this purpose, foot  will  add  a
               "default" action to the notification (see the command-action-argument option).

               Second, foot needs to know when the notification is activated, and it needs to get hold of the XDG activation token.

               Both are expected to be printed on stdout.

               Foot expects the action name (not label) to be printed on a single line. No prefix, no postfix.

               Foot expects the activation token to be printed on a single line, prefixed with xdgtoken=.

               Example:
                   default
                   xdgtoken=18179adf579a7a904ce73754964b1ec3

               The expected format of stdout may change at any time. Please read the changelog when upgrading foot.

               Note:  notify-send  does  not, out of the box, support reporting the XDG activation token in any way. This means window
               activation will not work by default.

           Stdout
               Foot recognizes the following things from the notification helper's stdout:

               •   id: integer in base 10, daemon assigned notification ID
               •   id=id: same as plain nnn.
               •   default: the 'default' action was triggered
               •   action=default: same as default
               •   action=n: application custom action n triggered
               •   n: integer in base 10, appearing after the ID; application custom action n triggered
               •   xdgtoken=xyz: XDG activation token.

               Example #1:
                   17
                   action=default
                   xdgtoken=95ebdfe56e4f47ddb5bba9d7dc3a2c35

                   Foot recognizes this as:
                   •   notification has the daemon assigned ID 17
                   •   the user triggered the default action
                   •   the notification send an XDG activation token

               Example #2:
                   17
                   1

                   Foot recognizes this as:
                   •   notification has the daemon assigned ID 17
                   •   the user triggered the first custom action, "1"

               Example #3:
                   id=17
                   1

                   Foot recognizes this as:
                   •   notification has the daemon assigned ID 17
                   •   the user triggered the first custom action, "1

           Default: notify-send
                          --wait
                          --app-name    ${app-id}
                          --icon        ${app-id}
                          --category    ${category}
                          --urgency     ${urgency}
                          --expire-time ${expire-time}
                          --hint        STRING:image-path:${icon}
                          --hint        BOOLEAN:suppress-sound:${muted}
                          --hint        STRING:sound-name:${sound-name}
                          --replace-id  ${replace-id}
                          ${action-argument}
                          --print-id
                          -- ${title} ${body}.

       command-action-argument
           String to use with command to enable passing action/button names to the notification helper.

           Foot will always configure a "default" action that can be used to "activate" the notification, which in turn can cause  the
           foot  window to be focused, or an escape to be sent to the terminal application (depending on how the application generated
           the notification).

           Furthermore, the OSC-99 notifications protocol allows applications to define their own actions. Foot uses a combination  of
           the command option, and the command-action-argument option to pass the names of the actions to the notification helper.

           This option has the following template arguments:

           •   ${action-name}: the name of the action; default for the default action configured by foot, and n, where n is an integer
               >= 1, for application defined actions.
           •   ${action-label}: Activate for the default action, and a free-form string for application defined actions.

           For  each  notification action (remember, there will always be at least one), command-action-argument will be expanded with
           the action's name and label.

           Then, ${action-argument} is expanded command to the full list of actions.

           If command-action-argument is set to the empty string, no actions will be passed to command.  That  is,  ${action-argument}
           will be replaced with the empty string.

           Example:

           command-action-argument=--action ${action-name}=${action-label}
           command=notify-send ${action-argument} ...

           Assume the application defined two custom actions: OK and Cancel.

           Given the above, foot will execute:

               notify-send
                              --action default='Click to activate'
                              --action 1=OK
                              --action 2=Cancel
                              ...

           Default: --action ${action-name}=${action-label}

       close
           Command to execute to close an existing notification.

           ${id} is expanded to the ID of the notification that should be closed. For example:

               fyi --close ${id}

           Closing a notification is only supported by the Kitty Desktop Notification protocol, OSC-99.

           If  set to the empty string (the default), foot will instead try to close the notification by sending SIGINT to the notifi‐
           cation helper process. For example, notify-send --wait (libnotify >= 0.8.0) responds to SIGINT by closing the notification.

           Default: not set

       inhibit-when-focused
           Boolean. If enabled, foot will not display notifications if the terminal window has keyboard focus.

           Default: yes

SECTION: scrollback
       lines
           Number of scrollback lines. The maximum number of allocated lines will be this value plus  the  number  of  visible  lines,
           rounded up to the nearest power of 2. Default: 1000.

       multiplier
           Amount to multiply mouse scrolling with. It is a decimal number, i.e. fractions are allowed. Default: 3.0.

       indicator-position
           Configures the style of the scrollback position indicator. One of none, fixed or relative. none disables the indicator com‐
           pletely.  fixed always renders the indicator near the top of the window, and relative renders the indicator at the position
           corresponding to the current scrollback position. Default: relative.

       indicator-format
           Which format to use when displaying the scrollback position indicator. Either percentage, line, or a custom  fixed  string.
           This option is ignored if indicator-position=none. Default: empty string.

SECTION: url
       launch
           Command to execute when opening URLs. ${url} will be replaced with the actual URL. Default: xdg-open ${url}.

       osc8-underline
           When to underline OSC-8 URLs. Possible values are url-mode and always.

           When set to url-mode, OSC-8 URLs are only highlighted in URL mode, just like auto-detected URLs.

           When  set  to always, OSC-8 URLs are always highlighted, regardless of their other attributes (bold, italic etc). Note that
           this does not make them clickable.

           Default: url-mode

       label-letters
           String of characters to use when generating key sequences for URL jump labels.

           If you change this option to include the letter t, you should also change the default [url-bindings].toggle-url-visible key
           binding to avoid a clash.

           Default: sadfjklewcmpgh.

       protocols
           Comma separated list of protocols (schemes) that should be recognized in URL mode. Note that only  auto-detected  URLs  are
           affected by this option. OSC-8 URLs are always enabled, regardless of protocol. Default: http, https, ftp, ftps, file, gem‐
           ini, gopher, irc, ircs.

       uri-characters
           Set of characters allowed in auto-detected URLs. Any character not included in this set constitutes a URL delimiter.

           Default: abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.,~:;/?#@!$&%*+="'()[]

SECTION: cursor
       This section controls the cursor style and color. Note that applications can change these at runtime.

       style
           Configures  the default cursor style, and is one of: block, beam or underline. Note that this can be overridden by applica‐
           tions. Default: block.

       unfocused-style
           Configures how the cursor is rendered when the terminal window is unfocused. Possible values are:

           •   unchanged: render cursor in exactly the same way as when the window has focus.
           •   hollow: render a block cursor, but hollowed out.
           •   none: do not display any cursor at all.

       blink
           Boolean. Enables blinking cursor. Note that this can be overridden by applications. Related  option:  blink-rate.  Default:
           no.

       blink-rate
           The  rate  at  which the cursor blink, when cursor blinking has been enabled. Expressed in milliseconds between each blink.
           Default: 500.

       color
           Two space separated RRGGBB values (i.e. plain old 6-digit hex values, without prefix) specifying the foreground (text)  and
           background (cursor) colors for the cursor.

           Example: ff0000 00ff00 (green cursor, red text)

           Default: the regular foreground and background colors, reversed.

       beam-thickness
           Thickness (width) of the beam styled cursor. The value is in points, and its exact value thus depends on the monitor's DPI.
           To instead specify a thickness in pixels, use the px suffix: e.g. beam-thickness=2px. Default: 1.5

       underline-thickness
           Thickness  (height)  of  the underline styled cursor. The value is in points, and its exact value thus depends on the moni‐
           tor's DPI.

           To instead specify a thickness in pixels, use the px suffix: e.g. underline-thickness=2px.

           Note that if left unset, the cursor's thickness will scale with the font size, while if set, the size is fixed.

           Default: font underline thickness.

SECTION: mouse
       hide-when-typing
           Boolean. When enabled, the mouse cursor is hidden while typing. Default: no.

       alternate-scroll-mode
           Boolean. This option controls the initial value for the alternate scroll mode. When this  mode  is  enabled,  mouse  scroll
           events are translated to up/down key events when displaying the alternate screen.

           This lets you scroll with the mouse in e.g. pagers (like less) without enabling native mouse support in them.

           Alternate scrolling is not used if the application enables native mouse support.

           This  option  can be modified by applications at run-time using the escape sequences CSI ? 1007 h (enable) and CSI ? 1007 l
           (disable).

           Default: yes.

SECTION: touch
       long-press-delay
           Number of milliseconds to distinguish between a short press and a long press on the touchscreen.

           Default: 400.

SECTION: colors
       This section controls the 16 ANSI colors, the default foreground and background colors, and the  extended  256  color  palette.
       Note that applications can change these at runtime.

       The  colors are in RRGGBB format (i.e. plain old 6-digit hex values, without prefix). That is, they do not have an alpha compo‐
       nent. You can configure the background transparency with the alpha option.

       foreground
           Default foreground color. This is the color used when no ANSI color is being used. Default: 839496.

       background
           Default background color. This is the color used when no ANSI color is being used. Default: 002b36.

       regular0, regular1 .. regular7
           The eight basic ANSI colors (Black, Red, Green, Yellow, Blue, Magenta,  Cyan,  White).  Default:  242424,  f62b5a,  47b413,
           e3c401, 24acd4, f2affd, 13c299, e6e6e6 (starlight theme, V4).

       bright0, bright1 .. bright7
           The  eight  bright  ANSI  colors  (Black, Red, Green, Yellow, Blue, Magenta, Cyan, White). Default: 616161, ff4d51, 35d450,
           e9e836, 5dc5f8, feabf2, 24dfc4, ffffff (starlight theme, V4).

       dim0, dim1 .. dim7
           Custom colors to use with dimmed colors. Dimmed colors do not have an entry in the color palette. Applications emit them by
           combining a color value, and a "dim" attribute.

           By default, foot implements this by reducing the luminance of the current color. This is a generic approach that applies to
           both colors from the 256-color palette, as well as 24-bit RGB colors.

           You can change this behavior by setting the dimN options. When set, foot will match the current  color  against  the  color
           palette, and if it matches one of the regularN colors, the corresponding dimN color will be used.

           If instead the current color matches one of the brightN colors, the corresponding regularN color will be used.

           If  the  current color does not match any known color, it is dimmed by reducing the luminance (i.e. the same behavior as if
           the dimN options are unconfigured). 24-bit RGB colors will typically fall into this category.

           Note that applications can change the regularN and brightN colors at runtime. However, they have no  way  of  changing  the
           dimN  colors.  If an application has changed the regularN colors, foot will still use the corresponding dimN color, as con‐
           figured in foot.ini.

           Default: not set.

       0 .. 255
           Arbitrary colors  in  the  256-color  palette.  Default:  for  0  ..  15,  see  regular  and  bright  defaults  above;  see
           https://en.wikipedia.org/wiki/ANSI_escape_code#8-bit for an explanation of the remainder.

       sixel0 .. sixel15
           The  default  sixel color palette. Default: 000000, 3333cc, cc2121, 33cc33, cc33cc, 33cccc, cccc33, 878787, 424242, 545499,
           994242, 549954, 995499, 549999, 999954, cccccc.

       alpha
           Background translucency. A value in the range 0.0-1.0, where 0.0 means completely transparent, and 1.0 is opaque.  Default:
           1.0.

       selection-foreground, selection-background
           Foreground  (text) and background color to use in selected text. Note that both options must be set, or the default will be
           used. Default: inverse foreground/background.

       jump-labels
           Two color values specifying the foreground (text) and background colors to use when rendering jump labels in URL mode.  De‐
           fault: regular0 regular3.

       scrollback-indicator
           Two  color  values  specifying the foreground (text) and background (indicator itself) colors for the scrollback indicator.
           Default: regular0 bright4.

       search-box-no-match
           Two color values specifying the foreground (text) and background colors for the scrollback search box, when  there  are  no
           matches. Default: regular0 regular1.

       search-box-match
           Two  color values specifying the foreground (text) and background colors for the scrollback search box, when the search box
           is either empty, or there are matches. Default: regular0 regular3.

       urls
           Color to use for the underline used to highlight URLs in URL mode. Default: regular3.

       flash
           Color to use for the terminal window flash. Default: 7f7f00.

       flash-alpha
           Flash translucency. A value in the range 0.0-1.0, where 0.0 means completely transparent, and 1.0 is opaque. Default: 0.5.

SECTION: csd
       This section controls the look of the CSDs (Client Side Decorations). Note that the default is to not use CSDs, but instead  to
       use SSDs (Server Side Decorations) when the compositor supports it.

       Note  that  unlike  the colors defined in the colors section, the color values here are in AARRGGBB (i.e. plain old 8-digit hex
       values) format. I.e. they contain an alpha component - 00 means completely transparent, and ff fully opaque.

       Examples:

       •   ffffffff: white, fully opaque
       •   ff000000: black, fully opaque
       •   7fffffff: white, semi-transparent
       •   ff00ff00: green, fully opaque

       preferred
           Which type of window decorations to prefer: client (CSD), server (SSD) or none.

           Note that this is only a hint to the compositor. Depending on compositor support, and how it has been  configured,  it  may
           instruct foot to use CSDs even though this option has been set to server, or render SSDs despite client or none being set.

           Default: server.

       size
           Height, in pixels (subject to output scaling), of the titlebar. Setting it to 0 will hide the titlebar, while still showing
           the border (if border-width is set to a non-zero value). Default: 26.

       color
           Titlebar color. Default: use the default foreground color.

       font
           Font  to  use for the title bar. This is a list of fonts, similar to the main font option. Note that the font will be sized
           using the title bar size. That is, all :size and :pixelsize attributes will be ignored. Default: primary font.

       hide-when-maximized
           Boolean. When enabled, the CSD titlebar is hidden when the window is maximized. The completely disable  the  titlebar,  set
           size to 0 instead. Default: no.

       double-click-to-maximize
           Boolean. When enabled, double-clicking the CSD titlebar will (un)maximize the window. Default: yes.

       border-width
           Width  of  the border, in pixels (subject to output scaling). Note that the border encompasses the entire window, including
           the title bar. Default: 0.

       border-color
           Color of border. By default, the title bar color is used. If the title bar color has not been set, the  default  foreground
           color (from the color scheme) is used. Default: titlebar color.

       button-width
           Width, in pixels (subject to output scaling), of the minimize/maximize/close buttons. Default: 26.

       button-color
           Foreground color on the minimize/maximize/close buttons. Default: use the default background color.

       button-minimize-color
           Minimize button's background color. Default: use the default regular4 color (blue).

       button-maximize-color
           Maximize button's background color. Default: use the default regular2 color (green).

       button-close-color
           Close button's background color. Default: use the default regular1 color (red).

SECTION: key-bindings
       This section lets you override the default key bindings.

       The general format is action=combo1...comboN. That is, each action may have one or more key combinations, space separated. Each
       combination is in the form mod1+mod2+key. The names of the modifiers and the key must be valid XKB key names.

       Note that if Shift is one of the modifiers, the key must not be in upper case. For example, Control+Shift+V will never trigger,
       but Control+Shift+v will.

       Note that Alt is usually called Mod1.

       xkbcli interactive-wayland can be useful for finding keysym names.

       A  key combination can only be mapped to one action. Lets say you want to bind Control+Shift+R to fullscreen. Since this is the
       default shortcut for search-start, you first need to unmap the default binding. This can be done by setting  action=none;  e.g.
       search-start=none.

       noop
           All key combinations listed here will not be sent to the application. Default: none.

       scrollback-up-page
           Scrolls up/back one page in history. Default: Shift+Page_Up.

       scrollback-up-half-page
           Scrolls up/back half of a page in history. Default: none.

       scrollback-up-line
           Scrolls up/back a single line in history. Default: none.

       scrollback-down-page
           Scroll down/forward one page in history. Default: Shift+Page_Down.

       scrollback-down-half-page
           Scroll down/forward half of a page in history. Default: none.

       scrollback-down-line
           Scroll down/forward a single line in history. Default: none.

       scrollback-home
           Scroll to the beginning of the scrollback. Default: none.

       scrollback-end
           Scroll to the end (bottom) of the scrollback. Default: none.

       clipboard-copy
           Copies the current selection into the clipboard. Default: Control+Shift+c XF86Copy.

       clipboard-paste
           Pastes from the clipboard. Default: Control+Shift+v XF86Paste.

       primary-paste
           Pastes from the primary selection. Default: Shift+Insert (also defined in mouse-bindings).

       search-start
           Starts a scrollback/history search. Default: Control+Shift+r.

       font-increase
           Increases the font size by 0.5pt. Default: Control+plus Control+equal Control+KP_Add (also defined in mouse-bindings).

       font-decrease
           Decreases the font size by 0.5pt. Default: Control+minus Control+KP_Subtract (also defined in mouse-bindings).

       font-reset
           Resets the font size to the default. Default: Control+0 Control+KP_0.

       spawn-terminal
           Spawns  a  new terminal. If the shell has been configured to emit the OSC 7 escape sequence, the new terminal will start in
           the current working directory. Default: Control+Shift+n.

       minimize
           Minimizes the window. Default: none.

       maximize
           Toggle the maximized state. Default: none.

       fullscreen
           Toggles the fullscreen state. Default: none.

       pipe-visible, pipe-scrollback, pipe-selected, pipe-command-output
           Pipes the currently visible text, the entire scrollback, the currently selected text, or the last command's  output  to  an
           external  tool. The syntax for this option is a bit special; the first part of the value is the command to execute enclosed
           in "[]", followed by the binding(s).

           You can configure multiple pipes as long as the command strings are different and the key bindings are unique.

           Note that the command is not automatically run inside a shell; use sh -c "command line" if you need that.

           Example #1:
               # Extract currently visible URLs, let user choose one (via fuzzel), then launch firefox with the selected URL
               pipe-visible=[sh -c "xurls | uniq | tac | fuzzel | xargs -r firefox"] Control+Print

           Example #2:
               # Open scrollback contents in Emacs running in a new foot instance
               pipe-scrollback=[sh -c "f=$(mktemp) && cat - > $f && foot emacsclient -t $f; rm $f"] Control+Shift+Print

           Default: none

       show-urls-launch
           Enter URL mode, where all currently visible URLs are tagged with a jump label with a key sequence that will  open  the  URL
           (and exit URL mode). Default: Control+Shift+o.

       show-urls-persistent
           Similar to show-urls-launch, but does not automatically exit URL mode after activating an URL. Default: none.

       show-urls-copy
           Enter  URL  mode, where all currently visible URLs are tagged with a jump label with a key sequence that will place the URL
           in the clipboard. Default: none.

       prompt-prev
           Jump to the previous, currently not visible, prompt (requires shell integration, see foot(1)). Default: Control+Shift+z.

       prompt-next
           Jump the next prompt (requires shell integration, see foot(1)). Default: Control+Shift+x.

       unicode-input
           Input a Unicode character by typing its codepoint in hexadecimal, followed by Enter or Space.

           For example, to input the character ö (LATIN SMALL LETTER O WITH DIAERESIS, Unicode codepoint 0xf6), you would first  acti‐
           vate this key binding, then type: f, 6, Enter.

           Another  example:  to input 😍 (SMILING FACE WITH HEART-SHAPED EYES, Unicode codepoint 0x1f60d), activate this key binding,
           then type: 1, f, 6, 0, d, Enter.

           Recognized key bindings in Unicode input mode:

           •   Enter, Space: commit the Unicode character, then exit this mode.
           •   Escape, q, Ctrl+c, Ctrl+d, Ctrl+g: abort input, then exit this mode.
           •   0-9, a-f: append next digit to the Unicode's codepoint.
           •   Backspace: undo the last digit.

           Note that there is no visual feedback while in this mode. This is by design; foot's Unicode input mode is considered to  be
           a fallback. The preferred way of entering Unicode characters, emojis etc is by using an IME.

           Default: Control+Shift+u.

       quit
           Quit foot. Default: none.

SECTION: search-bindings
       This  section  lets you override the default key bindings used in scrollback search mode. The syntax is exactly the same as the
       regular key-bindings.

       cancel
           Aborts the search. The viewport is restored and the primary selection is not updated. Default: Control+g Control+c Escape.

       commit
           Exit search mode and copy current selection into the primary selection. Viewport is not restored. To copy the selection  to
           the regular clipboard, use Control+Shift+c. Default: Return.

       find-prev
           Search backwards in the scrollback history for the next match. Default: Control+r.

       find-next
           Searches forwards in the scrollback history for the next match. Default: Control+s.

       cursor-left
           Moves the cursor in the search box one character to the left. Default: Left Control+b.

       cursor-left-word
           Moves the cursor in the search box one word to the left. Default: Control+Left Mod1+b.

       cursor-right
           Moves the cursor in the search box one character to the right. Default: Right Control+f.

       cursor-right-word
           Moves the cursor in the search box one word to the right. Default: Control+Right Mod1+f.

       cursor-home
           Moves the cursor in the search box to the beginning of the input. Default: Home Control+a.

       cursor-end
           Moves the cursor in the search box to the end of the input. Default: End Control+e.

       delete-prev
           Deletes the character before the cursor. Default: BackSpace.

       delete-prev-word
           Deletes the word before the cursor. Default: Mod1+BackSpace Control+BackSpace.

       delete-next
           Deletes the character after the cursor. Default: Delete.

       delete-next-word
           Deletes the word after the cursor. Default: Mod1+d Control+Delete.

       extend-char
           Extend current selection to the right, by one character. Default: Shift+Right.

       extend-to-word-boundary
           Extend current selection to the right, to the next word boundary. Default: Control+w Control+Shift+Right.

       extend-to-next-whitespace
           Extend the current selection to the right, to the next whitespace. Default: Control+Shift+w.

       extend-line-down
           Extend current selection down one line. Default: Shift+Down.

       extend-backward-char
           Extend current selection to the left, by one character. Default: Shift+Left.

       extend-backward-to-word-boundary
           Extend current selection to the left, to the next word boundary. Default: Control+Shift+Left.

       extend-backward-to-next-whitespace
           Extend the current selection to the left, to the next whitespace. Default: none.

       extend-line-up
           Extend current selection up one line. Default: Shift+Up.

       clipboard-paste
           Paste from the clipboard into the search buffer. Default: Control+v Control+y.

       primary-paste
           Paste from the primary selection into the search buffer. Default: Shift+Insert.

       unicode-input
           Unicode input mode. See key-bindings.unicode-input for details. Default: none.

       scrollback-up-page
           Scrolls up/back one page in history. Default: Shift+Page_Up.

       scrollback-up-half-page
           Scrolls up/back half of a page in history. Default: none.

       scrollback-up-line
           Scrolls up/back a single line in history. Default: none.

       scrollback-down-page
           Scroll down/forward one page in history. Default: Shift+Page_Down.

       scrollback-down-half-page
           Scroll down/forward half of a page in history. Default: none.

       scrollback-down-line
           Scroll down/forward a single line in history. Default: none.

       scrollback-home
           Scroll to the beginning of the scrollback. Default: none.

       scrollback-end
           Scroll to the end (bottom) of the scrollback. Default: none.

SECTION: url-bindings
       This  section  lets  you override the default key bindings used in URL mode. The syntax is exactly the same as the regular key-
       bindings.

       Be careful; do not use single-letter keys that are also used in [url].label-letters, as doing so will make some URLs inaccessi‐
       ble.

       cancel
           Exits URL mode without opening a URL. Default: Control+g Control+c Control+d Escape.

       toggle-url-visible
           By default, the jump label only shows the key sequence required to activate it. This is fine as long as the URL is  visible
           in the original text.

           But with e.g. OSC-8 URLs (the terminal version of HTML anchors, i.e. "links"), the text on the screen can be something com‐
           pletely different than the URL.

           This action toggles between showing and hiding the URL on the jump label.

           Default: t.

SECTION: text-bindings
       This section lets you remap key combinations to custom escape sequences.

       The  format  is  text=combo1...comboN. That is, the string to emit may have one or more key combinations, space separated. Each
       combination is in the form mod1+mod2+key. The names of the modifiers and the key must be valid XKB key names.

       The text string specifies the characters, or bytes, to emit when the associated key combination(s) are pressed. There  are  two
       ways to specify a character:

       •   Normal, printable characters are written as-is: abcdef.
       •   Bytes (e.g. ESC) are written as two-digit hexadecimal numbers, with a \x prefix: \x1b.

       Example: you would like to remap Super+k to the Up key.

       The  escape sequence for the Up key is ESC [ A (without the spaces). Thus, we need to specify this in foot.ini (Mod4 is the XKB
       name for the Super/logo key):

       \x1b[A = Mod4+k

       Another example: to remap Super+c to Control+c:

       \x03 = Mod4+c

SECTION: mouse-bindings
       This section lets you override the default mouse bindings.

       The general format is action=combo1...comboN. That is, each action may have one or more key combinations, space separated. Each
       combination is in the form mod1+mod2+BTN_<name>[-COUNT]. The names of the modifiers must be valid XKB key names, and the button
       name must be a valid libinput name. You can find the button names using libinput debug-events.

       The trailing COUNT (number of times the button has to be clicked) is optional and specifies the click count required to trigger
       the binding. The default if COUNT is omitted is 1.

       To map wheel events (i.e. scrolling), use the button names BTN_WHEEL_BACK (up) and BTN_WHEEL_FORWARD (down).  Note  that  these
       events never generate a COUNT larger than 1. That is, BTN_WHEEL_BACK+2, for example, will never trigger.

       Foot also recognizes tiltable wheels; to map these, use BTN_WHEEL_LEFT and BTN_WHEEL_RIGHT.

       A  modifier+button  combination  can  only  be  mapped to one action. Lets say you want to bind BTN_MIDDLE to fullscreen. Since
       BTN_MIDDLE is the default binding for primary-paste, you first need to unmap the default binding. This can be done  by  setting
       action=none; e.g. primary-paste=none.

       selection-override-modifiers
           The  modifiers set in this set (which may be set to any combination of modifiers, e.g. mod1+mod2+mod3, as well as none) are
           used to enable selecting text with the mouse irrespective of whether a client application currently has the mouse  grabbed.
           These  modifiers cannot be used as modifiers in mouse bindings. Because the order of bindings is significant, it is best to
           set this prior to any other mouse bindings that might use modifiers in the default set. Default: Shift

       The actions to which mouse combos can be bound are listed below. All actions listed under key-bindings  can  be  used  here  as
       well.

       scrollback-up-mouse
           Normal screen: scrolls up the contents.

           Alt screen: send fake KeyUP events to the client application, if alternate scroll mode is enabled.

           Default: BTN_WHEEL_BACK

       scrollback-down-mouse
           Normal screen: scrolls down the contents.

           Alt screen: send fake KeyDOWN events to the client application, if alternate scroll mode is enabled.

           Default: BTN_WHEEL_FORWARD

       select-begin
           Begin  an  interactive  selection.  The selection is finalized, and copied to the primary selection, when the button is re‐
           leased. Default: BTN_LEFT.

       select-begin-block
           Begin an interactive block selection. The selection is finalized, and copied to the primary selection, when the  button  is
           released. Default: Control+BTN_LEFT.

       select-word
           Begin  an  interactive word-wise selection, where words are separated by whitespace and all characters defined by the word-
           delimiters option. The selection is finalized, and copied to the primary selection, when the button is  released.  Default:
           BTN_LEFT-2.

       select-word-whitespace
           Same  as  select-word,  but the characters in the word-delimiters option are ignored. I.e only whitespace characters act as
           delimiters. The selection is finalized, and copied to the primary selection, when the button  is  released.  Default:  Con‐
           trol+BTN_LEFT-2.

       select-quote
           Begin an interactive "quote" selection. This is similar to select-word, except an entire quote is selected (that is, every‐
           thing inside the quote, excluding the quote characters). Recognized quote characters are: " and '.

           If  a  complete  quote cannot be found on the current logical row (only one quote character, or none are found), the entire
           row is selected.

           The selection is finalized, and copied to the primary selection, when the button is released.

           After the initial selection has been made, it behaves like a normal word, or row selection, depending on  whether  a  quote
           was found or not. This affects what happens when, for example, extending the selection.

           Notes:
           •   Escaped quote characters are not supported ("foo \"bar" will match 'foo \', not 'foo "bar').
           •   Foot does not try to handle mismatched quote characters; they will simply not match.
           •   Nested quotes (using different quote characters) are supported.

           Default: BTN_LEFT-3.

       select-row
           Begin  an  interactive row-wise selection. The selection is finalized, and copied to the primary selection, when the button
           is released. Default: BTN_LEFT-4.

       select-extend
           Interactively extend an existing selection, using the original selection mode (normal, block, word-wise or  row-wise).  The
           selection is finalized, and copied to the primary selection, when the button is released. Default: BTN_RIGHT.

       select-extend-character-wise
           Same  as select-extend, but forces the selection mode to normal (i.e. character wise). Note that this causes subsequent se‐
           lect-extend operations to be character wise. This action is ignored for block selections. Default: Control+BTN_RIGHT.

       primary-paste
           Pastes from the primary selection. Default: BTN_MIDDLE.

       font-increase
           Increases the font size by 0.5pt. Default: Control+BTN_WHEEL_BACK (also defined in key-bindings).

       font-decrease
           Decreases the font size by 0.5pt. Default: Control+BTN_WHEEL_FORWARD (also defined in key-bindings).

TWEAK
       This section is for advanced users and describes configuration options that can be used to tweak foot's low-level behavior.

       These options are not included in the example configuration. You should not change these unless you understand what they do.

       Note that these options may change, or be removed at any time, without prior notice.

       When reporting bugs, please mention if, and to what, you have changed any of these options.

       scaling-filter
           Overrides the default scaling filter used when down-scaling bitmap fonts (e.g. emoji  fonts).  Possible  values  are  none,
           nearest,  bilinear, cubic or lanczos3. cubic and lanczos3 produce the best results, but are slower (with lanczos3 being the
           best and slowest).

           Default: lanczos3.

       overflowing-glyphs
           Boolean. When enabled, glyphs wider than their cell(s) are allowed to render into one additional neighbouring cell.

           One use case for this are fonts with wide italic characters that "bend" into the  next  cell.  Without  this  option,  such
           glyphs will appear "cut off".

           Another  use  case  are fonts with "icon" characters in the Unicode private usage area, e.g. Nerd Fonts, or Powerline Fonts
           and legacy emoji characters like WHITE FROWNING FACE.

           Note: might impact performance depending on the font used. Especially small font sizes can cause  many  overflowing  glyphs
           because of subpixel rendering.

           Default: yes.

       render-timer
           Enables  a frame rendering timer, that prints the time it takes to render each frame, in microseconds, either on-screen, to
           stderr, or both. Valid values are none, osd, log and both. Default: none.

       box-drawing-base-thickness
           Line thickness to use for LIGHT box drawing line characters, in points. This value is converted to pixels using  the  moni‐
           tor's  DPI,  and then multiplied with the cell size. The end result is that a larger font (and thus larger cells) result in
           thicker lines. Default: 0.04.

       box-drawing-solid-shades
           Boolean. When enabled, box drawing "shades" (e.g. LIGHT SHADE, MEDIUM SHADE and DARK SHADE) are rendered  as  solid  blocks
           using a darker variant of the current foreground color.

           When disabled, they are instead rendered as checker box pattern, using the current foreground color as is.

           Default: yes.

       delayed-render-lower, delayed-render-upper
           These  two  values control the timeouts (in nanoseconds) that are used to mitigate screen flicker caused by clients writing
           large, non-atomic screen updates.

           If a client splits up a screen update over multiple write(3) calls, we may end up rendering an intermediate frame,  quickly
           followed  by  another frame with the final screen content. For example, the client may erase part of the screen (or scroll)
           in one write, and then write new content in one or more subsequent writes. Rendering the frame when  the  screen  has  been
           erased, but not yet filled with new content will be perceived as screen flicker.

           The  real  solution  to  this  is  Application  Synchronized Updates (https://gitlab.freedesktop.org/terminal-wg/specifica‐
           tions/-/merge_requests/2).

           The problem with this is twofold - first, it has not yet been standardized, and thus there are not many terminal  emulators
           that implement it (foot does implement it), and second, applications must be patched to use it.

           Until  this  has  happened,  foot offers an interim workaround; an attempt to mitigate the screen flicker without affecting
           neither performance nor latency.

           It is based on the fact that the screen is updated at a fixed interval (typically 60Hz). For us, this  means  it  does  not
           matter if we render a new frame at the beginning of a frame interval, or at the end. Thus, the goal is to introduce a delay
           between receiving client data and rendering the resulting state, but without causing a frame skip.

           While  it  should  be  possible to estimate the amount of time left until the next frame, foot's algorithm is currently not
           that advanced, but is based on statistics I guess you could say - the delay we introduce is so small that the risk of push‐
           ing the frame over to the next frame interval is also very small.

           Now, that was a lot of text. But what is it foot actually does?

           When receiving client data, it schedules a timer, the delayed-render-lower. If we do not receive any more client  data  be‐
           fore  the  timer has run out, we render the frame. If however, we do receive more data, the timer is re-scheduled. That is,
           each time we receive client data, frame rendering is delayed another delayed-render-lower nanoseconds.

           Now, while this works very well with most clients, it would be possible to construct a malicious client that keeps  writing
           data  at  a  slow pace. To the user, this would look like foot has frozen as we never get to render a new frame. To prevent
           this, an upper limit is set - delayed-render-upper. If this timer runs out, we render the  frame  regardless  of  what  the
           client is doing.

           If  changing these values, note that the lower timeout must be set lower than the upper timeout, but that this is not veri‐
           fied by foot. Furthermore, both values must be less than 16ms (that is, 16000000 nanoseconds).

           You can disable the feature altogether by setting either value to 0. In this case, frames are rendered "as soon  as  possi‐
           ble".

           Default: lower=500000 (0.5ms), upper=8333333 (8.3ms - half a frame interval).

       damage-whole-window
           Boolean. When enabled, foot will 'damage' the entire window each time a frame has been rendered. This forces the compositor
           to redraw the entire window. If disabled, foot will only 'damage' updated rows.

           There  is  normally  no  reason to enable this. However, it has been seen to workaround an issue with fractional scaling in
           Gnome.

           Note that enabling this option is likely to increase CPU and/or GPU usage (by the compositor, not by foot), and may have  a
           negative impact on battery life.

           Default: no.

       grapheme-shaping
           Boolean.  When enabled, foot will use utf8proc to do grapheme cluster segmentation while parsing "printed" text. Then, when
           rendering, it will use fcft (if compiled with HarfBuzz support) to shape the grapheme clusters.

           This is required to render e.g. flag (emoji) sequences, keycap sequences, modifier sequences, zero-width-joiner  (ZWJ)  se‐
           quences and emoji tag sequences. It might also improve rendering of composed characters, depending on font.

               •   foot must have been compiled with utf8proc support
               •   fcft must have been compiled with HarfBuzz support

           This option can also be set runtime with DECSET/DECRST 2027.

           See also: grapheme-width-method.

           Default: yes

       grapheme-width-method
           Selects  which  method  to  use when calculating the width (i.e. number of columns) of a grapheme cluster. One of wcswidth,
           double-width and max.

           wcswidth simply adds together the individual width of all codepoints making up the cluster.

           double-width does the same, but limits the maximum number of columns to 2. This is more correct, but may break some  appli‐
           cations  since applications typically use wcswidth(3) internally to calculate the width. This results in cursor de-synchro‐
           nization issues.

           max uses the width of the largest codepoint in the cluster.

           Default: double-width

       font-monospace-warn
           Boolean. When enabled, foot will use heuristics to try to verify the primary font is a monospace font, and warn  if  it  is
           not.

           Disable this if you still want to use the font, even if foot thinks it is not monospaced.

           You may also want to disable it to get slightly faster startup times.

           Default: yes

       max-shm-pool-size-mb
           This  option controls the amount of virtual address space used by the pixmap memory to which the terminal screen content is
           rendered.

           It does not change how much physical memory foot uses.

           Foot uses a memory mapping trick to implement fast rendering of interactive scrolling (typically,  but  applies  to  "slow"
           scrolling in general). Example: holding down the 'up' or 'down' arrow key to scroll in a text editor.

           For this to work, it needs a large amount of virtual address space. Again, note that this is not physical memory.

           On  a  normal x64 based computer, each process has 128TB of virtual address space, and newer ones have 64PB. This is an in‐
           sane amount and most applications do not use anywhere near that amount.

           Each foot terminal window can allocate up to 2GB of virtual address space. With 128TB of address space, that means a  maxi‐
           mum of 65536 windows in server/daemon mode (for 2GB). That should be enough, yes?

           However,  the  Wayland  compositor also needs to allocate the same amount of virtual address space. Thus, it has a slightly
           higher chance of running out of address space since it needs to host all running Wayland clients in the same  way,  at  the
           same time.

           In the off chance that this becomes a problem for you, you can reduce the amount used with this option.

           Or,  for optimal performance, you can increase it to the maximum allowed value, 2GB (but note that you most likely will not
           notice any difference compared to the default value).

           Setting it to 0 disables the feature.

           Limitations:
               •   only supported on 64-bit architectures
               •   only supported on Linux

           Default: 512. Maximum allowed: 2048 (2GB).

       sixel
           Boolean. When enabled, foot will process sixel images. Default: yes

       bold-text-in-bright-amount
           Amount by which bold fonts are brightened when bold-text-in-bright is set to yes (the palette-based variant is not affected
           by this option). Default: 1.3.

SEE ALSO
       foot(1), footclient(1)

                                                              2024-11-23                                                   foot.ini(5)

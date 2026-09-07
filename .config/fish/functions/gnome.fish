function gnome --wraps='XDG_SESSION_TYPE=wayland dbus-run-session gnome-session' --description 'alias gnome=XDG_SESSION_TYPE=wayland dbus-run-session gnome-session'
    XDG_SESSION_TYPE=wayland dbus-run-session gnome-session $argv
end

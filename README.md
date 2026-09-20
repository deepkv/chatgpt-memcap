# chatgpt-memcap

Kills the ChatGPT macOS desktop app when its memory goes over a limit (default 1 GB).

Every 60 seconds it adds up the memory footprint of every process under
`/Applications/ChatGPT*.app` — the number Activity Monitor shows, which includes
compressed memory — and kills them all if the total is over the limit. It does not
relaunch the app.

## Install

    ./install.sh

Copies the script to `~/.local/bin` and registers a launchd agent that starts it at
login and restarts it if it dies. Kills are logged to `~/Library/Logs/chatgpt-memcap.log`.

To change the limit or interval, add arguments to `ProgramArguments` in
`~/Library/LaunchAgents/local.chatgpt-memcap.plist`: `chatgpt-memcap [limit_mb] [interval_s]`.

## Uninstall

    launchctl bootout gui/$(id -u)/local.chatgpt-memcap
    rm ~/Library/LaunchAgents/local.chatgpt-memcap.plist ~/.local/bin/chatgpt-memcap

## License

MIT

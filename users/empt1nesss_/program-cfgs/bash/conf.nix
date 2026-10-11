{ inputs, config, pkgs, ... }:

{
  programs.bash = {
    enableCompletion = true;
    profileExtra = ''
      if [ -t 0 ] && [ -z "$NIRI_SESSION_STARTED" ] && [ "$(tty)" = "/dev/tty1" ]; then
        export NIRI_SESSION_STARTED=1
        exec niri-session
      fi
    '';
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';
    shellAliases = {
      ls = "ls --color=auto -A";
    };
    initExtra = ''
      export OSH="${inputs.oh-my-bash}"
      DISABLE_AUTO_UPDATE="true"
      OSH_THEME="nekolight"
      source "$OSH/oh-my-bash.sh"
    '';
  };
}


{ pkgs, remoteSshfs, ... }:

{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      pname = "remote-sshfs.nvim";
      version = "unstable";
      src = remoteSshfs;
      doCheck = false;
    })

    pkgs.vimPlugins.plenary-nvim
  ];

  extraPackages = with pkgs; [
    sshfs-fuse
    fuse3
    openssh
  ];

  # Required picker backend.
  # Merges with existing Snacks configuration.
  plugins.snacks = {
    enable = true;
    settings.picker.enabled = true;
  };

  extraConfigLua = ''
    require("remote-sshfs").setup({
      connections = {
        ssh_configs = {
          vim.fn.expand("~/.ssh/config"),
        },
        ssh_known_hosts = vim.fn.expand("~/.ssh/known_hosts"),
        sshfs_args = {
          "-o reconnect",
          "-o ConnectTimeout=5",
          "-o ServerAliveInterval=15",
          "-o dir_cache=yes",
          "-o dcache_timeout=10",
        },
      },

      mounts = {
        base_dir = vim.fn.expand("~/.sshfs/"),
        unmount_on_exit = true,
      },

      handlers = {
        on_connect = {
          change_dir = true,
        },
        on_disconnect = {
          clean_mount_folders = false,
        },
      },

      ui = {
        picker = "snacks",
        confirm = {
          connect = true,
          change_dir = false,
        },
      },
    })

    local api = require("remote-sshfs.api")
    local connections = require("remote-sshfs.connections")

    local function remote_only(fn)
      return function()
        if not connections.is_connected() then
          vim.notify(
            "Сначала подключись через <leader>rc",
            vim.log.levels.WARN
          )
          return
        end

        fn()
      end
    end

    vim.keymap.set("n", "<leader>rc", function()
      if not vim.bo.modifiable then
        vim.cmd("enew")
      end

      api.connect()
    end, {
      desc = "Remote: connect",
    })

    vim.keymap.set("n", "<leader>rd", api.disconnect, {
      desc = "Remote: disconnect",
    })

    vim.keymap.set("n", "<leader>re", api.edit, {
      desc = "Remote: edit SSH config",
    })

    vim.keymap.set("n", "<leader>rf", remote_only(function()
      vim.cmd("RemoteSSHFSFindFiles")
    end), {
      desc = "Remote: find files",
    })

    vim.keymap.set("n", "<leader>rg", remote_only(function()
      vim.cmd("RemoteSSHFSLiveGrep")
    end), {
      desc = "Remote: live grep",
    })

    vim.keymap.set("n", "<leader>rr", remote_only(function()
      vim.cmd(
        "Neotree filesystem show left dir="
        .. vim.fn.fnameescape(vim.fn.getcwd())
      )
    end), {
      desc = "Remote: open Neo-tree",
    })
  '';
}


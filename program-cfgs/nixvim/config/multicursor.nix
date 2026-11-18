{
  extraConfigLua = ''
    do
      local api = vim.api
      local ns = api.nvim_create_namespace("nvim.multicursor")
      local state = nil

      local function update_counter()
        if state then
          vim.g.multicursor_count = string.format(
            "%d/%d",
            #state.positions,
            #state.matches
          )
        else
          vim.g.multicursor_count = nil
        end

        vim.cmd.redrawstatus()
      end

      local function clear()
        api.nvim_buf_clear_namespace(0, ns, 0, -1)
        state = nil
        update_counter()
      end

      local function key(row, col)
        return row .. ":" .. col
      end

      local function get_selection()
        if vim.fn.mode() ~= "v" then
          return nil
        end

        local a = vim.fn.getpos("v")
        local b = vim.fn.getpos(".")

        if a[2] ~= b[2] then
          return nil
        end

        local text = vim.fn.getregion(a, b, {
          type = "v",
        })[1]

        if not text or text == "" then
          return nil
        end

        return {
          row = a[2],
          col = math.min(a[3], b[3]) - 1,
          text = text,
        }
      end

      local function start()
        local selection = get_selection()

        if not selection then
          vim.notify(
            "Нужно однострочное Visual-выделение",
            vim.log.levels.WARN
          )
          return false
        end

        clear()

        local pattern =
          [[\V\C]] .. vim.fn.escape(selection.text, [[\]])

        vim.fn.setreg("/", pattern)

        local matches = vim.fn.matchbufline(
          "%",
          pattern,
          1,
          "$"
        )

        local first = key(selection.row, selection.col)

        state = {
          buf = api.nvim_get_current_buf(),
          tick = api.nvim_buf_get_changedtick(0),
          first = selection,
          last_row = selection.row,
          last_col = selection.col,
          matches = matches,
          selected = {
            [first] = true,
          },
          positions = {
            {
              row = selection.row,
              col = selection.col,
            },
          },
        }

        update_counter()

        return true
      end

      local function find_next()
        local function unused(m)
          return not state.selected[key(m.lnum, m.byteidx)]
        end

        -- Search after the last added occurrence.
        for _, m in ipairs(state.matches) do
          local after =
            m.lnum > state.last_row
            or (
              m.lnum == state.last_row
              and m.byteidx > state.last_col
            )

          if after and unused(m) then
            return m
          end
        end

        -- Wrap around.
        for _, m in ipairs(state.matches) do
          if unused(m) then
            return m
          end
        end

        return nil
      end

      local function rebuild_cursors()
        -- Recreate native cursors at the beginnings
        -- of all selected matches.
        api.nvim_buf_clear_namespace(0, ns, 0, -1)

        -- The first match is the primary cursor.
        local first = state.positions[1]

        api.nvim_win_set_cursor(0, {
          first.row,
          first.col,
        })

        -- All other matches become native multicursors.
        for i = 2, #state.positions do
          local pos = state.positions[i]

          api.nvim_buf_set_extmark(
            0,
            ns,
            pos.row - 1,
            pos.col,
            {}
          )
        end
      end

      local function add_next()
        if state and (
          state.buf ~= api.nvim_get_current_buf()
          or state.tick ~= api.nvim_buf_get_changedtick(0)
        ) then
          clear()
        end

        if not state and not start() then
          return false
        end

        local next_match = find_next()

        if not next_match then
          vim.notify(
            "Все совпадения уже выбраны",
            vim.log.levels.INFO
          )
          return false
        end

        local row = next_match.lnum
        local col = next_match.byteidx

        state.selected[key(row, col)] = true
        state.last_row = row
        state.last_col = col

        table.insert(state.positions, {
          row = row,
          col = col,
        })

        update_counter()

        rebuild_cursors()
        return true
      end

      -- Visual: add next match and reselect all matches.
      -- gn works at every native cursor.
      vim.keymap.set("x", "<C-d>", function()
        if add_next() then
          return "<Esc>gn"
        end
        return ""
      end, {
        expr = true,
        desc = "Multicursor: select next occurrence",
      })

      -- Normal: select the word, then use the Visual mapping.
      vim.keymap.set("n", "<C-d>", "viw", {
        desc = "Multicursor: select word",
      })

      -- Esc: clear all native cursors.
      vim.keymap.set({ "n", "x", "s" }, "<Esc>", function()
        clear()
        return "<Esc>"
      end, {
        expr = true,
        desc = "Multicursor: clear",
      })

      -- Keep the normal Insert-mode Esc behavior, including
      -- Neovim's multicursor insert replay.
      -- Clean up after leaving Insert mode.
      api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          if state then
            vim.schedule(clear)
          end
        end,
      })

      vim.keymap.set("n", "<leader>mc", clear, {
        desc = "Multicursor: clear",
      })
    end
  '';
}

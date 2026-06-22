-- custom textobjects
-- https://github.com/nvim-mini/mini.ai

vim.pack.add({
  {
    src = "https://github.com/nvim-mini/mini.ai",
    version = vim.version.range("*"),
  },
})

local function is_lower(char)
  return char ~= "" and char:match("%l") ~= nil
end

local function is_upper(char)
  return char ~= "" and char:match("%u") ~= nil
end

local function is_digit(char)
  return char ~= "" and char:match("%d") ~= nil
end

local function is_separator(char)
  return char == "_" or char == "-"
end

local function is_subword_char(char)
  return char ~= "" and char:match("[%w_-]") ~= nil
end

local function subword_region(line_nr, start_col, end_col)
  return { from = { line = line_nr, col = start_col }, to = { line = line_nr, col = end_col } }
end

local function split_subword_chunk(chunk, offset)
  local segments = {}
  local col = 1

  while col <= #chunk do
    local start_col = col
    local char = chunk:sub(col, col)
    local end_col = col

    if is_digit(char) then
      while end_col < #chunk and is_digit(chunk:sub(end_col + 1, end_col + 1)) do
        end_col = end_col + 1
      end
    elseif is_lower(char) then
      while end_col < #chunk do
        local next_char = chunk:sub(end_col + 1, end_col + 1)
        if not (is_lower(next_char) or is_digit(next_char)) then break end
        end_col = end_col + 1
      end
    elseif is_upper(char) then
      local next_char = chunk:sub(col + 1, col + 1)

      if is_lower(next_char) or is_digit(next_char) then
        while end_col < #chunk do
          next_char = chunk:sub(end_col + 1, end_col + 1)
          if not (is_lower(next_char) or is_digit(next_char)) then break end
          end_col = end_col + 1
        end
      else
        while end_col < #chunk do
          next_char = chunk:sub(end_col + 1, end_col + 1)
          if not (is_upper(next_char) or is_digit(next_char)) then break end
          end_col = end_col + 1
        end

        if end_col > col and is_lower(chunk:sub(end_col + 1, end_col + 1)) then
          end_col = end_col - 1
        end
      end
    end

    table.insert(segments, {
      start_col = offset + start_col - 1,
      end_col = offset + end_col - 1,
    })

    col = end_col + 1
  end

  return segments
end

local function subword_regions(ai_type)
  local line_nr = vim.api.nvim_win_get_cursor(0)[1]
  local cursor_col = vim.api.nvim_win_get_cursor(0)[2] + 1
  local line = vim.api.nvim_buf_get_lines(0, line_nr - 1, line_nr, false)[1] or ""
  local regions = {}
  local col = 1

  while col <= #line do
    if not is_subword_char(line:sub(col, col)) then
      col = col + 1
    else
      local run_start = col

      while col <= #line and is_subword_char(line:sub(col, col)) do
        col = col + 1
      end

      local run_end = col - 1
      local chunk_col = run_start

      while chunk_col <= run_end do
        if is_separator(line:sub(chunk_col, chunk_col)) then
          chunk_col = chunk_col + 1
        else
          local chunk_start = chunk_col

          while chunk_col <= run_end and not is_separator(line:sub(chunk_col, chunk_col)) do
            chunk_col = chunk_col + 1
          end

          local chunk_end = chunk_col - 1
          local chunk = line:sub(chunk_start, chunk_end)

          for _, segment in ipairs(split_subword_chunk(chunk, chunk_start)) do
            local start_col = segment.start_col
            local end_col = segment.end_col

            if ai_type == "a" then
              if is_separator(line:sub(end_col + 1, end_col + 1)) then
                end_col = end_col + 1
              elseif is_separator(line:sub(start_col - 1, start_col - 1)) then
                start_col = start_col - 1
              end
            end

            table.insert(regions, subword_region(line_nr, start_col, end_col))
          end
        end
      end
    end
  end

  if ai_type == "a" and is_separator(line:sub(cursor_col, cursor_col)) then
    table.sort(regions, function (left, right)
      local left_distance = math.abs(left.from.col - cursor_col)
      local right_distance = math.abs(right.from.col - cursor_col)

      if left_distance ~= right_distance then
        return left_distance < right_distance
      end

      return left.from.col < right.from.col
    end)
  end

  return regions
end

require("mini.ai").setup({
  custom_textobjects = {
    -- `iS`/`aS`: subword in camelCase, snake_case, and kebab-case.
    S = function (ai_type)
      local regions = subword_regions(ai_type)
      return #regions > 0 and regions or nil
    end,
  },
})

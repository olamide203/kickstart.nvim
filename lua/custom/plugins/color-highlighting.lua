local MiniHipatterns = require 'mini.hipatterns'
return {
  'echasnovski/mini.hipatterns',
  event = 'BufReadPre',
  opts = {
    highlighters = {
      hsl_color = {
        pattern = 'hsl%(%d*%.?%d+%s*,?%s*%d*%.?%d+%%?%s*,?%s*%d*%.?%d+%%?%)',
        group = function(_, match)
          local utils = require 'custom.utils.colors'
          ---@type string, string, string
          local nh, ns, nl = match:match 'hsl%((%d*%.?%d+),?%s*(%d*%.?%d+)%%?,?%s*(%d*%.?%d+)%%?%)'
          ---@type number?, number?, number?
          local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)

          -- Check the saturation and lightness values
          if s < 0 or s > 100 or l < 0 or l > 100 then
            -- Skip this value
            return nil
          end

          local hex_color = utils.hslToHex(h, s, l)
          return MiniHipatterns.compute_hex_color_group(hex_color, 'bg')
        end,
      },
      hsl_color_2 = {
        pattern = '%d*%.?%d+%s+,?%s*%d*%.?%d+%%%s+,?%s*%d*%.?%d+%%',
        group = function(_, match)
          local utils = require 'custom.utils.colors'
          ---@type string, string, string
          local nh, ns, nl = match:match '(%d*%.?%d+),?%s+(%d*%.?%d+)%%,?%s+(%d*%.?%d+)%%'
          ---@type number?, number?, number?
          local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)

          -- Check the saturation and lightness values
          if s < 0 or s > 100 or l < 0 or l > 100 then
            -- Skip this value
            return nil
          end

          local hex_color = utils.hslToHex(h, s, l)
          return MiniHipatterns.compute_hex_color_group(hex_color, 'bg')
        end,
      },
      -- Highlight hex color strings (`#rrggbb`) using that color
      hex_color = MiniHipatterns.gen_highlighter.hex_color(),
    },
  },
}

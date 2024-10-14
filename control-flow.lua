tbgen = {}
cont = {}

function gst(a)
  a = a or "A"
  b = a
  if type(tbgen[b]) ~= "table" then
    tbgen[b] = {}
  end
  a = a .. "_"
  a = a .. #tbgen[b]
  a = a .. "_"
  table.insert(tbgen[b], #tbgen[b])
  return a
end

    function spl(code)
    local lines = {}
    local temp_block = nil
    local in_block = false
    local block_counter = 0
    local is_repeat_block = false
    local block_keywords = {
        "function",
        "if",
        "while",
        "for"
    }
    
    local function is_block_start(line)
        for _, keyword in ipairs(block_keywords) do
            if line:match("^%s*" .. keyword .. "%s*") then
                return true
            end
        end
        return line:match("^%s*repeat%s*$")
    end

    -- Fungsi untuk memeriksa apakah sebuah baris berisi "end"
    local function is_block_end(line)
        if is_repeat_block then
            return line:match("^%s*until%s+")
        else
            return line:match("^%s*end%s*$")
        end
    end

    for line in code:gmatch("[^\r\n]+") do
        if is_block_start(line) then
            -- Mulai blok baru
            if not in_block then
                temp_block = {line}
                in_block = true
                if line:match("^%s*repeat%s*$") then
                    is_repeat_block = true
                else
                    block_counter = block_counter + 1
                end
            else
                -- Jika ada blok dalam blok
                table.insert(temp_block, line)
                block_counter = block_counter + 1
            end
        elseif in_block then
            -- Jika masih dalam blok, tambahkan baris
            table.insert(temp_block, line)
            if is_block_end(line) then
                if is_repeat_block then
                    -- Jika blok repeat selesai dengan until
                    table.insert(lines, table.concat(temp_block, "\n"))
                    temp_block = nil
                    in_block = false
                    is_repeat_block = false
                else
                    block_counter = block_counter - 1
                    if block_counter == 0 then
                        -- Akhir dari blok
                        table.insert(lines, table.concat(temp_block, "\n"))
                        temp_block = nil
                        in_block = false
                    end
                end
            end
        else
            -- Baris di luar blok
            table.insert(lines, line)
        end
    end

    return lines
end

function cfuk(code)
  local mr = math.random
  local sk1, sk2, sk3 = mr(100,1000), mr(100,1000), 5
  local mk1, mk2, mk3 = gst("M"), gst("O"), gst("B")
  local suki = {}
  local end_count = 0
  local src = ""
  local src2 = string.format("local %s, %s, %s = %d, %d, %d;", mk1,mk2,mk3,sk1,sk2,sk3)
  for _cdc, _cdm in pairs(code) do
    local suki1, suki2 = gst("W"), gst("F")
    if sk1 <= sk2 then
      table.insert(cont, suki1)
      local skk1 = string.format("%s = %s + %s * %s", mk1, mk1, mk2, mk3)
      local melicau1 = string.format("%s = false;%s", suki1, skk1)
      sk1 = sk1 + sk2 * sk3
      src = src .. string.format("%s=true;while %s <= %s and %s == true do;%s;%s;", suki1, mk1, mk2, suki1, melicau1, _cdm)
      end_count = end_count + 1
    elseif sk1 > sk2 then
       table.insert(cont, suki2)
       local skk1 = string.format("%s = %s - %s * %s", mk1, mk1, mk2, mk3)
       local melicau2 = string.format("%s = false;%s", suki2, skk1)
      sk1 = sk1 - sk2 * sk3
      src = src .. string.format("%s=true;while %s > %s and %s == true do;%s;%s;",suki2, mk1, mk2, suki2, melicau2, _cdm)
      end_count = end_count + 1
    end
  end
   for ih = 1, end_count do
     src = (ih == 0 and src .. "end;" or src .. "end;")
    end
    for ah,ab in pairs(cont) do
     src2 = src2 .. ab .. "=true;"
    end
  src = src2 .. "\ndo " .. src .. "end;"
  return src
 end

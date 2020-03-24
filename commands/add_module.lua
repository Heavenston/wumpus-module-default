local added_modules = ""
local added_modules_n = 0
local could_not_add = ""
local could_not_add_n = 0
for i, module_src in pairs(arguments) do
  local module = discord.get_module(module_src)
  if module == nil then

    could_not_add = could_not_add..", "..module_src
    could_not_add_n = could_not_add_n+1

  else
    
    discord.add_guild_module(message.guild_id, module_src)
    added_modules = added_modules..", "..module.name
    added_modules_n = added_modules_n+1

  end
end
added_modules = added_modules:sub(3, -1)
could_not_add = could_not_add:sub(3, -1)

response.text = ""
if #added_modules > 0 then
  response.text = string.format("Module%s `%s` added !\n", added_modules_n > 1 and "s" or "", added_modules)
end

if #could_not_add > 0 then
  response.text = response.text..string.format("Could not add module%s `%s`\n", could_not_add_n > 1 and "s" or "", could_not_add)
end

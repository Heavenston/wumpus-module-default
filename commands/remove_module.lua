local removed_modules = ""
for i, module in pairs(arguments) do
  discord.remove_guild_module(message.guild_id, module)
  removed_modules = removed_modules..", "..module
end
removed_modules = removed_modules:sub(3, -1)

response.text = string.format("Module%s `%s` removed !", arguments[2] and "s" or "", removed_modules)
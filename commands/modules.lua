local modules = discord.get_guild_modules(message.guild_id)

if (#modules == 0) then
  response.text = "You have no modules installed"
else
  response.text = string.format("You have `%s` module%s installed :", #modules, #modules > 1 and "s" or "")

  local modules_text = ""
  for i, module in pairs(modules) do
    modules_text = modules_text..discord.get_module(module).name.." "
  end
  modules_text = modules_text:sub(1, -2)

  response.text = response.text..string.format("\n`%s`", modules_text)
end
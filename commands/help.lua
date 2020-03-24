local modules = discord.get_guild_modules(message.guild_id)
local prefix = discord.get_guild_prefix(message.guild_id)

if (#modules == 0) then
  response.text = "You have no modules installed\n"
  response.text = response.text..string.format("You can install module with `%sadd_module`", prefix)
else
  if arguments[1] then
    local module = discord.get_module(arguments[1])
    if not module then
      for i, v in pairs(modules) do
        module = discord.get_module(v)
        if module and module.name:lower() == arguments[1]:lower() then break else module = nil end
      end
      if not module then
        response.text = string.format(
          "Could not find module `%s`\nYou can use `%smodules` to know wich modules are installed\nOr use this command with directly the module path if the module isn't installed on your server (ex: `heavenston/wumpus-default-module`)"
          , arguments[1], prefix)
        return
      end
    end
    response.text = string.format("Could not find module `%s`", arguments[1])
    local commands = ""
    for i, command in pairs(module.commands) do
      commands = commands..string.format("`%s%s %s`\n", prefix, command.name, command.args)
      if command.help then
        commands = commands..command.help.."\n"
      end
    end
    response.text = string.format("```markdown\nHelp for\n# %s```\n%s", module.name, commands)
  else
    response.text = string.format("You have `%s` module%s installed\n\n", #modules, #modules > 1 and "s" or "")

    table.sort(modules, function(a, b) return (a.name or 0) > (b.name or 1) end)

    for i, module_src in pairs(modules) do
      local module = discord.get_module(module_src)

      local commands = ""
      for i, command in pairs(module.commands) do
        commands = commands..string.format("`%s%s %s`\n", prefix, command.name, command.args)
        if command.help then
          commands = commands..command.help.."\n"
        end
      end
      response.text = response.text..string.format("```markdown\n# %s```\n%s\n", module.name, commands)
    end
  end
end

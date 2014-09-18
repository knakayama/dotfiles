# Alias
Pry.config.commands.alias_command 'w', 'whereami'

# https://github.com/pry/pry/wiki/FAQ#awesome_print
begin
  require 'awesome_print'
  Pry.config.print = proc { |output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output) }
rescue LoadError => err
  puts "no awesome_print :("
end


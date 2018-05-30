Pry.config.theme='wombat'

if defined?(PryDebugger)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

if defined?(BigDecimal)
  BigDecimal.class_eval do
    def inspect
      "BigDecimal(#{to_s})"
    end
  end
end

if defined?(Rails) && Rails.env
  extend Rails::ConsoleMethods
end

Pry::Commands.block_command "mikey", "find mike" do
  target.eval("mike = Spree::User.find_by(email: 'mike@stembolt.com')")
end

Pry::Commands.block_command "ordo", "find order" do |id, order_name|
  target.eval("#{order_name} = Spree::Order.find #{id}")
end

Pry::Commands.block_command "varo", "find var" do |id, variant_name|
  target.eval("#{variant_name} = Spree::Variant.find #{id}")
end

Pry::Commands.block_command "set-count", "adjust stock of an item" do |variant, amount|
  target.eval("#{variant}.primary_stock_item.set_count_on_hand(#{amount})")
end

require "rspec/core/formatters/base_text_formatter"

class RspecTickFormatter < RSpec::Core::Formatters::BaseTextFormatter
  def initialize(output)
    super(output)

    @level = 0
  end

  RSpec::Core::Formatters.register self, :example_group_started, :example_passed, :example_pending,
                                   :example_failed, :example_group_finished

  def example_passed(proxy)
    puts color("#{pad} \u2713 #{proxy.example.description}", :green)
  end

  def example_pending(proxy)
    puts color("#{pad} \u2729 #{proxy.example.description}", :yellow)
  end

  def example_failed(proxy)
    puts color("#{pad} \u2717 #{proxy.example.description}: #{proxy.example.exception}", :red)
  end

  def example_group_started(example_group)
    puts "#{pad} #{example_group.group.description.strip}:"
    @level += 1
  end

  def example_group_finished(example_group)
    @level -= 1
  end

  def pad
    ' ' * @level * 2
  end

  def color(text, code_or_symbol)
    if RSpec.configuration.color_enabled?
      "\e[#{console_code_for(code_or_symbol)}m#{text}\e[0m"
    else
      text
    end
  end

  # Shamelessly "Borrowed" from the excellent nyan cat formatter
  # Source: https://github.com/mattsears/nyan-cat-formatter/blob/master/lib/nyan_cat_formatter/common.rb
  VT100_CODES =
      {
          :black   => 30,
          :red     => 31,
          :green   => 32,
          :yellow  => 33,
          :blue    => 34,
          :magenta => 35,
          :cyan    => 36,
          :white   => 37,
          :bold    => 1,
      }
  VT100_CODE_VALUES = VT100_CODES.invert

  def console_code_for(code_or_symbol)
    if VT100_CODE_VALUES.has_key?(code_or_symbol)
      code_or_symbol
    else
      VT100_CODES.fetch(code_or_symbol) do
        console_code_for(:white)
      end
    end
  end
end

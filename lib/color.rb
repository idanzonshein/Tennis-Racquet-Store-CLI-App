module Color
  def puts_green(string)
    puts string.colorize(:green).bold
  end

  def puts_red(string)
    puts string.colorize(:red).bold
  end
end

class Condition
  def initialize(options)
    @if = options[:if]
    @unless = options[:unless]
    raise ArgumentError, "Don't use if and unless at the same time." if @if && @unless
  end

  def call(record)
    return @if.call(record) if @if
    return !@unless&.call(record) if @unless

    true
  end
end

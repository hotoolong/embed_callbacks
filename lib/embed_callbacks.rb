require "embed_callbacks/version"

module EmbedCallbacks
  def self.included(base)
    base.extend(PrependMethods)
  end

  module PrependMethods
    def set_callback(target_method_name, behavior_sym, callback_function_name, **options)
      behavior = Behavior.new(behavior_sym)
      m = Module.new
      m.define_method(target_method_name) do |*params|
        condition = Condition.new(options).call(self)
        begin
          method(callback_function_name).call if condition && behavior.before?
          return_value = super(*params)
          method(callback_function_name).call if condition && behavior.after?
          return_value
        rescue => e
          method(callback_function_name).call if condition && behavior.rescue?
          raise e
        ensure
          method(callback_function_name).call if condition && behavior.ensure?
        end
      end
      prepend m
    end
  end

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

  class Behavior
    KINDS = %i(before after around rescue ensure)

    def initialize(behavior)
      @behavior = behavior
      raise ArgumentError, 'The behavior should be set in the ' + KINDS.join(' ') unless KINDS.include?(behavior)
    end

    def before?
      %i(before around).include?(@behavior)
    end

    def after?
      %i(after around).include?(@behavior)
    end

    def rescue?
      :rescue == @behavior
    end

    def ensure?
      :ensure == @behavior
    end
  end
end

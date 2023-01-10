require "embed_callbacks/version"
require "embed_callbacks/condition"
require "embed_callbacks/behavior"

module EmbedCallbacks
  def self.included(base)
    base.extend(PrependMethods)
  end

  module PrependMethods
    def embed_callback(target_method_name, behavior_sym, callback_function_name, **options)
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
end

require "embed_callbacks/version"

module EmbedCallbacks
  def self.included(base)
    base.extend(PrependMethods)
  end

  module PrependMethods
    def set_callback(target_method_name, behavior, callback_function_name)
      raise ArgumentError, 'The behavior should be set in the before after around rescue' unless %i(before after around rescue ensure).include?(behavior)
      m = Module.new
      m.define_method(target_method_name) do |*params|
        begin
          method(callback_function_name).call if %i(before around).include?(behavior)
          return_value = super(*params)
          method(callback_function_name).call if %i(after around).include?(behavior)
          return_value
        rescue => e
          method(callback_function_name).call if behavior == :rescue
          raise e
        ensure
          method(callback_function_name).call if behavior == :ensure
        end
      end
      prepend m
    end
  end
end

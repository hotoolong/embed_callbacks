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

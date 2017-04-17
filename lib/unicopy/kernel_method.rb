require_relative '../unicopy'

module Kernel
  private

  def unicopy(string, **kwargs)
    Unicopy.unicopy(string, **kwargs)
  end
end

module Carts
  class RemoveCartService
    class << self
      def call(orderable)
        orderable.destroy
      end
    end
  end
end

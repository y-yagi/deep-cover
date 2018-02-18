# frozen_string_literal: true

module DeepCover
  module CLI
  end

  module CLI::Helpers
    class AddDefaultToOptionsDescription < Struct.new(:delegate)
      def method_missing(method, *args, &block) # rubocop:disable Style/MethodMissing
        options = args.last
        if options.is_a?(Hash) && options.has_key?(:default)
          args[-2] += " [#{options[:default]}]"
        end
        delegate.public_send(method, *args, &block)
      end
    end
  end
end

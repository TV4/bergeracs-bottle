module Entasis
  module Base
    extend ActiveSupport::Concern

    included do
      include ActiveModel::Validations
    end

    module ClassMethods
      # Takes a list of symbolized attribute names and defines them
      def attributes(*attrs)
        self.const_set("ATTRIBUTE_NAMES", attrs.map(&:to_s))
        attr_accessor(*attrs)
      end
    end

    # Takes a hash and assigns keys and values to it's attributes members
    def initialize(*args)
      update_attributes(args.shift) if args.first.is_a?(Hash)
    end

    def attribute_names
      self.class::ATTRIBUTE_NAMES
    end

    # Returns an attributes hash
    def attributes
      attrs = ::ActiveSupport::OrderedHash.new
      attribute_names.each { |name| attrs[name] = send(name) }
      attrs
    end

    # Takes each key and value from the hash and assigns it to it's attribute.
    def update_attributes(hash)
      hash.each_pair do |attribute_name, value|
        if self.respond_to?("#{attribute_name}=")
          self.send("#{attribute_name}=", value)
        end
      end
    end
  end
end

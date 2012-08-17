module Bergeracs
  module Bottle
    module AttributeSetter
      module ClassMethods
        def attribute_setters(kind, *args)
          attribute_names = [args.first].flatten

          case kind
          when :boolean  then define_boolean_setters(attribute_names)
          when :fixnum   then define_fixnum_setters(attribute_names)
          when :float    then define_float_setters(attribute_names)        
          when :datetime then define_datetime_setters(attribute_names)
          when :iso_datetime then define_iso_datetime_setters(attribute_names)
          end
        end

        def define_boolean_setters(attribute_names)
          attribute_names.each do |attribute_name|
            define_method "#{attribute_name}=" do |value|
              value = (["true", true].include?(value) ? true : false) unless value.nil?
              instance_variable_set("@#{attribute_name}", value)
            end
          end
        end

        def define_fixnum_setters(attribute_names)
          attribute_names.each do |attribute_name|
            define_method "#{attribute_name}=" do |value|
              value = if value =~ /\A\d+/ && value !~ /\D/ or value.is_a?(Fixnum) then value.to_i else nil end
              instance_variable_set("@#{attribute_name}", value)
            end
          end
        end

        def define_float_setters(attribute_names)
          attribute_names.each do |attribute_name|
            define_method "#{attribute_name}=" do |value|
              value = if value =~ /\A[0-9]*\.?[0-9]*$/ or value.is_a?(Float) then value.to_f else nil end
              instance_variable_set("@#{attribute_name}", value)
            end
          end
        end

        def define_datetime_setters(attribute_names)
          attribute_names.each do |attribute_name|
            define_method "#{attribute_name}=" do |value|
              value = Time.zone.parse(value) if value.is_a?(String)
              instance_variable_set("@#{attribute_name}", value)
            end
          end
        end

        def define_iso_datetime_setters(attribute_names)
          attribute_names.each do |attribute_name|
            define_method "#{attribute_name}=" do |value|
              value = DateTime.parse(value).to_s[0..18] if value.is_a?(String)
              instance_variable_set("@#{attribute_name}", value)
            end
          end
        end
      end

      def self.included(receiver)
        receiver.extend(ClassMethods)
      end
    end
  end
end

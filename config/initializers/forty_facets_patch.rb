module FortyFacets

  #this initializer is required to allow the date range functionality in forty facets
  #to be added to the path in any order
  class RangeFilterDefinition < FilterDefinition
    class RangeFilter < Filter
      def min_value
        return nil if empty?
        value[0].split(' - ').first
      end

      def max_value
        return nil if empty?
        value[0].split(' - ').last
      end

      def remove(value)
        new_params = search_instance.params || {}
        unless new_params.empty?
          new_params.delete(definition.request_param)
          search_instance.class.new_unwrapped(new_params, search_instance.root)
        end
      end

      def add(value)
        new_params = search_instance.params || {}
        old_values = new_params[definition.request_param] ||= []
        old_values.delete(value.to_s)
        old_values << value.to_s
        search_instance.class.new_unwrapped(new_params, search_instance.root)
      end
    end
  end

  #this initializer is required to allow the title search functionality in forty facets
  #to be added to the path in any order

  class TextFilterDefinition < FilterDefinition
    class TextFilter < Filter
      def remove(value)
        new_params = search_instance.params || {}
        unless new_params.empty?
          new_params.delete(definition.request_param)
          search_instance.class.new_unwrapped(new_params, search_instance.root)
        end
      end

      def add(value)
        new_params = search_instance.params || {}
        old_values = new_params[definition.request_param] ||= []
        old_values.delete(value.to_s)
        old_values << value.to_s
        search_instance.class.new_unwrapped(new_params, search_instance.root)
      end

      def expression_value(term)
        if term.is_a?(Array)
          term = term[0]
        end
        if definition.options[:prefix]
         "#{term}%"
        else
         "%#{term}%"
        end
      end
    end
  end

end

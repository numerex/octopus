module Octopus
  module Rails3
    module Persistence
      def update_attribute(*args)
        possibly_wrap_connection do
          reload_connection()
          super
        end
      end

      def update_attributes(*args)
        possibly_wrap_connection do
          reload_connection()
          super
        end
      end

      def update_attributes!(*args)
        possibly_wrap_connection do
          reload_connection()
          super
        end
      end

      def reload(*args)
        possibly_wrap_connection do
          reload_connection()
          super
        end
      end

      def delete
        possibly_wrap_connection do
          reload_connection()
          super
        end
      end

      def destroy
        possibly_wrap_connection do
          reload_connection()
          super
        end
      end
      
      def save(*)
        possibly_wrap_connection do
          reload_connection()
          super
        end
      end
      
      def save!(*)
        possibly_wrap_connection do
          reload_connection()
          super
        end
      end
      
      def should_wrap_the_connection?
        respond_to?(:current_shard) && current_shard != nil
      end

      def possibly_wrap_connection(&block)
        if should_wrap_the_connection?
          Octopus.using(current_shard) { yield }
        else
          yield
        end
      end
      
    end
  end
end

ActiveRecord::Base.send(:include, Octopus::Rails3::Persistence)

module Schemer
  class Builder
    class <<self
      def inherited(klass)
        klass.root! unless root?
      end

      def root!
        @root = true
      end

      def root?
        !!@root
      end

      def definitions
        []
      end

      def schemas
        []
      end
    end
  end
end

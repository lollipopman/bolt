# frozen_string_literal: true

module Bolt
  class Plugin
    class EnvVar
      def initialize(*_args); end

      def name
        'env_var'
      end

      def hooks
        hook_descriptions.keys
      end

      def hook_descriptions
        {
          resolve_reference: 'Read values stored in environment variables.',
          validate_resolve_reference: nil
        }
      end

      def validate_resolve_reference(opts)
        unless opts['var']
          raise Bolt::ValidationError, "env_var plugin requires that the 'var' is specified"
        end
        return if opts['optional'] || opts['default']
        unless ENV[opts['var']]
          raise Bolt::ValidationError, "env_var plugin requires that the var '#{opts['var']}' be set"
        end
      end

      def resolve_reference(opts)
        ENV[opts['var']] || opts['default']
      end
    end
  end
end

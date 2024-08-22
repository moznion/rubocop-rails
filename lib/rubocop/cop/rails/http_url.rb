# frozen_string_literal: true

module RuboCop
  module Cop
    module Rails
      # Enforces passing a string literal as a URL to http method calls.
      #
      # @example
      #   # bad
      #   get photos_path
      #   put photo_path(id)
      #   post edit_photo_path(id)
      #
      #   # good
      #   get "/photos"
      #   put "/photos/#{id}"
      #   post "/photos/#{id}/edit"
      class HttpUrl < Base
        MSG = 'The first argument to `%<method>s` should be a string.'
        RESTRICT_ON_SEND = %i[get post put patch delete head].freeze

        def_node_matcher :request_method?, <<-PATTERN
          (send nil? {#{RESTRICT_ON_SEND.map(&:inspect).join(' ')}} $!str ...)
        PATTERN

        def on_send(node)
          request_method?(node) do |arg|
            add_offense(arg, message: format(MSG, method: node.method_name))
          end
        end
      end
    end
  end
end

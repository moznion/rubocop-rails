# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Rails::HttpUrl, :config do
  %i[get post put delete patch head].each do |http_method|
    it "registers an offense when first argument to `#{http_method}` is not a string" do
      padding = " #{' ' * http_method.length}"
      expect_offense(<<~RUBY, http_method: http_method)
        #{http_method} :resource
        #{padding}^^^^^^^^^ The first argument to `#{http_method}` should be a string.
      RUBY
    end

    it "does not register an offense when the first argument to #{http_method} is a string" do
      expect_no_offenses(<<~RUBY)
        #{http_method} '/resource'
      RUBY
    end
  end
end

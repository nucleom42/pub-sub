# frozen_string_literal: true

require 'spec_helper'
require './spec/shared_pub_sub'

describe PubSub do
  describe 'with container RequestStore' do
    before do
      PubSub::Configuration.init PubSub::RequestStore
    end

    include_examples 'pub sub'
  end
end

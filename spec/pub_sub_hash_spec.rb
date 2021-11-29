# frozen_string_literal: true

require 'spec_helper'
require './spec/shared_pub_sub'

describe PubSub do
  describe 'with container Hash' do
    before do
      PubSub::Configuration.init
    end

    include_examples 'pub sub'
  end
end


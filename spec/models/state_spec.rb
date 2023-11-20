# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

describe State do
  describe 'testing state method' do
    it 'calls std_fips_code' do
      result = ModelHelper.init_california.std_fips_code
      expect(result).to eq '06'
    end
  end
end

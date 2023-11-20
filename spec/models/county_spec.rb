# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

describe County do
  describe 'testing county method' do
    it 'calls std_fips_code' do
      expect(ModelHelper.init_sf[1].std_fips_code).to eq '075'
    end
  end
end

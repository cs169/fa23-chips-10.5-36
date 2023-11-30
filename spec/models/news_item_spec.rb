# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

describe NewsItem do
  describe 'testing state method' do
    before do
      @rep = ModelHelper.create_representative
      @other_rep = Representative.create!({ name: 'Other Test Representative',
        ocdid: 'ocd-division/country:us', title: 'Other Test Title' })

      @news_item = ModelHelper.create_news(@rep.id)
      ModelHelper.create_news(@other_rep.id)
    end

    it 'calls NewsItem find_for' do
      result = described_class.find_for(@rep.id)
      expect(result).to eq @news_item
    end

    it 'validates presence of issue' do
      news_item = described_class.new(issue: nil)
      expect(news_item).not_to be_valid
    end

    it 'allows saving with a valid issue' do
      news_item = described_class.new(issue: 'Student Loans', representative: @rep)
      expect(news_item).to be_valid
    end
  end
end

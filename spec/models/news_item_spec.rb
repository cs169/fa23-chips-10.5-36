# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe NewsItem do
  describe 'testing state method' do
    before do
      @rep = Representative.create!({ name: 'Test Representative',
        ocdid: 'ocd-division/country:us', title: 'Test Title' })

      @other_rep = Representative.create!({ name: 'Other Test Representative',
        ocdid: 'ocd-division/country:us', title: 'Other Test Title' })

      @news_item = described_class.create(
        representative: @rep,
        title:          'news story',
        description:    'news story description',
        link:           'google.com'
      )

      described_class.create(
        representative: @other_rep,
        title:          'news story',
        description:    'news story description',
        link:           'google.com'
      )
    end

    it 'calls NewsItem find_for' do
      result = described_class.find_for(@rep.id)
      expect(result).to eq @news_item
    end
  end
end

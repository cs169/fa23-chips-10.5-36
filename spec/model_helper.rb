# frozen_string_literal: true

class ModelHelper
  def self.init_california
    # Data taken from db/seeds.rb and might be incorrect
    State.create!({ name:         'California',
                    symbol:       'CA',
                    fips_code:    '06',
                    is_territory: 0,
                    lat_min:      '-124.409591',
                    lat_max:      '-114.131211',
                    long_min:     '32.534156',
                    long_max:     '-114.131211',
                    created_at:   '2023-11-19 22:20:00',
                    updated_at:   '2023-11-19 22:20:00' })
  end

  def self.init_state(state, symbol, code)
    State.create!({ name:         state,
                    symbol:       symbol,
                    fips_code:    code,
                    is_territory: 0,
                    lat_min:      0,
                    lat_max:      0,
                    long_min:     0,
                    long_max:     0,
                    created_at:   '2023-11-19 22:20:00',
                    updated_at:   '2023-11-19 22:20:00' })
  end

  def self.init_sf
    init_county('California', 'CA', '06', 'San Francisco County', 75)
  end

  def self.init_county(state, symbol, code, county_name, county_code)
    state = init_state(state, symbol, code)
    county = County.new do |c|
      c.name = county_name,
               c.state_id = code,
               c.fips_code = county_code,
               c.fips_class = 'H1',
               c.created_at = '2023-11-19 22:20:00',
               c.updated_at = '2023-11-19 22:20:00'
    end
    state.counties = [county]
    state.save
    county.save
    [state, county]
  end

  def self.create_event(county, name)
    Event.create!(
      name:        name,
      description: 'Test Event',
      county:      county,
      start_time:  '2024-11-19 22:20:00',
      end_time:    '2024-12-19 22:20:00'
    )
  end

  def self.create_representative
    Representative.create!({ name: 'Test Representative', created_at: '2023-11-19 22:22:00',
updated_at: '2023-11-19 22:23:00', ocdid: 'ocd-division/country:us', title: 'Test Title' })
  end

  def self.create_news(rep_id)
    NewsItem.create!({ title: 'Test News', description: 'Test Descrtiption', link: 'test.link.com',
representative_id: rep_id })
  end
end

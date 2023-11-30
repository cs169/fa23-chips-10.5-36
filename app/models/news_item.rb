# frozen_string_literal: true

class NewsItem < ApplicationRecord
  belongs_to :representative
  has_many :ratings, dependent: :delete_all
  # Add the 'issues' attribute to the model
  enum issue: {
    'Free Speech'                  => 'free_speech',
    'Immigration'                  => 'immigration',
    'Terrorism'                    => 'terrorism',
    'Social Security and Medicare' => 'social_security_medicare',
    'Abortion'                     => 'abortion',
    'Student Loans'                => 'student_loans',
    'Gun Control'                  => 'gun_control',
    'Unemployment'                 => 'unemployment',
    'Climate Change'               => 'climate_change',
    'Homelessness'                 => 'homelessness',
    'Racism'                       => 'racism',
    'Tax Reform'                   => 'tax_reform',
    'Net Neutrality'               => 'net_neutrality',
    'Religious Freedom'            => 'religious_freedom',
    'Border Security'              => 'border_security',
    'Minimum Wage'                 => 'minimum_wage',
    'Equal Pay'                    => 'equal_pay'
  }

  def self.find_for(representative_id)
    NewsItem.find_by(
      representative_id: representative_id
    )
  end
end

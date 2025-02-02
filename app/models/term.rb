# frozen_string_literal: true

class Term < ApplicationRecord
  has_many :academic_degree_terms,
           -> { joins(:academic_degree).order("academic_degrees.name DESC") },
           dependent: :destroy, inverse_of: :term
  has_many :academic_degrees, through: :academic_degree_terms # rubocop:disable Rails/InverseOf

  validates :year, presence: true
  validates :name, presence: true, uniqueness: { scope: %i[year tags] }

  scope :enabled, -> { where("enabled_at IS NOT NULL").order(year: :desc, name: :asc, tags: :asc) }
end

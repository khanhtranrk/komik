# frozen_string_literal: true

module Slugable
  extend ActiveSupport::Concern

  included do
    class_attribute :slug_candidates
    before_action :set_slug, only: :create
  end

  class_methods do
    def slugify(*args)
      self.slug_candidates = args
    end
  end

  def set_slug
    slug_candidate_values = self.slug_candidates.filter_map do |candidate|
      send(candidate) if respond_to?(candidate)
    end

    self.slug = "#{slug_candidate_values.join(' ').to_ascii.parameterize}-#{SecureRandom.base36}"
  end
end

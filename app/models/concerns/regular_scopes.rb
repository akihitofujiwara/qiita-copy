module RegularScopes
  extend ActiveSupport::Concern

  class_methods do
    def inherited (sub)
      super
      sub.scope :newer, -> { sub.order(id: :desc) }
      sub.scope :latest, -> (n) { sub.newer.limit(n) }
    end
  end
end


module Targetable
  extend ActiveSupport::Concern

  included do
    has_many :targets, as: :targetable, dependent: :destroy
    before_destroy { |t| t.targets.count == 0 }
  end

  def parent_targetable
    nil
  end
end
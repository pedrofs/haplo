module Targetable
  extend ActiveSupport::Concern

  included do
    has_many :targets, as: :targetable
  end

  def parent_targetable
    nil
  end
end
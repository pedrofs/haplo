module Targetable
  extend ActiveSupport::Concern

  included do
    has_many :targets, as: :targetable, dependent: :destroy
  end

  def parent_targetable
    nil
  end
end
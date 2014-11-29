require 'spec_helper'

shared_examples_for "Targetable" do
  let(:model) { described_class }

  describe "associations" do
    it { should have_many :targets }
  end

  describe "when destroyed" do
    it "should also destroy its targets" do
      modelInstance = create model.to_s.underscore.to_sym
      discussion = create :discussion
      discussion.build_targets_from_targetable modelInstance
      discussion.save!

      modelInstance.destroy!

      expect(modelInstance.destroyed?).to be(true)

      modelInstance.targets.each do |target|
        expect(target.destroyed?).to be(true)
      end
    end
  end
end
require 'rails_helper'

RSpec.describe Report::Component do
  def matching_rule
    Report::Rule.new([], ->() { true })
  end

  def non_matching_rule
    Report::Rule.new([], ->() { false })
  end

  describe 'a component with no children' do
    subject { Report::Component.new('ABC', ruleset) }

    context 'with a matching rule' do
      let(:ruleset) { Report::RuleSet.new([matching_rule]) }

      it 'is shown' do
        expect(subject.show?({})).to be(true)
      end
    end

    context 'with a non-matching rule' do
      let(:ruleset) { Report::RuleSet.new([non_matching_rule]) }

      it 'is shown' do
        expect(subject.show?({})).to be(false)
      end
    end

    context 'with a QueryOperand-based rule' do
      let(:query_op) { Report::QueryOperand.future(:a) }
      let(:literal_op) { Report::LiteralOperand.new(10.0) }

      let(:ruleset) do
        Report::RuleSet.new([
          Report::Rule.new([query_op, literal_op], Report::Operators[:>])
        ])
      end

      it 'is shown when the value passes' do
        expect(subject.show?(a: { future: 12.0 })).to be(true)
      end

      it 'is hidden when the value passes' do
        expect(subject.show?(a: { future: 8.0 })).to be(false)
      end
    end
  end # a component with no children
end

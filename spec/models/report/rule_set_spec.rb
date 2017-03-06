require 'rails_helper'

RSpec.describe Report::RuleSet do
  context 'with [Literal(1.0) < Literal(2.0), Literal(1.0) > Literal(2.0)]' do
    let(:rules) do
      [
        Report::Rule.new([
          Report::LiteralOperand.new(1.0),
          Report::LiteralOperand.new(2.0)
        ], Report::Operators[:<]),

        Report::Rule.new([
          Report::LiteralOperand.new(1.0),
          Report::LiteralOperand.new(2.0)
        ], Report::Operators[:>])
      ]
    end

    context 'when all must match' do
      subject { Report::RuleSet.new(rules, true) }

      it 'is false' do
        expect(subject.call({})).to eql(false)
      end

      it 'joins rules with && in to_s' do
        expect(subject.to_s).to include(' && ')
      end
    end

    context 'when any must match' do
      subject { Report::RuleSet.new(rules, false) }

      it 'is true' do
        expect(subject.call({})).to eql(true)
      end

      it 'joins rules with || in to_s' do
        expect(subject.to_s).to include(' || ')
      end
    end
  end

  context 'with no rules' do
    subject { Report::RuleSet.new([]) }

    it 'is true' do
      expect(subject.call({})).to eql(true)
    end
  end
end

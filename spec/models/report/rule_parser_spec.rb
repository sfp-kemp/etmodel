require 'rails_helper'

RSpec.describe Report::RuleParser do
  let(:rule) { Report::RuleParser.parse(rule_str) }

  context 'with: 1 > 2' do
    let(:rule_str) { '1 > 2' }

    it 'returns a rule' do
      expect(rule).to be_kind_of(Report::Rule)
    end
  end

  context 'with: 1' do
    let(:rule_str) { '1' }

    it 'raises an error' do
      expect { rule }.to raise_error('Missing operator in: 1')
    end
  end

  context 'with: ">"' do
    let(:rule_str) { '">"' }

    it 'raises an error' do
      expect { rule }.to raise_error('Unparseable operand ">" in: ">"')
    end
  end

  context 'with: 1 >' do
    let(:rule_str) { '1 >' }

    it 'raises an error' do
      expect { rule }.to raise_error('Missing right operand in: 1 >')
    end
  end

  context 'with: 1 ^ 2' do
    let(:rule_str) { '1 ^ 2' }

    it 'raises an error' do
      expect { rule }.to raise_error('Unknown operator ^ in: 1 ^ 2')
    end
  end

  context 'with: & > 2' do
    let(:rule_str) { '& > 2' }

    it 'raises an error' do
      expect { rule }.to raise_error('Unparseable operand & in: & > 2')
    end
  end

  context 'with: 1 > 2 && 3 > 4' do
    let(:rule_str) { '1 > 2 && 3 > 4' }

    it 'raises an error' do
      expect { rule }.to raise_error(
        'Unused rule tokens ["&&", "3", ">", "4"] in: 1 > 2 && 3 > 4'
      )
    end
  end
end

require 'rails_helper'

RSpec.describe Report::Rule do
  context 'with literal operands' do
    subject do
      Report::Rule.new(
        operands.map { |value| Report::LiteralOperand.new(value) },
        Report::Operators[comparison]
      )
    end

    # Comparison: >

    context 'Literal(1.0) > Literal(2.0)' do
      let(:operands) { [1.0, 2.0] }
      let(:comparison) { :> }

      it 'is false' do
        expect(subject.call({})).to be(false)
      end
    end

    context 'Literal(2.0) > Literal(1.0)' do
      let(:operands) { [2.0, 1.0] }
      let(:comparison) { :> }

      it 'is true' do
        expect(subject.call({})).to be(true)
      end
    end

    # Comparison: >=

    context 'Literal(1.0) >= Literal(2.0)' do
      let(:operands) { [1.0, 2.0] }
      let(:comparison) { :>= }

      it 'is false' do
        expect(subject.call({})).to be(false)
      end
    end

    context 'Literal(2.0) >= Literal(1.0)' do
      let(:operands) { [2.0, 1.0] }
      let(:comparison) { :>= }

      it 'is true' do
        expect(subject.call({})).to be(true)
      end
    end

    context 'Literal(2.0) >= Literal(2.0)' do
      let(:operands) { [2.0, 2.0] }
      let(:comparison) { :>= }

      it 'is true' do
        expect(subject.call({})).to be(true)
      end
    end

    # Comparison: <

    context 'Literal(1.0) < Literal(2.0)' do
      let(:operands) { [1.0, 2.0] }
      let(:comparison) { :< }

      it 'is true' do
        expect(subject.call({})).to be(true)
      end
    end

    context 'Literal(2.0) < Literal(1.0)' do
      let(:operands) { [2.0, 1.0] }
      let(:comparison) { :< }

      it 'is false' do
        expect(subject.call({})).to be(false)
      end
    end

    # Comparison: <=

    context 'Literal(1.0) <= Literal(2.0)' do
      let(:operands) { [1.0, 2.0] }
      let(:comparison) { :<= }

      it 'is true' do
        expect(subject.call({})).to be(true)
      end
    end

    context 'Literal(2.0) <= Literal(1.0)' do
      let(:operands) { [2.0, 1.0] }
      let(:comparison) { :<= }

      it 'is false' do
        expect(subject.call({})).to be(false)
      end
    end

    context 'Literal(2.0) <= Literal(2.0)' do
      let(:operands) { [2.0, 2.0] }
      let(:comparison) { :>= }

      it 'is true' do
        expect(subject.call({})).to be(true)
      end
    end

    # Comparison: ==

    context 'Literal(true) == Literal(false)' do
      let(:operands) { [true, false] }
      let(:comparison) { :== }

      it 'is false' do
        expect(subject.call({})).to be(false)
      end
    end

    context 'Literal(true) == Literal(true)' do
      let(:operands) { [true, true] }
      let(:comparison) { :== }

      it 'is true' do
        expect(subject.call({})).to be(true)
      end
    end

    # Comparison: !=

    context 'Literal(true) != Literal(false)' do
      let(:operands) { [true, false] }
      let(:comparison) { :!= }

      it 'is true' do
        expect(subject.call({})).to be(true)
      end
    end

    context 'Literal(true) != Literal(true)' do
      let(:operands) { [true, true] }
      let(:comparison) { :!= }

      it 'is false' do
        expect(subject.call({})).to be(false)
      end
    end
  end # with literal operands

  context 'with a query operand' do
    subject { Report::Rule.new(operands, Report::Operators[comparison]) }

    context 'Query.future(:a)(a: { future: 1.0 }) > Literal(2.0)' do
      let(:operands) do
        [ Report::QueryOperand.future(:a),
          Report::LiteralOperand.new(2.0) ]
      end

      let(:comparison) { :> }

      it 'is false' do
        expect(subject.call(a: { future: 1.0 })).to be(false)
      end
    end

    context 'Query.future(:a)(a: { future: 2.0 }) > Literal(1.0)' do
      let(:operands) do
        [ Report::QueryOperand.future(:a),
          Report::LiteralOperand.new(1.0) ]
      end

      let(:comparison) { :> }

      it 'is true' do
        expect(subject.call(a: { future: 2.0 })).to be(true)
      end
    end
  end # with a query operand

  describe '#to_s' do
    context 'Query.future(:a) > Literal(1.0)' do
      subject do
        Report::Rule.new([
          Report::QueryOperand.future(:a),
          Report::LiteralOperand.new(1.0)
        ], Report::Operators[:<])
      end

      it 'includes the first operand' do
        expect(subject.to_s).to include('QueryOperand.future')
      end

      it 'includes the second operand' do
        expect(subject.to_s).to include('LiteralOperand')
      end

      it 'includes the comparison, when available' do
        expect(subject.to_s).to include('<')
      end
    end

    context 'Query.future(:a) (->() {}) Literal(1.0)' do
      subject do
        Report::Rule.new([
          Report::QueryOperand.future(:a),
          Report::LiteralOperand.new(1.0)
        ], ->(*) { true })
      end

      it 'includes the first operand' do
        expect(subject.to_s).to include('QueryOperand.future')
      end

      it 'includes the second operand' do
        expect(subject.to_s).to include('LiteralOperand')
      end

      it 'uses a placeholder for the comparison' do
        expect(subject.to_s).to include(' Proc ')
      end
    end
  end # to_s
end

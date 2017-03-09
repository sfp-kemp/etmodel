require 'rails_helper'

RSpec.shared_examples 'a report component' do |content, type|
  it 'sets the component content' do
    expect(subject.content[:content]).to eq(content)
  end

  it "sets the component type to #{ type.inspect }" do
    expect(subject.content[:type]).to eq(type)
  end
end

RSpec.describe Report, '.build' do
  let(:components) { Report.build(YAML.safe_load(definition)) }

  it 'returns an array' do
    expect(Report.build([])).to eq([])
  end

  Report::CONTENT_KEYS.each do |key|
    context "with a single #{ key } component" do
      let(:definition) do
        <<-YAML.strip_heredoc
        ---
        - #{ key }: 'Hello world'
        YAML
      end

      it 'has a single component' do
        expect(components.length).to eq(1)
      end

      include_examples('a report component', 'Hello world', key) do
        subject { components.first }
      end

      it 'has an always-shown ruleset' do
        expect(components.first.show?({})).to be(true)
      end
    end
  end

  context 'with a nested component' do
    let(:definition) do
      <<-YAML.strip_heredoc
      ---
      - children:
        - text: 'First'
        - text: 'Second'
      YAML
    end

    it 'has a single top-level component' do
      expect(components.length).to eq(1)
    end

    it 'has two child components' do
      expect(components.first.children.length).to eq(2)
    end

    context 'the first child component' do
      subject { components.first.children.first }
      include_examples 'a report component', 'First', :text
    end

    context 'the second child component' do
      subject { components.first.children.last }
      include_examples 'a report component', 'Second', :text
    end
  end

  context 'with two top-level components' do
    let(:definition) do
      <<-YAML.strip_heredoc
      ---
      - text: 'First'
      - text: 'Second'
      YAML
    end

    it 'has two components' do
      expect(components.length).to eq(2)
    end

    context 'the first component' do
      subject { components.first }
      include_examples 'a report component', 'First', :text
    end

    context 'the second component' do
      subject { components.last }
      include_examples 'a report component', 'Second', :text
    end
  end

  context 'with rule: true == true' do
    let(:definition) do
      <<-YAML.strip_heredoc
      ---
      - text: Message
        if: true == true
      YAML
    end

    it 'sets a rule' do
      expect(components.first.show?({})).to eq(true)
    end
  end

  context 'with rule: true == false' do
    let(:definition) do
      <<-YAML.strip_heredoc
      ---
      - text: Message
        if: true == false
      YAML
    end

    it 'sets a rule' do
      expect(components.first.show?({})).to eq(false)
    end
  end

  context 'when a text component has translations' do
    let(:definition) do
      <<-YAML.strip_heredoc
      ---
      - text:
          en: English
          nl: Dutch
      YAML
    end

    it 'includes sets the content to include the translations' do
      expect(components.first.content[:content])
        .to eq('en' => 'English', 'nl' => 'Dutch')
    end
  end

  context 'when a component has multiple content attributes' do
    let(:definition) do
      <<-YAML.strip_heredoc
      ---
      - h1: Header
        text: Text
      YAML
    end

    it 'raises an error' do
      expect { components }.to raise_error(
        'Component must not have multiple content attributes: ' \
        '{ h1: "Header", text: "Text" }'
      )
    end
  end

  context 'when a component has no presentation attributes' do
    let(:definition) do
      <<-YAML.strip_heredoc
      ---
      - if: future(one) > 2
      YAML
    end

    it 'raises an error' do
      expect { components }.to raise_error(
        'Component must have some text or children: ' \
        '{ if: "future(one) > 2" }'
      )
    end
  end

  context 'when a component has unknown attributes' do
    let(:definition) do
      <<-YAML.strip_heredoc
      ---
      - text: Hi
        nope: Why is this here?
        why: And this?
      YAML
    end

    it 'raises an error' do
      expect { components }.to raise_error(
        'Component must not have unknown attributes ([:nope, :why]): ' \
        '{ nope: "Why is this here?", text: "Hi", why: "And this?" }'
      )
    end
  end
end

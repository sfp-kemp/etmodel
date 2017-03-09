require 'rails_helper'

RSpec.describe Report::Presenter do
  let(:fetcher)    { ->(*) { { 'gqueries' => {} } } }
  let(:components) { Report.build(YAML.safe_load(definition)) }

  let(:as_json) do
    Report::Presenter.new(components, 0, 'en', fetcher: fetcher).as_json
  end

  context 'with a text component' do
    let(:definition) do
      <<-YAML.strip_heredoc
      ---
      - text: Hello
      YAML
    end

    it 'has one component' do
      expect(as_json[:components].length).to eq(1)
    end

    it 'sets type to "text"' do
      expect(as_json[:components].first[:type]).to eq(:text)
    end

    it 'sets the content' do
      expect(as_json[:components].first[:content]).to eq('Hello')
    end

    it 'has no children' do
      children = as_json[:components].first[:children]

      expect(children).to be_kind_of(Array)
      expect(children).to be_empty
    end
  end

  context 'when the component has translated content' do
    let(:definition) do
      <<-YAML.strip_heredoc
      ---
      - text:
          en: English text
          nl: Dutch text
      YAML
    end

    it 'includes only text for the current locale' do
      expect(as_json[:components].first[:content]).to eq('English text')
    end
  end

  context 'with an if attribute' do
    let(:definition) do
      <<-YAML.strip_heredoc
      ---
      - text: Hello
      YAML
    end

    it 'does not include the :if attribute' do
      expect(as_json[:components].first).not_to have_key(:if)
    end
  end

  context 'with a child component' do
    let(:definition) do
      <<-YAML.strip_heredoc
      ---
      - children:
        - text: One
        - text: Two
      YAML
    end

    it 'has two children' do
      children = as_json[:components].first[:children]

      expect(children).to be_kind_of(Array)
      expect(children.length).to eq(2)
    end

    it 'sets the content of the children' do
      children = as_json[:components].first[:children]

      children.each do |child|
        expect(child[:content]).to be
      end
    end
  end

  context 'with a non-matching rule' do
    let(:definition) do
      <<-YAML.strip_heredoc
      ---
      - if: 1 > 2
        children:
          - text: One
          - text: Two
      YAML
    end

    it 'does not include the component' do
      expect(as_json[:components]).to be_empty
    end
  end

  context 'with a matching rule' do
    let(:definition) do
      <<-YAML.strip_heredoc
      ---
      - if: 2 > 1
        children:
          - text: One
          - text: Two
      YAML
    end

    it 'does includes the component' do
      expect(as_json[:components].length).to eq(1)
    end

    it 'includes matching child components' do
      expect(as_json[:components].first[:children].length).to eq(2)
    end
  end

  context 'when components use a query' do
    let(:result)  { { 'present' => 1.0, 'future' => 2.0 } }
    let(:fetcher) { ->(*) { { 'gqueries' => { 'one' => result } } } }

    let(:definition) do
      <<-YAML.strip_heredoc
      ---
      - if: present(one) > 1
        text: One
      - if: future(one) > 1
        text: Two
      YAML
    end

    it 'shows components which pass the rule' do
      expect(as_json[:components].length).to eq(1)
      expect(as_json[:components].first[:content]).to eq('Two')
    end
  end

  context 'when ETE returns an error message' do
    let(:fetcher) { ->(*) { { 'errors' => ['Oops, that did not work.'] } } }

    let(:definition) do
      <<-YAML.strip_heredoc
      ---
      - if: future(one) > 1
        text: One
      - text: Two
      YAML
    end

    it 'includes the error message with the :errors key' do
      expect(as_json[:errors]).to eq(['Oops, that did not work.'])
    end

    it 'sends no components' do
      expect(as_json[:components]).to be_empty
    end
  end
end

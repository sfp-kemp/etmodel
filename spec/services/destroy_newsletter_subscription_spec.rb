# frozen_string_literal: true

require 'rails_helper'

describe DestroyNewsletterSubscription, type: :service do
  let(:service) { described_class.new('API_KEY', 'http://localhost/lists/1') }
  let(:result) { service.call(user) }

  let(:user) { FactoryBot.create(:user) }

  # --

  # Returns a Struct which quacks enough like an HTTParty::Response for our
  # purposes.
  def stub_response(code, uri: '', method: :get, body: {})
    allow(HTTParty)
      .to receive(method)
      .with(
        "http://localhost/lists/1/members/#{uri}",
        hash_including(basic_auth: { username: 'none', password: 'API_KEY' })
      )
      .and_return(ServicesHelper::StubResponse.new(code, body))
  end

  # --

  context 'when the contact does not exist' do
    before do
      stub_response(
        404,
        uri: MailchimpService.remote_id(user.email),
        method: :patch
      )
    end

    it 'is successful' do
      expect(result).to be_successful
    end

    it 'sends a request to the remote service' do
      result

      expect(HTTParty).to have_received(:patch).with(
        %r{/members/#{MailchimpService.remote_id(user.email)}},
        hash_including(body: { status: 'unsubscribed' }.to_json)
      )
    end
  end

  context 'when the contact exists' do
    before do
      stub_response(
        200,
        uri: MailchimpService.remote_id(user.email),
        method: :patch
      )
    end

    it 'is successful' do
      expect(result).to be_successful
    end

    it 'sends a request to the remote service' do
      result

      expect(HTTParty).to have_received(:patch).with(
        %r{/members/#{MailchimpService.remote_id(user.email)}},
        hash_including(body: { status: 'unsubscribed' }.to_json)
      )
    end
  end

  context 'when the remote service returns an error' do
    before do
      stub_response(
        500,
        uri: MailchimpService.remote_id(user.email),
        method: :patch,
        body: {
          'status' => 500,
          'title' => 'InternalServerError',
          'detail' => 'An error occurred'
        }
      )
    end

    it 'is not successful' do
      expect(result).not_to be_successful
    end

    it 'includes the errors on the Result' do
      expect(result.errors).to eq([
        'Mailchimp error: 500 InternalServerError: An error occurred'
      ])
    end
  end
end

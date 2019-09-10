# frozen_string_literal: true

require 'rails_helper'

describe Admin::ProjectorsController do
  let(:admin) { FactoryBot.create :admin }

  describe 'GET index' do
    before(:each) do
      login_as(admin)
      get :index
    end

    it { expect(response.status).to eq(200) }
    it { expect(assigns(:projectors)) }
    it { expect(response).to render_template(layout: 'admin') }
  end
end

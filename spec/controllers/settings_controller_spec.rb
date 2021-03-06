require 'rails_helper'

describe SettingsController do
  describe 'on PUT /settings', vcr: true do
    it "should update individual settings" do
      put :update, params: { format: :json, use_fce: true }
      expect(response).to be_successful
      expect(session[:setting][:use_fce].to_s).to eq('true')
    end

    it "should update individual settings passed as strings" do
      put :update, params: { format: :json, "use_fce" => true }
      expect(response).to be_successful
      expect(session[:setting][:use_fce].to_s).to eq('true')
    end

    it "should update the charts hash" do
      put :update, params: {
        format: :json, locked_charts: [123]
      }

      expect(response).to be_successful
      expect(session[:setting][:locked_charts]).to eql(['123'])
    end

    it "should update the charts hash" do
      put :update, params: { format: :json, locked_charts: [] }
      expect(response).to be_successful
      expect(session[:setting][:locked_charts]).to eql([])
    end
  end

  describe 'on PUT /settings/dashboard' do
    let(:constraints) do
      Constraint::GROUPS.each_with_object([]) do |group, c|
        c.push FactoryBot.create(:constraint, group: group)
      end
    end

    let(:dash_settings) do
      enum = Constraint::GROUPS.to_enum

      enum.with_index.each_with_object({}) do |(group, index), c|
        c[ group ] = constraints[ index ].key
      end
    end

    # ------------------------------------------------------------------------

    context 'when given a valid setting hash' do
      it 'should return 200 OK' do
        put :update_dashboard, params: { dash: dash_settings }
        expect(response.code).to eql('200')
      end

      it 'should return the constraints as JSON' do
        put :update_dashboard, params: { dash: dash_settings }

        parsed = JSON.parse(response.body)
        expect(parsed).to have_key('constraints')
        expect(parsed['constraints']).to eql(constraints.map(&:as_json))
      end

      it 'should return HTML with which to replace the dashboard' do
        put :update_dashboard, params: { dash: dash_settings }
        expect(JSON.parse(response.body)).to have_key('html')
      end

      it 'should set the preferences in the session' do
        put :update_dashboard, params: { dash: dash_settings }
        expect(session[:dashboard]).to eql(dash_settings.values)
      end
    end

    # ------------------------------------------------------------------------

    context 'when no setting hash is provided' do
      it 'should return a 400 Bad Request' do
        put :update_dashboard
        expect(response.status).to eql(400)
      end
    end

    # ------------------------------------------------------------------------

    context 'when the setting option is not a hash' do
      it 'should return a 400 Bad Request' do
        put :update_dashboard, params: { dash: 'invalid' }
        expect(response.status).to eql(400)
      end
    end

    # ------------------------------------------------------------------------

    context 'when given extra options' do
      it 'should not set extra keys on the session' do
        put :update_dashboard, params: {
          dash: dash_settings.merge(another: constraints[0].key)
        }

        expect(session[:dashboard]).to eql(dash_settings.values)
      end
    end

    # ------------------------------------------------------------------------

    context 'when given only a subset of options' do
      it 'should not accept partial assignment' do
        put :update_dashboard, params: { dash: {
          Constraint::GROUPS[0] => constraints[0].key,
          Constraint::GROUPS[1] => constraints[1].key
        } }

        expect(response.status).to eql(400)
      end
    end

    # ------------------------------------------------------------------------

    context 'when given an invalid constraint ID' do
      it 'should return a 400 Bad Request' do
        put :update_dashboard, params: {
          dash: dash_settings.merge(Constraint::GROUPS[0] => 0)
        }

        expect(response.status).to eql(400)
      end
    end

    # ------------------------------------------------------------------------

  end
end

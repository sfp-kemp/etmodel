require 'spec_helper'

describe ConstraintsController do
  render_views

  describe "on GET show" do
    let(:constraint) { Constraint.find_by_key('total_primary_energy') }

    before { get :show, :id => constraint.id }

    it { should respond_with(:success) }
    it { should render_template(:show) }
  end
end

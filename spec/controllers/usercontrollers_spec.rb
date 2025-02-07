require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe '#show' do
    it 'should return the user with given id' do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eql(user)
    end
  end
end
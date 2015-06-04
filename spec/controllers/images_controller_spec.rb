require 'rails_helper'

describe ImagesController do
  describe 'GET #index' do
    let!(:registration) { '1234567' }
    let!(:reference) { '123456789' }
    let(:uri) { '/devices' }

    context 'without params' do
      it 'renders the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end
    context 'with params' do
      it 'assigns the candidate images' do
        get :index, registration: registration, reference: reference
        image = Image.new(registration: registration, reference: reference)
        expect(assigns(:image)).to eq image
      end
      it 'renders the :index template' do
        get :index, registration: reference, reference: registration
        expect(response).to render_template :index
      end
    end
    context 'AJAX with params' do
      it 'assigns the candidate images' do
        xhr :get, :index, registration: registration, reference: reference, format: :js
        image = Image.new(registration: registration, reference: reference)
        expect(assigns(:image)).to eq image
      end
      it 'renders the :index.js template' do
        xhr :get, :index, registration: registration, reference: reference, format: :js
        expect(response).to render_template :index
      end
    end
  end
end
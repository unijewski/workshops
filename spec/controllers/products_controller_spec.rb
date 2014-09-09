require 'spec_helper'

describe ProductsController do
  let(:category)      { create(:category) }
  let(:valid_session) { Hash.new }
  let(:valid_attributes) do
    {
      title: 'MyString',
      description: 'Some description',
      price: 2.5,
      category_id: category.id,
    }
  end

  context 'user is not signed in' do
    describe 'POST create' do
      describe 'with valid params' do
        it 'redirects user to login page' do
          post :create, { product: valid_attributes, category_id: category.to_param }, valid_session
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end

    describe 'PUT update' do
      describe 'with valid params' do
        it 'redirects user to login page' do
          product = Product.create! valid_attributes
          put :update, { id: product.to_param, product: { title: 'MyString' }, category_id: category.to_param }, valid_session
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end
  end

  context 'another user is signed in' do
    let(:user) { create(:user) }
    let(:user2) { build(:user) }
    let(:product) { Product.create! valid_attributes }

    before do
      sign_in user2
      controller.stub(:user_signed_in?).and_return(true)
      controller.stub(:current_user).and_return(user2)
      controller.stub(:authenticate_user!).and_return(user2)
      product.user = user
    end

    describe 'GET edit' do
      describe 'with valid params' do
        it 'redirects to product page' do
          get :edit, { id: product.to_param, category_id: category.to_param }, valid_session
          expect(response).to redirect_to(category_product_url(category, product))
        end

        it 'renders error message' do
          get :edit, { id: product.to_param, category_id: category.to_param }, valid_session
          expect(controller.flash[:error]).to eq 'You are not allowed to edit this product.'
        end
      end
    end

    describe 'PUT update' do
      describe 'with valid params' do
        it 'redirects to product page' do
          put :update, { id: product.to_param, product: { 'title' => 'MyString' }, category_id: category.to_param }, valid_session
          expect(response).to redirect_to(category_product_url(category, product))
        end

        it 'does not update product' do
          put :update, { id: product.to_param, product: { 'title' => 'MyNewString' }, category_id: category.to_param }, valid_session
          expect(controller.product.title).to_not eq 'MyNewString'
        end

        it 'renders error message' do
          put :update, { id: product.to_param, product: { 'title' => 'MyString' }, category_id: category.to_param }, valid_session
          expect(controller.flash[:error]).to eq 'You are not allowed to edit this product.'
        end
      end
    end
  end

  context 'when allowed user is signed in' do
    let(:user) { create(:user) }
    let(:valid_attributes) do
      {
        title: 'MyString',
        description: 'Some description',
        price: 2.5,
        category_id: category.id,
        user_id: 1
      }
    end
    let(:product) { Product.create! valid_attributes }

    before do
      sign_in user
      controller.stub(:user_signed_in?).and_return(true)
      controller.stub(:current_user).and_return(user)
      controller.stub(:authenticate_user!).and_return(user)
      product.user = user
    end

    describe 'GET index' do
      it 'expose all products' do
        get :index, { category_id: category.to_param }, valid_session
        expect(controller.products).to eq([product])
      end
    end

    describe 'GET show' do
      it 'expose the requested product' do
        get :show, { id: product.to_param, category_id: category.to_param }, valid_session
        expect(controller.product).to eq(product)
      end
    end

    describe 'GET new' do
      it 'expose a new product' do
        get :new, { category_id: category.to_param }, valid_session
        expect(controller.product).to be_a_new(Product)
      end
    end

    describe 'GET edit' do
      it 'expose the requested product' do
        get :edit, { id: product.to_param, category_id: category.to_param }, valid_session
        expect(controller.product).to eq(product)
      end
    end

    describe 'POST create' do
      describe 'with valid params' do
        it 'creates a new Product' do
          expect {
            post :create, { product: valid_attributes, category_id: category.to_param }, valid_session
          }.to change(Product, :count).by(1)
        end

        it 'expose a newly created product' do
          post :create, { product: valid_attributes, category_id: category.to_param }, valid_session
          expect(controller.product).to be_a(Product)
          expect(controller.product).to be_persisted
        end

        it 'redirects to the created product' do
          post :create, { product: valid_attributes, category_id: category.to_param }, valid_session
          expect(response).to redirect_to(category_product_url(category, Product.last))
        end
      end

      describe 'with invalid params' do
        it 'expose a newly created but unsaved product' do
          Product.any_instance.stub(:save).and_return(false)
          post :create, { product: { 'title' => 'invalid value' }, category_id: category.to_param }, valid_session
          expect(controller.product).to be_a_new(Product)
        end

        it "re-renders the 'new' template" do
          Product.any_instance.stub(:save).and_return(false)
          post :create, { product: { 'title' => 'invalid value' }, category_id: category.to_param }, valid_session
          expect(response).to render_template('new')
        end
      end
    end

    describe 'PUT update' do
      describe 'with valid params' do
        it 'updates the requested product' do
          expect_any_instance_of(Product).to receive(:update).with({ 'title' => 'MyString' })
          put :update, { id: product.to_param, product: { 'title' => 'MyString' }, category_id: category.to_param }, valid_session
        end

        it 'expose the requested product' do
          put :update, { id: product.to_param, product: valid_attributes, category_id: category.to_param }, valid_session
          expect(controller.product).to eq(product)
        end

        it 'redirects to the product' do
          put :update, { id: product.to_param, product: valid_attributes, category_id: category.to_param }, valid_session
          expect(response).to redirect_to(category_product_url(category, product))
        end
      end

      describe 'with invalid params' do
        it 'expose the product' do
          Product.any_instance.stub(:save).and_return(false)
          put :update, { id: product.to_param, product: { 'title' => 'invalid value' }, category_id: category.to_param }, valid_session
          expect(controller.product).to eq(product)
        end

        it "re-renders the 'edit' template" do
          Product.any_instance.stub(:save).and_return(false)
          put :update, { id: product.to_param, product: { 'title' => 'invalid value' }, category_id: category.to_param }, valid_session
          expect(response).to render_template('edit')
        end
      end
    end

    describe 'DELETE destroy' do
      it 'destroys the requested product' do
        expect {
          delete :destroy, { id: product.to_param, category_id: category.to_param }, valid_session
        }.to change(Product, :count).by(-1)
      end

      it 'redirects to the category page' do
        delete :destroy, { id: product.to_param, category_id: category.to_param }, valid_session
        expect(response).to redirect_to(category_url(category))
      end
    end
  end
end

require 'spec_helper'

describe Product do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :price }

    describe '#price' do
      let(:product) { build(:product, price: 1.234) }

      it 'is limited to two decimal places' do
        expect(product).to_not be_valid
      end
    end

    describe '#average_rating' do
      let(:product) { create(:product) }
      let(:user) { create(:user, firstname: 'Jan', lastname: 'Kowalski') }
      let(:review1) { create(:review, rating: 2, user: user) }
      let(:review2) { create(:review, rating: 3, user: user) }

      before do
        product.reviews << [review1, review2]
      end

      it 'calculates average rating' do
        expect(product.average_rating).to eq 2.5
      end
    end
  end
end

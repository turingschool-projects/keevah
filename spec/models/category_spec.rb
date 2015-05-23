require 'rails_helper'

RSpec.describe Category do
  let(:category) { FactoryGirl.create(:category_1) }

  describe 'validations' do
    it 'validates name and description' do
      expect(category).to be_valid
    end

    it 'is invalid without a name' do
      category.name = nil
      expect(category).to_not be_valid

      category.name = ''
      expect(category).to_not be_valid
    end
  end

  describe 'relationships' do
    it 'has many loan requests' do
      loan_request = LoanRequest.create(user_id: 1, title: 'title',
                                        blurb: 'blurb',
                                        description: 'description',
                                        borrowing_amount: 10,
                                        amount_funded: 0,
                                        requested_by_date: DateTime.now,
                                        payments_begin_date: DateTime.now.months_since(1),
                                        payments_end_date: DateTime.now.months_since(7),
                                        status: true, categories: [category])

      loan_request1 = LoanRequest.create(user_id: 2, title: 'title1',
                                         blurb: 'blurb',
                                         description: 'description1',
                                         borrowing_amount: 110,
                                         amount_funded: 10,
                                         requested_by_date: DateTime.now,
                                         payments_begin_date: DateTime.now.months_since(1),
                                         payments_end_date: DateTime.now.months_since(7),
                                         status: true, categories: [category])

      expect(category.loan_requests).to eq([loan_request1, loan_request])

      expect(category.loan_requests_count).to eq(2)
    end
  end

  describe 'creating friendly URLs' do
    it 'can parameterize the slug' do
      expect(category.slug).to eq('pig-farmers')
    end

    it 'is invalid if a category name is a reserved route' do
      category.name = 'cart'
      expect(category).to_not be_valid
    end
  end
end

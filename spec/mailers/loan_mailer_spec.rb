require "rails_helper"

RSpec.describe LoanMailer, :type => :mailer do
  before(:each) do
    loan_request_1
    loan_request_2
    tenant
  end

  let(:loan_request_1) do
    FactoryGirl.create(:loan_request_1, user: user)
  end

  let(:loan_request_2) do
    FactoryGirl.create(:loan_request_2, user: user)
  end

  let(:user) do
    FactoryGirl.create(:user)
  end

  let(:tenant) do
    FactoryGirl.create(:tenant) do |tenant|
      tenant.users << user
    end
  end

  it "sends an email to the user giving money" do
    checkout_loans = []

    checkout_amounts = ["25", "25"]
    checkout_loans << loan_request_1.id
    checkout_loans << loan_request_2.id

    LoanMailer.lent_money(user.id, checkout_loans, checkout_amounts).deliver_now
    result = ActionMailer::Base.deliveries.last

    expect(result).not_to be_nil
    expect(result.to).to include("doug@aperturelabs.com")
    expect(result.from).to include("chase@example.com")
    expect(result.subject).to eq("Your order has been processed.")
  end

  it "sends an email to the tenant receiving money" do
    checkout_loans = []

    checkout_amounts = ["25", "25"]
    checkout_loans << loan_request_1.id
    checkout_loans << loan_request_2.id

    checkout_loans.each_with_index do |loan, index|
      LoanMailer.received_money(user.id, loan, checkout_amounts[index]).deliver_now
    end
    result = ActionMailer::Base.deliveries.first
    result2 = ActionMailer::Base.deliveries.last

    expect(result).not_to be_nil
    expect(result.to).to include("doug@aperturelabs.com")
    expect(result.from).to include("chase@example.com")
    expect(result.subject).to eq("You have received funding.")

    expect(result2).not_to be_nil
    expect(result2.to).to include("doug@aperturelabs.com")
    expect(result2.from).to include("chase@example.com")
    expect(result2.subject).to eq("You have received funding.")
  end
end

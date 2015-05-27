class LoanMailer < ActionMailer::Base
  default from: "chase@example.com"

  def lent_money(user_id, loan_request_ids, checkout_amounts)
    @user = User.find_by(id: user_id)
    email = @user.email
    @loans = loan_request_ids.map do |loan_request_id|
      get_loan_request_object_from_id(loan_request_id)
    end
    @amounts = checkout_amounts
    mail(to: email, subject: "Your order has been processed.")
  end

  def received_money(user_id, loan_request_id, checkout_amount)
    @user = User.find_by(id: user_id)
    email = @user.email
    @loan = get_loan_request_object_from_id(loan_request_id)
    user_email = @loan.user.email
    @amount = checkout_amount
      mail(to: email, subject: "You have received funding.")
  end

  def get_loan_request_object_from_id(loan_request_id)
    loan_request = LoanRequest.find_by("id = ?", loan_request_id)
  end
end

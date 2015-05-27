class SendEmailJob
  def perform(current_user, cart_loans_keys, cart_loans_values)
    LoanMailer.lent_money(current_user, cart_loans_keys, cart_loans_values).deliver_now
    cart_loans_keys.each_with_index do |loan_request_id, index|
      LoanMailer.received_money(current_user, loan_request_id, cart_loans_values[index]).deliver_now
    end
  end
end

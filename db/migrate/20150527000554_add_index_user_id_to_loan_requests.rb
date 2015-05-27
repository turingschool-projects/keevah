class AddIndexUserIdToLoanRequests < ActiveRecord::Migration
  def change
    add_index :loan_requests, :user_id
  end
end

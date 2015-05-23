class AddIndexOnIdsToLoanRequestCategory < ActiveRecord::Migration
  def change
    add_index :loan_request_categories, :category_id
    add_index :loan_request_categories, :loan_request_id
  end
end

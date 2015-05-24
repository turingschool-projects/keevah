class LoanRequestCategory < ActiveRecord::Base
  belongs_to :category
  belongs_to :loan_request

  after_save :update_most_recent_category

  def update_most_recent_category
    self.class.last.category.touch
  end
end

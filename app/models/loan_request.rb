class LoanRequest < ActiveRecord::Base
  belongs_to :user
  default_scope { order('updated_at DESC') }
  scope :status, -> (status) { where status: status }

  before_destroy :touch_categories
  has_many :loan_request_categories, dependent: :destroy
  has_many :categories, through: :loan_request_categories
  has_many :loans

  validate :ensure_request_date_not_in_past
  validate :ensure_begin_date_is_after_request_date
  validate :ensure_end_date_is_after_begin_date

  validates :user_id, presence: true
  validates :title, presence: true
  validates :blurb, presence: true
  validates :description, presence: true
  validates :borrowing_amount, presence: true,
                               numericality: { only_integer: true }
  validates :amount_funded, presence: true
  validates :requested_by_date, presence: true
  validates :payments_begin_date, presence: true
  validates :payments_end_date, presence: true
  validates :status, presence: true

  after_create :touch_categories
  #after_update :touch_categories

  def touch_categories
    categories.each(&:touch)
  end

  def category_names
    categories.map(&:name)
  end

  def is_fulfilled?
    amount_funded == borrowing_amount
  end

  def mark_as_funded!
    self.status = 'closed'
    save!
  end

  def loan_term
    ((payments_end_date - payments_begin_date) / SECONDS_IN_MONTH).round
  end

  def repayment_rate
    borrowing_amount / loan_term
  end

  def remaining_amount
    borrowing_amount - amount_funded
  end

  private

  SECONDS_IN_MONTH =  2_592_000

  def ensure_request_date_not_in_past
    if request_date_is_in_past?
      errors.add(:requested_by_date, 'cannot be in the past')
    end
  end

  def request_date_is_in_past?
    requested_by_date.present? && requested_by_date < Date.today
  end

  def ensure_begin_date_is_after_request_date
    if date_less_than_one_month_from_request_date
      errors.add(:payments_begin_date, 'must be at least one month from today')
    end
  end

  def ensure_end_date_is_after_begin_date
    if date_less_than_three_months_from_request_date
      errors.add(:payments_end_date, 'must be at least three months from today')
    end
  end

  def date_less_than_one_month_from_request_date
    payments_begin_date.present? &&
      payments_begin_date < requested_by_date.months_since(1)
  end

  def date_less_than_three_months_from_request_date
    payments_end_date.present? &&
      payments_end_date < requested_by_date.months_since(3)
  end
end

class Category < ActiveRecord::Base
  has_many :loan_request_categories, dependent: :destroy
  has_many :loan_requests, through: :loan_request_categories
  default_scope { order("updated_at DESC") }

  RESERVED_NAMES = %w(users cart loans loan_requests login logout tenants new
                      categories)

  validate :name_cannot_be_a_route
  validates :name, presence: true
  validates :description, presence: true
  validates :slug, uniqueness: true

  before_save :generate_slug

  def generate_slug
    self.slug = name.parameterize
  end

  def name_cannot_be_a_route
    if name.present? && RESERVED_NAMES.include?(name.parameterize)
      errors.add(:name, 'has already been taken')
    end
  end

  def loan_requests_count
    if !REDIS.get("loan_requests_count/#{cache_key}")
      REDIS.set("loan_requests_count/#{cache_key}", LoanRequestCategory.where("category_id = ?", self).count)
      REDIS.get("loan_requests_count/#{cache_key}").to_i
    else
      REDIS.get("loan_requests_count/#{cache_key}").to_i
    end
  end
end

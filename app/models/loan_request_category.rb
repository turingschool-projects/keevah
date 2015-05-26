class LoanRequestCategory < ActiveRecord::Base
  belongs_to :category
  belongs_to :loan_request

  after_save :clear_matching_caches

  def clear_matching_caches
    REDIS.keys.each do |key|
      if key.match(/(keevah:loan_request_count\/categories\/).*/)
        REDIS.del(key)
      end
    end
  end
end

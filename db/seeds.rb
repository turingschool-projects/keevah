class Seed
  def call
    generate_tenants(200000)
    generate_users(30000)
    generate_categories(15)
    generate_loan_requests(500000)
    generate_loans(50000)
  end

  def generate_users(quantity)
    puts "Creating #{quantity} users"

    quantity.times do |n|
      first_name = Faker::Name.name
      username = Faker::Internet.user_name
      email = Faker::Internet.safe_email(first_name)
      password = "password"
      tenant_id = rand(1..@tenant_count)

      User.create!(first_name: first_name,
                   username: username,
                   email: n.to_s + email,
                   password: password,
                   tenant_id: tenant_id
                  )
    end

    @user_count = User.count
    puts "#{quantity} users created"
  end

  def generate_tenants(quantity)
    puts "Creating #{quantity} tenants"

    quantity.times do |n|
      name = Faker::Name.name # unique
      Tenant.create!(name: n.to_s + name)
    end

    @tenant_count = Tenant.count
    puts "Tenants generated"
  end

  def generate_categories(quantity)
    puts "Creating #{quantity} categories"

    quantity.times do |n|
      name = Faker::Commerce.department(1, true) + n.to_s
      description = Faker::Commerce.product_name

      Category.create!(name: name, description: description)
    end

    @category_count = Category.count
    puts "Categories generated"
  end

  def generate_loan_requests(quantity)
    puts "Creating #{quantity} loan requests"

    quantity.times do
      user_id = rand(1..@user_count)
      title = Faker::Commerce.product_name
      blurb = Faker::Internet.domain_word
      description = Faker::Hacker.say_something_smart
      requested_by_date = DateTime.now
      payments_begin_date = rand(41..61).days.from_now
      payments_end_date = rand(100..182).days.from_now
      borrowing_amount = rand(50..1000)
      amount_funded = rand(1..49)

      loan_request = LoanRequest.create!(user_id: user_id,
                          title: title,
                          blurb: blurb,
                          description: description,
                          requested_by_date: requested_by_date,
                          payments_begin_date: payments_begin_date,
                          payments_end_date: payments_end_date,
                          borrowing_amount: borrowing_amount,
                          amount_funded: amount_funded
                         )
      loan_request.categories << Category.find_by(id: rand(1..@category_count))
    end

    @loan_request_count = LoanRequest.count
    puts "LoanRequests generated"
  end

  def generate_loans(quantity)
    puts "Creating #{quantity} loans"

    quantity.times do
      user_id = rand(1..@user_count)
      loan_request_id = rand(1..@loan_request_count)
      amount = rand(50..1000)

      Loan.create!(user_id: user_id,
                   loan_request_id: loan_request_id,
                   amount: amount
                  )
    end

    puts "Loans generated"
  end

  def self.call
    new.call
  end
end

Seed.call

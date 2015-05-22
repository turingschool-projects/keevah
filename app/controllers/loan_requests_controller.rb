class LoanRequestsController < ApplicationController
  before_action :set_loan_request, only: [:show, :edit, :update]
  load_and_authorize_resource

  def index
    @loan_requests = LoanRequest.paginate(page: params[:page], per_page: 30)
    @loan_requests = @loan_requests.status(params[:status]) if params[:status].present?
  end

  def new
    @loan_request = LoanRequest.new
  end

  def create
    @loan_request = LoanRequest.new(loan_request_params)
    @loan_request.user_id = current_user.id
    if @loan_request.save
      @loan_request.categories += categories
      redirect_to tenant_path(current_user.tenant.slug), notice: 'Loan Request created.'
    else
      render :new
    end
  end

  def update
  end

  def show
    @loan_request = LoanRequest.find_by("id = ?", params[:id])
  end

  def edit
    unless current_user.id == @loan_request.user_id
      redirect_to root_path, notice: 'You are not the owner of this loan'
    end
  end

  private

  def loan_request_params
    params.require(:loan_request).permit(:user_id, :title, :description, :blurb,
                                         :borrowing_amount, :amount_funded,
                                         :requested_by_date,
                                         :payments_begin_date,
                                         :payments_end_date, :image
                                        )
  end

  def categories
    Category.where(id: params[:loan_request][:category_ids].reject(&:blank?))
  end

  def set_loan_request
    @loan_requests = LoanRequest.find_by("id = ?", params[:id])
  end
end

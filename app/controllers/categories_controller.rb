class CategoriesController < ApplicationController
  load_and_authorize_resource

  before_action :set_category, only: [:show, :edit, :index]

  def index
  end

  def show
    @loan_requests = @category.loan_requests.paginate(page: params[:page], per_page: 6)
    fresh_when(@category)
  end

  private

  def category_params
    params.require(:category).permit(:name, :slug, :description)
  end

  def set_category
    @category = Category.find_by("slug = ?", params[:slug])
  end
end

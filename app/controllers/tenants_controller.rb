class TenantsController < ApplicationController
  load_and_authorize_resource

  before_action :set_tenant, only: [:show, :edit, :update, :destroy]
  before_action :current_user, only: [:show, :edit, :update]

  def index
  end

  def new
  end

  def create
    if @tenant.save
      session[:tenant_id] = @tenant.id
      current_user.update_attribute(:tenant_id, @tenant.id)
      redirect_to tenant_path(@tenant.slug), notice: 'Thanks for creating your store.'
    else
      render :new
    end
  end

  def show
    @tenant = Tenant.find_by("slug = ?", params[:slug])
  end

  def edit
    unless current_user.tenant_id == @tenant.id
      redirect_to root_path, notice: 'You are not the owner of this store'
    end
  end

  def update
    respond_to do |format|
      if current_user.tenant.update(tenant_params)
        format.html { redirect_to tenant_path(current_user.tenant.slug), notice: 'Your store has been updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def tenant_params
    params.require(:tenant).permit(:name, :slug, :description)
  end

  def set_tenant
    @tenant = Tenant.find_by("slug = ?", params[:slug])
  end
end

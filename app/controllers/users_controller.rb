class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    if current_user.admin?
      render json: User.all
    elsif current_user.owner?
      render json: User.where(id: current_user.subscriptions_as_owner.select(:tenant_id))
    elsif current_user.tenant?
      render json: [current_user]
    else
      render json: [], status: :forbidden
    end
  end

  def show
    authorize_user!(@user)
    render json: @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user!(user)
    return if current_user.admin?
    return if current_user == user
    return if current_user.owner? && current_user.subscriptions_as_owner.exists?(tenant_id: user.id)

    render json: { error: "Not authorized" }, status: :forbidden
  end
end

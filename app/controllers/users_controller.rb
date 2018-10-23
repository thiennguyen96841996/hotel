class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.order_user.page(params[:page])
                 .per Settings.per_page
  end

  def show; end

  def update
    respond_to do |format|
      case params[:type]
      when "block"
        @user&.blocked!
        format.js{render "users/unblock"}
      when "unblock"
        @user&.active!
        format.js{render "users/block"}
      when "mod"
        @user&.mod!
        format.js{render "users/degrade"}
      when "member"
        @user&.member!
        format.js{render "users/upgrade"}
      else
        format.html
      end
    end
  end
end

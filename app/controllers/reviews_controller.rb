class ReviewsController < ApplicationController
  load_and_authorize_resource
  before_action :find_review, only: [:edit, :update, :destroy]
  before_action :find_motel, only: [:new, :create, :edit, :update, :destroy, :show]
  before_action :authenticate_user!, only: [:new, :like]
  def new
    @review = Review.new
  end

  def create
    @review = Review.new review_params

    if @review.save
      redirect_to motel_path(@motel)
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @review.update_attributes review_params
      flash[:success] = t "flash.update_success"
      redirect_to motel_path(@motel)
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    flash[:success] = t "flash.delete_success"
    redirect_to motel_path(@motel)
  end

  def like
    respond_to do |format|
      case params[:type]
      when "like"
        @review = Review.find_by id: params[:review_id]
        Like.create user_id: current_user.id, review_id: params[:review_id]
        format.js{render "reviews/unlike"}
      when "unlike"
        @review = Review.find_by id: params[:review_id]
        like = @review.likes.where(user_id: current_user.id)[0]
        like.destroy
        format.js{render "reviews/like"}
      else
        format.html
      end
    end
  end

  private

  def find_review
    @review = Review.find_by id: params[:id]

    return if @review
    flash[:danger] = t "flash.no_record"
    redirect_to root_url
  end

  def find_motel
    @motel = Motel.find_by id: params[:motel_id]
  end

  def review_params
    params.require(:review).permit :title, :content, :rate, :motel_id, :user_id, {images: []}
  end

end

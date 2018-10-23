class MotelsController < ApplicationController
  load_and_authorize_resource
  before_action :find_motel, only: [:show, :edit, :update, :destroy]

  def index
    @motels = Motel.page(params[:page])
                   .per Settings.per_page
  end

  def new
    @motel = Motel.new
  end

  def create
    @motel = Motel.new motel_params
    if @motel.save
      redirect_to motel_path(@motel)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @motel.update_attributes motel_params
      flash[:success] = t "flash.update_success"
      redirect_to motel_path(@motel)
    else
      render :edit
    end
  end

  def destroy
    @motel.destroy
    flash[:success] = t "flash.delete_success"
    redirect_to root_path
  end

  private

  def motel_params
    params.require(:motel).permit :name, :description, :address, :phone, :level, {images: []},
      hotel_equips_attributes: [:id, :_destroy, :price, :equipment_id],
      hotel_rooms_attributes: [:id, :_destroy, :price, :room_id]
  end

  def find_motel
    @motel = Motel.find_by id: params[:id]

    return if @motel
    flash[:danger] = t "flash.no_record"
    redirect_to root_url
  end
end

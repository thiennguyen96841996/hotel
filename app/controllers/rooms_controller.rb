class RoomsController < ApplicationController
  load_and_authorize_resource
  before_action :find_room, only: [:edit, :update, :destroy]

  def index
    @rooms = Room.page(params[:page])
                 .per Settings.per_page
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new room_params

    if @room.save
      redirect_to rooms_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @room.update_attributes room_params
      flash[:success] = t "flash.update_success"
      redirect_to rooms_path
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    flash[:success] = t "flash.delete_success"
    redirect_to rooms_path
  end

  private

  def room_params
    params.require(:room).permit :room_type, :bed_numbers, :guest_no
  end

  def find_room
    @room = Room.find_by id: params[:id]

    return if @room
    flash[:danger] = t "flash.no_record"
    redirect_to root_url
  end

end

class EquipmentsController < ApplicationController
  load_and_authorize_resource
  before_action :find_equipment, only: [:edit, :update, :destroy]

  def index
    @equipments = Equipment.page(params[:page])
                           .per Settings.per_page
  end

  def new
    @equipment = Equipment.new
  end

  def create
    @equipment = Equipment.new equipment_params

    if @equipment.save
      redirect_to equipments_path
    else
      render :new
    end
  end

  def show
  end

  def edit; end

  def update
    if @equipment.update_attributes equipment_params
      flash[:success] = t "flash.update_success"
      redirect_to equipments_path
    else
      render :edit
    end
  end

  def destroy
    @equipment.destroy
    flash[:success] = t "flash.delete_success"
    redirect_to equipments_path
  end

  private

  def find_equipment
    @equipment = Equipment.find_by id: params[:id]

    return if @equipment
    flash[:danger] = t "flash.no_record"
    redirect_to root_url
  end

  def equipment_params
    params.require(:equipment).permit :name
  end

end

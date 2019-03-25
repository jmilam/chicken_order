class FarmController < ApplicationController
  def index; end

  def edit
    @farm = Farm.find(params[:id])
  end

  def update
    @farm = Farm.find(params[:id])

    if @farm.update(farm_params)
      flash[:notice] = 'Farm information updated.'
    else
      flash[:alert] = "There was an error when updating farm: #{@farm.errors.messages}"
    end
    redirect_to edit_farm_path(@farm.id)
  end

  private

  def farm_params
    params.require(:farm).permit(:name, :address, :city, :state, :zipcode, :total_eggs,
                                 :phone_number, :egg_cost, :chicken_count)
  end
end

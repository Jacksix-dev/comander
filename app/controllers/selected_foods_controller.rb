class SelectedFoodsController < ApplicationController

  def create
    @order = Order.find(params[:order_id])
    @selected_food = SelectedFood.new(selected_food_params)
    @selected_food.order = @order
    @selected_food.save
    redirect_to table_path(@order.table)
  end

  def destroy
    @selected_food = SelectedFood.find(params[:id])
    @selected_food.destroy
    redirect_to table_path(@selected_food.order.table)
  end

  private

  def selected_food_params
    params.require(:selected_food).permit(:food_id)
  end
end

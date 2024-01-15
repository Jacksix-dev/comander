class SelectedFoodsController < ApplicationController
  def create
    @order = Order.find(params[:order_id])
    foods = params[:foods]
      foods.each do |food|
        SelectedFood.create(order: @order, food_id: food)
      end
    redirect_to table_path(@order.table)
  end

  def destroy
    @selected_food = SelectedFood.find(params[:id])
    @selected_food.destroy
    redirect_to table_path(@selected_food.order.table)
  end

  private

  #def selected_food_params
    #params.require(:selected_food).permit(:food_id, :order_id)
  #end
end

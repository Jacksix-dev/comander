class SelectedFoodsController < ApplicationController
  def create
    @order = Order.find(params[:order_id])
    foods = params[:foods]
    mensaje = "You need to add a food to complete the action"
    if !foods.nil?
      foods.each do |food|
        selected_food = SelectedFood.new(order: @order, food_id: food)
        if selected_food.save
          mensaje = "The food was added successfully"
        else
          mensaje = "There was an error, please add something"
        end
      end
    end
    redirect_to table_path(@order.table), notice: mensaje
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

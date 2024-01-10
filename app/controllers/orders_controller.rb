class OrdersController < ApplicationController
  def new
    @table = Table.find(params[:table_id])
    @order = Order.new
    @foods = Food.all
    @waiter = Waiter.all
    @kitchen = Kitchen.first
  end

  def create
    @table = Table.find(params[:table_id])
    @order = Order.create(order_params)
    @order.table_id = @table.id
    if @order.save
      redirect_to tables_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def order_params

    params.require(:order).permit(:waiter_id, selected_food_ids: [])

  end
end

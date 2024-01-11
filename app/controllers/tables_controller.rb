class TablesController < ApplicationController
  before_action :set_table, only:[:show, :edit , :update, :close, :checkout]
  helper_method :table_color_class
  def index
    @tables = Table.all.order(:id)
  end

  def show
  end

  def edit

  end

  def update
  # Assuming @table is set in a before_action
  if @table.update(table_params)
    # Successfully updated
    redirect_to @table
  else
    # Validation failed, render the edit form again with errors
    render :edit
  end
  end

  def checkout
    @orders = @table.orders.includes(:selected_foods).order(created_at: :desc)
    @total_prices = @orders.map { |order| order.selected_foods.joins(:food).sum('foods.price') }
  end

  def close
    orders = @table.orders
    orders.each do |order|
      order.selected_foods.destroy_all
    end
    orders.destroy_all
    @table.update!(customer_number: 0, status: 'empty')
    redirect_to tables_path, notice: 'Table closed successfully.'
  end

  def user_tables
    @tables = Table.all.select { |table| table.user_id == current_user.id }
  end

  private

  def table_params
    params.require(:table).permit(:customer_number, :status)
  end

  def set_table
    @table = Table.find(params[:id])
  end

  def table_color_class(table)
    case table.status
    when 'empty'
      'table-empty'
    when 'reserved'
      'table-reserved'
    when 'full'
      'table-full'
    when 'checkout'
      'table-checkout'
    else
      'table-default' # Default color if status is not recognized
    end
  end
end

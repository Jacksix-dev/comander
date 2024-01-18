class TablesController < ApplicationController
  before_action :set_table, only:[:show, :edit , :update, :close, :checkout, :destroy]
  helper_method :table_color_class
  def index
    @tables = Table.all.order(:id)
  end

  def all_orders
    @table = Table.find(params[:id])
    @orders = @table.orders
  end
  def new
    @table = Table.new
  end

  def create
    @table = Table.new(table_params)
    @table.user_id = current_user.id
    if @table.save

      redirect_to tables_path, notice: 'Table was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @table.delete
    redirect_to tables_path, notice: 'Table was deleted.'
  end

  def show
    @foods = Food.where(type: 'dish')
    @drinks = Food.where(type: 'drink')
  end

  def edit
  end

  def update
    @table.update!(table_params)
    redirect_to @table, notice: "The table was updated successfully"
  end

  def checkout
    @orders = @table.orders.where(status: ["pending", "done"]).includes(:selected_foods).order(created_at: :desc)
    @total_prices = @orders.map { |order| order.selected_foods.joins(:food).sum('foods.price') }
  end

  def close
    orders = @table.orders
    orders.each do |order|
      order.status = "counter"
      order.save
    end
    @table.update!(customer_number: 0, status: 'empty')
    redirect_to tables_path, notice: 'Table closed successfully.'
  end

  def user_tables
    @tables = Table.all.select { |table| table.user_id == current_user.id }
  end

  private

  def table_params
    params.require(:table).permit(:customer_number, :status, :number)
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

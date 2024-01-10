class TablesController < ApplicationController
  before_action :set_table, only:[:show, :edit , :update, :close]
  helper_method :table_color_class
  def index
    @tables = Table.all.order(:id)
  end

  def show
  end

  def edit
  end

  def update
    @table.update!(table_params)
    redirect_to @table
  end

  def checkout
  end

  def close
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
    when 'available'
      'table-available'
    when 'checkout'
      'table-checkout'
    else
      'table-default' # Default color if status is not recognized
    end
  end
end

class Admin::TablesController < ApplicationController
  before_action :load_table, only: %i(destroy edit show update)

  def index
    @search = Table.search params[:q]
    @search.sorts  = "created_at desc" if @search.sorts.empty?
    @tables = @search.result.page(params[:page]).per_page 5
  end

  def show

  end

  def create
    @table = Table.new table_params
    if @table.save
      flash[:success] = "Bạn đả tạo thành công"
      redirect_to admin_tables_path
    else

      flash[:danger] = "Bạn đả tạo không thành công"
      render :new
    end
  end

  def new
    @table = Table.new
  end

  def destroy
    if @table.destroy
      flash[:success] = "Chúc mừng bạn đả xóa thành công."
    else
      flash[:danger] = "Xin lỗi ! Bạn đã xóa không thành công, xin thử lại."
    end
    redirect_to admin_tables_path
  end

  def edit

  end

  def update
    if @table.update_attributes table_params
      flash[:success] = "Chúc mừng bạn đả cập nhật thành công."
      redirect_to admin_table_path
    else

      flash[:danger] = "Xin lỗi ! Bạn đã cập nhật không thành công."
      render :edit
    end
  end

  private
  def table_params
    current_params = params.require(:table).permit(:name)
  end

  def load_table
    @table = Table.find_by id: params[:id]
  end
end

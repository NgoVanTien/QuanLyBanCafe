class Admin::LocationsController < ApplicationController
  before_action :load_location, only: %i(destroy edit show update)

  def index

    @search = Location.search params[:q]
    @search.sorts  = "created_at desc" if @search.sorts.empty?
    @locations = @search.result.page(params[:page]).per_page 10

  end

  def show
    
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new location_params
    if @location.save
      flash[:success] = "Bạn đả tạo thành công"
      redirect_to admin_locations_path
    else

      flash[:danger] = "Bạn đả tạo không thành công"
      render :new
    end
  end

  def destroy
    if @location.destroy
      flash[:success] = "Chúc mừng bạn đả xóa thành công."
    else
      flash[:danger] = "Xin lỗi ! Bạn đã xóa không thành công, xin thử lại."
    end
    redirect_to admin_locations_path
  end

  def update
    if @location.update_attributes location_params
      flash[:success] = "Chúc mừng bạn đả cập nhật thành công."
      redirect_to admin_locations_path
    else

      flash[:danger] = "Xin lỗi ! Bạn đã cập nhật không thành công."
      render :edit
    end
  end

  def edit

  end

  private

  def location_params
    current_params = params.require(:location).permit(:name, :description, :row, :column)
  end

  def load_location
    @location = Location.find_by id: params[:id]
  end

end

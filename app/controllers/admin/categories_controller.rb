class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_category, only: [:show, :destroy, :edit, :update]

  def index
    @categories = Category.page(params[:page])
      .per_page 10
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = "Tao thanh cong"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "devise.registrations.updated"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = "xoa thanh cong"
    else
      flash[:warning] = "xoa khong thanh cong"
    end
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit :code, :name, :description
  end

  def load_category
    @category = Category.find_by id: params[:id]
  end
end

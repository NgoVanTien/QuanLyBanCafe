class Admin::Ajax::AreaLocationsController < ApplicationController

  def index
    params_action_name = params[:action_name]
    params_action_type = params[:action_type]
    params_location_id = params[:location_id]

    load_location params_location_id
    row = @location.row
    column = @location.column
    if params_action_type == "insert" && params_action_name == "column"
      binding.pry
      @location.update!(column: (column.to_i + 1))
    elsif params_action_type == "delete" && params_action_name == "column"
      binding.pry
      @location.update!(column: (column.to_i - 1))
    elsif params_action_type == "insert" && params_action_name == "row"
      binding.pry
      @location.update!(row: (row.to_i + 1))
    else params_action_type == "delete" && params_action_name == "row"
      binding.pry
      @location.update!(row: (row.to_i - 1))
    end
  end

  private

  def load_location id
    @location = Location.find_by_id id.to_i
  end

  def method_name

  end
end

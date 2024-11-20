class ToolsController < ApplicationController
  def index
    @tools = Tool.all
    @markers = @tools.geocoded.map do |tool|
      {
        lat: tool.latitude,
        lng: tool.longitude
      }
    end
  end

  def show
    @tool = Tool.find(params[:id])
  end

  def new
    @tool = Tool.new
  end

  def create
    @tool = Tool.new(tool_params)
    @tool.user = current_user

    if @tool.save!
      redirect_to tool_path(@tool)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def tool_params
    params.require(:tool).permit(
      :name,
      :description,
      :price,
      :address,
      :category,
      :available_from,
      :available_until,
      images: []
    )
  end
end

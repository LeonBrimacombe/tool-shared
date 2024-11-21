class ToolsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home index show]

  def home
    @tools = Tool.order("RANDOM()").take(10)
  end

  def index
    @tools = Tool.all
    # @tools = Tool.geocoded
    @markers = @tools.geocoded.map do |tool|
      {
        lat: tool.latitude,
        lng: tool.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {tool: tool}),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def listing
    @tools = current_user.tools
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

  def destroy
    @tool = Tool.find(params[:id])
    @tool.destroy
    flash[:notice] = "Listing deleted successfully."
    redirect_to user_listing_path
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

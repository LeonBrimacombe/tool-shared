class ToolsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home index show]

  def home
    @tools = Tool.order("RANDOM()").take(10)

    if params[:query].present?
      @tools = @tools.where("name ILIKE ?", "%#{params[:query]}%")
    end
  end

  def index
    @tools = Tool.all

    if params[:query].present?
      @tools = @tools.where("name ILIKE ?", "%#{params[:query]}%")
    end

    @markers = @tools.geocoded.map do |tool|
      {
        lat: tool.latitude,
        lng: tool.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { tool: tool }),
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
      flash[:notice] = "Listing successful :)"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @tool = Tool.find(params[:id])
  end

  def update
    @tool = Tool.find(params[:id])

    if @tool.update(tool_params)
      redirect_to tool_path(@tool)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @tool = Tool.find(params[:id])

    if @tool.destroy
      flash[:notice] = "Listing deleted"
      redirect_to user_listing_path(current_user)
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

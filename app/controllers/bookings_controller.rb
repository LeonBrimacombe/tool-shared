class BookingsController < ApplicationController
  def index
    @bookings = current_user.bookings
    @tools = Tool.limit(2)
    @markers = @tools.geocoded.map do |tool|
      {
        lat: tool.latitude,
        lng: tool.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { tool: tool }),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @tool = @booking.tool
    @markers = [
      {
        lat: @tool.latitude,
        lng: @tool.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { tool: @tool }),
        marker_html: render_to_string(partial: "marker")
      }
    ]
  end

  def new
    @booking = Booking.new
    @tool = Tool.find(params[:tool_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @tool = Tool.find(params[:tool_id])
    @booking.tool = @tool
    @booking.user = current_user
    if @booking.save
      redirect_to tool_booking_path(@booking.tool_id, @booking)
      flash[:notice] = "Booking successful :)"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @booking = Booking.find(params[:id])
    @tool = Tool.find(params[:tool_id])
  end

  def update
    @tool = Tool.find(params[:tool_id])
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)
    redirect_to tool_booking_path(@tool, @booking)
  end

  def destroy
    @booking = Booking.find(params[:id])
    if @booking.destroy
      flash[:notice] = "Booking cancelled"
      redirect_to bookings_path
    else
      render status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :price)
  end
end

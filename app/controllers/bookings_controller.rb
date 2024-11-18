class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
    @tool = Tool.find(params[:tool_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @tool = Tool.find(params[:tool_id])
    @booking.tool = @tool
    if @booking.save!
      redirect_to new_tool_booking(:tool_id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)
    redirect_to
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to
  end

  private

  def booking_params
    param.require(:booking).permit(:start_date, :end_date, :price)
  end
end

module ApplicationHelper
  def format_price(price_in_pence)
    # Ensure the input is a string and convert to an integer
    amount_in_pence = price_in_pence.to_i

    # Convert pence to pounds (divide by 100) and format with two decimal places
    "£#{'%.2f' % (amount_in_pence / 100.0)}"
  end

  def booking_price(booking)
    # Parse the dates to ensure they are Date objects
    start_date = Date.parse(booking.start_date.to_s)
    end_date = Date.parse(booking.end_date.to_s)

    # Calculate the number of days (inclusive of both start and end date)
    total_days = (end_date - start_date).to_i + 1

    # Calculate the total price
    total_price = booking.tool.price.to_i * total_days

    # Format the price to include currency
    "£#{'%.2f' % (total_price / 100.0)}"
  end
end

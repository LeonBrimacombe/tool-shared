module ApplicationHelper
  def format_price(price_in_pence)
    # Ensure the input is a string and convert to an integer
    amount_in_pence = price_in_pence.to_i

    # Convert pence to pounds (divide by 100) and format with two decimal places
    "£#{'%.2f' % (amount_in_pence / 100.0)}"
  end
end

class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    today = Date.today
    @all_dates = (today.beginning_of_month..today.end_of_month).to_a

    # Generate the data with 0s for missing dates
    @sales_data = generate_filled_data(OrderItem.group_by_day('order_items.created_at').sum(:quantity), @all_dates)

    # Weekly and monthly sales follow a similar pattern
    @weekly_sales_data = generate_filled_data(OrderItem.group("strftime('%Y-%W', created_at)").sum(:quantity), @all_dates)
    @monthly_sales_data = generate_filled_data(OrderItem.group("strftime('%Y-%m', created_at)").sum(:quantity), @all_dates)

    # For revenue data (same concept as sales)
    @revenue_data = generate_filled_data(OrderItem.group_by_day('order_items.created_at').sum("quantity * price"), @all_dates)
    @weekly_revenue_data = generate_filled_data(OrderItem.group("strftime('%Y-%W', created_at)").sum("quantity * price"), @all_dates)
    @monthly_revenue_data = generate_filled_data(OrderItem.group("strftime('%Y-%m', created_at)").sum("quantity * price"), @all_dates)
   end

  def seller_dashboard
    @seller_products = current_user.products.includes(:order_items)

    # Total Sales per Day, Week, Month
    @sales_data = @seller_products.joins(:order_items)
                                  .group_by_day('order_items.created_at')
                                  .sum('order_items.quantity')

    # For weekly sales using strftime for SQLite
    @weekly_sales_data = @seller_products.joins(:order_items)
                                         .group("strftime('%Y-%W', order_items.created_at)")
                                         .sum('order_items.quantity')

    # For monthly sales using strftime for SQLite
    @monthly_sales_data = @seller_products.joins(:order_items)
                                          .group("strftime('%Y-%m', order_items.created_at)")
                                          .sum('order_items.quantity')

    # ✅ Total Revenue per Day, Week, Month
    @revenue_data = @seller_products.joins(:order_items)
                                    .group_by_day('order_items.created_at')
                                    .sum('order_items.quantity * order_items.price')

    # Weekly revenue using strftime
    @weekly_revenue_data = @seller_products.joins(:order_items)
                                           .group("strftime('%Y-%W', order_items.created_at)")
                                           .sum('order_items.quantity * order_items.price')

    # Monthly revenue using strftime
    @monthly_revenue_data = @seller_products.joins(:order_items)
                                            .group("strftime('%Y-%m', order_items.created_at)")
                                            .sum('order_items.quantity * order_items.price')
  end

  def panel
    # Fetch the total number of buyers and sellers
    @total_buyers = User.where(role: 'buyer').count
    @total_sellers = User.where(role: 'seller').count
  
    # Sales and Revenue Data for all Sellers
  
    # Total Sales per Day, Week, Month for all sellers
    @sales_data = OrderItem.joins(:product)
                           .group_by_day('order_items.created_at')
                           .sum('order_items.quantity')
  
    # Weekly Sales for all sellers
    @weekly_sales_data = OrderItem.joins(:product)
                                  .group("strftime('%Y-%W', order_items.created_at)")
                                  .sum('order_items.quantity')
  
    # Monthly Sales for all sellers
    @monthly_sales_data = OrderItem.joins(:product)
                                   .group("strftime('%Y-%m', order_items.created_at)")
                                   .sum('order_items.quantity')
  
    # Total Revenue per Day, Week, Month for all sellers
    @revenue_data = OrderItem.joins(:product)
                             .group_by_day('order_items.created_at')
                             .sum('order_items.quantity * order_items.price')
  
    # Weekly Revenue for all sellers
    @weekly_revenue_data = OrderItem.joins(:product)
                                    .group("strftime('%Y-%W', order_items.created_at)")
                                    .sum('order_items.quantity * order_items.price')
  
    # Monthly Revenue for all sellers
    @monthly_revenue_data = OrderItem.joins(:product)
                                     .group("strftime('%Y-%m', order_items.created_at)")
                                     .sum('order_items.quantity * order_items.price')
  end
 def owner_dashboard
    @total_buyers = Buyer.count
    @total_sellers = Seller.count
    @buyers = Buyer.all  # Fetch all buyers
    @sellers = Seller.all  # Fetch all sellers
  end

  private

  # Helper function to fill missing data with zeros for missing dates
  def generate_filled_data(actual_data, all_dates)
    data = {}
    actual_data.each do |date, quantity|
      data[date.to_s] = quantity
    end
    # Fill missing dates with zero
    all_dates.each do |date|
      data[date.to_s] ||= 0
    end
    # Sort by date to ensure the chart is ordered
    data = data.sort.to_h
    data
  end
end

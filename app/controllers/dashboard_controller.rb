class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    today = Date.today
    @all_dates = (today.beginning_of_month..today.end_of_month).to_a

    @sales_data = generate_filled_data(OrderItem.group_by_day('order_items.created_at').sum(:quantity), @all_dates)

    @weekly_sales_data = generate_filled_data(OrderItem.group("strftime('%Y-%W', created_at)").sum(:quantity), @all_dates)
    @monthly_sales_data = generate_filled_data(OrderItem.group("strftime('%Y-%m', created_at)").sum(:quantity), @all_dates)

    @revenue_data = generate_filled_data(OrderItem.group_by_day('order_items.created_at').sum("quantity * price"), @all_dates)
    @weekly_revenue_data = generate_filled_data(OrderItem.group("strftime('%Y-%W', created_at)").sum("quantity * price"), @all_dates)
    @monthly_revenue_data = generate_filled_data(OrderItem.group("strftime('%Y-%m', created_at)").sum("quantity * price"), @all_dates)
   end

  def seller_dashboard
    @seller_products = current_user.products.includes(:order_items)

    @sales_data = @seller_products.joins(:order_items)
                                  .group_by_day('order_items.created_at')
                                  .sum('order_items.quantity')

    @weekly_sales_data = @seller_products.joins(:order_items)
                                         .group("strftime('%Y-%W', order_items.created_at)")
                                         .sum('order_items.quantity')

    @monthly_sales_data = @seller_products.joins(:order_items)
                                          .group("strftime('%Y-%m', order_items.created_at)")
                                          .sum('order_items.quantity')

    @revenue_data = @seller_products.joins(:order_items)
                                    .group_by_day('order_items.created_at')
                                    .sum('order_items.quantity * order_items.price')

    @weekly_revenue_data = @seller_products.joins(:order_items)
                                           .group("strftime('%Y-%W', order_items.created_at)")
                                           .sum('order_items.quantity * order_items.price')

    @monthly_revenue_data = @seller_products.joins(:order_items)
                                            .group("strftime('%Y-%m', order_items.created_at)")
                                            .sum('order_items.quantity * order_items.price')
  end

  def panel
    @total_buyers = User.where(role: 'buyer').count
    @total_sellers = User.where(role: 'seller').count
  
  
    @sales_data = OrderItem.joins(:product)
                           .group_by_day('order_items.created_at')
                           .sum('order_items.quantity')
  
    @weekly_sales_data = OrderItem.joins(:product)
                                  .group("strftime('%Y-%W', order_items.created_at)")
                                  .sum('order_items.quantity')
  
    @monthly_sales_data = OrderItem.joins(:product)
                                   .group("strftime('%Y-%m', order_items.created_at)")
                                   .sum('order_items.quantity')
  
    @revenue_data = OrderItem.joins(:product)
                             .group_by_day('order_items.created_at')
                             .sum('order_items.quantity * order_items.price')
  
    @weekly_revenue_data = OrderItem.joins(:product)
                                    .group("strftime('%Y-%W', order_items.created_at)")
                                    .sum('order_items.quantity * order_items.price')
  
    @monthly_revenue_data = OrderItem.joins(:product)
                                     .group("strftime('%Y-%m', order_items.created_at)")
                                     .sum('order_items.quantity * order_items.price')
  end
  
#  def owner_dashboard
#     @total_buyers = Buyer.count
#     @total_sellers = Seller.count
#     @buyers = Buyer.all  
#     @sellers = Seller.all  
#   end

  private

  def generate_filled_data(actual_data, all_dates)
    data = {}
    actual_data.each do |date, quantity|
      data[date.to_s] = quantity
    end
    all_dates.each do |date|
      data[date.to_s] ||= 0
    end
    data = data.sort.to_h
    data
  end
end

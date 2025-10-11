class OrdersController < Frack::BaseController
  def index
    unless current_user
      request.session['flash'] = 'You must sign in to continue'
      return [[], 302, { 'location' => '/' }]
    end

    @orders = Order.where(user_id: current_user.id)
    render 'orders/index'
  end

  def new
    render 'orders/new'
  end

  def create
    user_id = current_user&.id
    order_date = request.params['order_date']
    required_date = request.params['required_date']

    order_params = {
      'user_id' => user_id,
      'status' => 0,
      'order_date' => order_date,
      'required_date' => required_date
    }

    new_order = Order.new(order_params)
    if new_order.save
      request.session['flash'] = 'Order created'
      [[], 302, { 'location' => '/orders' }]
    else
      request.session['flash'] = 'Create failed'
      [[], 302, { 'location' => '/orders/new' }]
    end
  end
end

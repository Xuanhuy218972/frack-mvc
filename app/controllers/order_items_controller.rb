class Order_itemsController < Frack::BaseController
  def index
    unless current_user
      request.session['flash'] = 'You must sign in to continue'
      return [[], 302, { 'location' => '/' }]
    end

    @order_items = OrderItem.all
    render 'order_items/index'
  end

  def new
    render 'order_items/new'
  end

  def create
    order_id = request.params['order_id']
    item_id = request.params['item_id']
    product_id = request.params['product_id']
    quantity = request.params['quantity']
    list_price = request.params['list_price']
    discount = request.params['discount']

    order_item_params = {
      'order_id' => order_id,
      'item_id' => item_id,
      'product_id' => product_id,
      'quantity' => quantity,
      'list_price' => list_price,
      'discount' => discount
    }

    new_order_item = OrderItem.new(order_item_params)
    if new_order_item.save
      request.session['flash'] = 'Order item created'
      [[], 302, { 'location' => '/order_items' }]
    else
      request.session['flash'] = 'Create failed'
      [[], 302, { 'location' => '/order_items/new' }]
    end
  end
end

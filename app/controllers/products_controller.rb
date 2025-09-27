class ProductsController < Frack::BaseController
  def index
    unless current_user
      request.session['flash'] = 'You must sign in to continue'
      return [[], 302, { 'location' => '/' }]
    end

    @products = Product.all
    render 'products/index'
  end

  def new
    render 'products/new'
  end

  def create
    name = request.params['name']
    brand = request.params['brand']
    category_id = request.params['category_id']
    year = request.params['year']
    price = request.params['price']

    product_params = {
      'name' => name,
      'brand' => brand,
      'category_id' => category_id,
      'year' => year,
      'price' => price
    }

    new_product = Product.new(product_params)
    if new_product.save
      request.session['flash'] = 'Product created'
      [[], 302, { 'location' => '/products' }]
    else
      request.session['flash'] = 'Create failed'
      [[], 302, { 'location' => '/products/new' }]
    end
  end
end



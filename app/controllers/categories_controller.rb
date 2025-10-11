class CategoriesController < Frack::BaseController
  def index
    unless current_user
      request.session['flash'] = 'You must sign in to continue'
      return [[], 302, { 'location' => '/' }]
    end

    @categories = Category.order(:id).page(request.params['page']).per(25)
    render 'categories/index'
  end

  def new
    render 'categories/new'
  end

  def create
    name = request.params['name']
    category_params = { 'name' => name }

    if name.to_s.strip.empty?
      request.session['flash'] = 'Name cannot be blank'
      return [[], 302, { 'location' => '/categories/new' }]
    end

    new_category = Category.new(category_params)
    if new_category.save
      request.session['flash'] = 'Category created'
      [[], 302, { 'location' => '/categories' }]
    else
      request.session['flash'] = 'Create failed'
      [[], 302, { 'location' => '/categories/new' }]
    end
  end
end
class UsersController < Frack::BaseController
  def index
    @users = User.all
    render 'users/index'
  end

  def new 
    render 'users/new' 
  end

  def create
    email = request.params['email']
    password = request.params['password']
    password_confirmation = request.params['password_confirmation']
    
    if User.find_by(email: email)
      session = request.session
      session['flash'] = 'Email existed'
      [[], 302, { 'location' => '/sign_up' }]
    else
    @user = User.new(email: email, password: password, password_confirmation: password_confirmation)
    @user.save
    session = request.session
    session['flash'] = 'You have successfully signed up!'
      [[], 302, { 'location' => '/' }]
      end
  end
end
class UsersController < Frack::BaseController
  def index
    unless current_user
      request.session['flash'] = 'You must sign in to continue'
      return [[], 302, { 'location' => '/' }]
    end
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
    session = request.session
    if User.find_by(email: email)
      session['flash'] = 'Email existed'
      [[], 302, { 'location' => '/sign_up' }]
    else
    @user = User.new(email: email, password: password, password_confirmation: password_confirmation)
    @user.save
      session['flash'] = 'You have successfully signed up!'
      [[], 302, { 'location' => '/' }]
      end
  end
end
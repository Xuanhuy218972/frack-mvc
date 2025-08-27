class SessionsController < Frack::BaseController
    def new 
        [[], 302, { 'location' => '/' }]
    end

    def create
        email = request.params['email']
        password = request.params['password']
        user = User.find_by(email: email)
        
        if user && user.authenticate(password)
            request.session['user_id'] = user.id
            request.session['flash'] = 'Login successful!'
            [[], 302, { 'location' => '/' }]
        else 
            request.session['flash'] = 'Invalid email or password'
            [[], 302, { 'location' => '/' }]
        end
    end

    def destroy
        request.session['user_id'] = nil
        request.session['flash'] = 'You have successfully signed out!'
        [[], 302, { 'location' => '/' }]
    end
end
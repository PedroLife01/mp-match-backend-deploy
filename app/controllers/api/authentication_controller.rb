class Api::AuthenticationController < ApplicationController
    before_action :authorize_request, except: [:login, :logout]

    def login
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
            token = JsonWebToken.encode(user_id: user.id, is_admin: user.is_admin)
            time = Time.now + 24.hours.to_i

            render json: { user_id: user.id, user_name: user.name, auth_token: token, exp: time.strftime("%Y-%m-%d %H:%M UTC-3") }, status: :ok
        else
            render json: { error: 'unauthorized' }, status: :unauthorized
        end
    end

    def logout
        header = request.headers['Authorization']
        jwt = header.split(' ').last if header
        
        fork do
          # instead of making a cron job to run a script
          # to delete old jwt's, let's do it quick and dirty
          max_age = Time.zone.now - 1.day
          JwtBlacklist.where('created_at < ?', max_age).destroy_all
        end

        blacklisted = JwtBlacklist.new(jwt: jwt)

        if blacklisted.save
            render json: { msg: "successfull logout" }, status: :no_content
        else
            render json: { msg: "an error occurred when trying to logout" }, status: :unprocessable_entity
        end
    end

    private
        def login_params
            params.permit(:email, :password)
        end
end

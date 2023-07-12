class Api::PreferenceController < ApplicationController
    def create
        preference = Preference.new(preference_params)
        preference.save!

        render json: preference, status: :created

    rescue StandardError => err
        render json: err, status: :bad_request
    end
    
    def index
        preferences = Preference.all

        render json: preferences, status: :ok
    end

    # def show
    #     preference = Preference.find_by!(id: params[:id])

    #     render json: preference, status: :ok

    # rescue StandardError => err
    #     render json: {error: err}, status: :not_found
    # end

    # def show_by_user
    #     preference = Preference.find_by!(user_id: params[:user_id])

    #     render json: preference, status: :ok

    # rescue StandardError => err
    #     render json: {error: err}, status: :not_found
    # end

    private
        def preference_params
            params.permit(:id, :book, :movie, :show)
        end
        
end

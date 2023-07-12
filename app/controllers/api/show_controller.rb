class Api::ShowController < ApplicationController
    before_action :authorize_request, except: [:create, :destroy]
    before_action :authorize_admin_request, only: [:create, :destroy]

    def create
        show = Show.new(show_params)
        show.save!

        if params[:tag_name]
            show.tags << Tag.find_or_create_by(name: params[:tag_name])
        end

        render json: show, status: :created

    rescue StandardError => err
        render json: err, status: :bad_request
    end

    def index
        shows = Show.all

        render json: shows, status: :ok
    end

    def show
        show = Show.find_by(params[:id])

        render json: show, status: :ok

    rescue StandardError => err
        render json: {error: err}, status: :not_found
    end

    def destroy
        show = Show.find(params[:id])

        if show.destroy
            head :no_content
        end

        rescue StandardError => err
            render json: {error: err}, status: :bad_request
    end

    private
        def show_params
            params.permit(:id, :name, :director, :year)
        end
end

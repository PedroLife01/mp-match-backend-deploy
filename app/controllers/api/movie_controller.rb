class Api::MovieController < ApplicationController
    before_action :authorize_request, except: [:create, :destroy]
    before_action :authorize_admin_request, only: [:create, :destroy]

    def create
        movie = Movie.new(movie_params)
        movie.save!

        if params[:tag_name]
            movie.tags << Tag.find_or_create_by(name: params[:tag_name])
        end

        render json: movie, status: :created

    rescue StandardError => err
        render json: err, status: :bad_request
    end

    def index
        movies = Movie.all

        render json: movies, status: :ok
    end

    def movie
        movie = Movie.find_by(params[:id])

        render json: movie, status: :ok

    rescue StandardError => err
        render json: {error: err}, status: :not_found
    end

    def destroy
        movie = Movie.find(params[:id])

        if movie.destroy
            head :no_content
        end

        rescue StandardError => err
            render json: {error: err}, status: :bad_request
    end

    private
        def movie_params
            params.permit(:id, :name, :director, :year)
        end
end

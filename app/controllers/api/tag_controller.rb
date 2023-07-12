class Api::TagController < ApplicationController
    before_action :authorize_request, except: [:create, :destroy]
    before_action :authorize_admin_request, only: [:create, :destroy]

    def create
        tag = Tag.new(tag_params)
        tag.save!

        render json: tag, status: :created

    rescue StandardError => err
        render json: err, status: :bad_request
    end

    def index
        tags = Tag.all

        render json: tags, status: :ok
    end

    def show
        tag = Tag.find_by(params[:id])

        render json: tag, status: :ok

    rescue StandardError => err
        render json: {error: err}, status: :not_found
    end

    def destroy
        tag = Tag.find(params[:id])

        if tag.destroy
            head :no_content
        end

        rescue StandardError => err
            render json: {error: err}, status: :bad_request
    end

    private
        def tag_params
            params.permit(:id, :name)
        end
end

class Api::BookController < ApplicationController
    before_action :authorize_request, except: [:create, :destroy]
    before_action :authorize_admin_request, only: [:create, :destroy]
    
    def create
        book = Book.new(book_params)
        book.save!

        if params[:tag_name]
            book.tags << Tag.find_or_create_by(name: params[:tag_name])
        end

        render json: book, status: :created

    rescue StandardError => err
        render json: err, status: :bad_request
    end

    def index
        books = Book.all

        render json: books, status: :ok
    end

    def show
        book = Book.find_by(params[:id])

        render json: book, status: :ok

    rescue StandardError => err
        render json: {error: err}, status: :not_found
    end

    def destroy
        book = Book.find(params[:id])

        if book.destroy
            head :no_content
        end

        rescue StandardError => err
            render json: {error: err}, status: :bad_request
    end

    private
        def book_params
            params.permit(:id, :name, :author, :year, :npages)
        end
end

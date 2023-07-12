class Api::UserController < ApplicationController
    require 'string/similarity'
    
    # only a valid jwt can make a request
    # you don't need a jwt to create a user, obviously
    before_action :authorize_request, except: [:create, :connect_to_book, :connect_to_show, :connect_to_movie, :match_books, :match_shows, :match_movies, :get_users_by_preferences]

    # only an admin can index all users
    before_action :authorize_admin_request, only: [:index]

    def create
        @user = User.new(user_params)
        
        if @user.save
            render json: @user, status: :created
        else
            render json: @user.errors, status: :unprocessable_entity
        end


    rescue StandardError => err
        render json: { error: err }, status: :bad_request
    end

    def index
        @users = User.all

        render json: @users, status: :ok
    end

    def show
        @user = User.find_by!(id: params[:id])

        render json: @user, status: :ok

    rescue StandardError => err
        render json: {error: err}, status: :not_found
    end

    def update
        @user = User.find_by(id: params[:id])
        @user.update(user_params)

        if @user.save
            render json: @user, status: :ok
        else
            render json: @user.errors, status: :unprocessable_entity
        end

    rescue StandardError => err
        render json: {merror: err}, status: :bad_request
    end

    def destroy
        @user = User.find_by(id: params[:id])

        if @user.destroy
            head :no_content
        end

        rescue StandardError => err
            render json: {error: err}, status: :bad_request
    end

    def match_books
        # Get a list of all books names
        all_books = Book.all()
        # Get a string of all books that are preference of a user
        @user = User.find_by!(id: params[:user_id])
        user_books_names, user_books_list = get_user_books(@user)
        # Save preferences
        update_preference(@user, "book", user_books_names)
        # Calculate similarity
        match_list = calculate_similarity(all_books, user_books_list, user_books_names)

        render json: {books: match_list}, status: :ok

        rescue StandardError => err
            render json: {error: err}, status: :bad_request
    end

    def match_movies
        # Get a list of all movies names
        all_movies = Movie.all()
        # Get a string of all movies that are preference of a user
        @user = User.find_by!(id: params[:user_id])
        user_movies_names, user_movies_list = get_user_movies(@user)
        # Save preferences
        update_preference(@user, "movie", user_movies_names)
        # Calculate similarity
        match_list = calculate_similarity(all_movies, user_movies_list, user_movies_names)

        render json: {movies: match_list}, status: :ok

        rescue StandardError => err
            render json: {error: err}, status: :bad_request
    end

    def match_shows
        # Get a list of all shows names
        all_shows = Show.all()
        # Get a string of all shows that are preference of a user
        @user = User.find_by!(id: params[:user_id])
        user_shows_names, user_shows_list = get_user_shows(@user)
        # Save preferences
        update_preference(@user, "show", user_shows_names)
        # Calculate similarity
        match_list = calculate_similarity(all_shows, user_shows_list, user_shows_names)

        render json: {shows: match_list}, status: :ok

        rescue StandardError => err
            render json: {error: err}, status: :bad_request
    end
    
    def connect_to_book
        user = User.find_by(id: params[:user_id])
        book = Book.find_by(id: params[:book_id])

        unless user.books.include?(book)
            user.books << book
            # Get a list of all books names
            all_books_list = get_books_list()
            # Get a string of all books that are preference of a user
            @user = User.find_by!(id: params[:user_id])
            user_books_names, user_books_list = get_user_books(@user)
            # Save preferences
            update_preference(@user, "book", user_books_names)

            render json: {}, status: :ok
        else
            render json: { error: 'This user already has this book in the preferences.' }, status: :not_acceptable
        end

        rescue StandardError => err
            render json: {error: err}, status: :bad_request
    end

    def connect_to_show
        @user = User.find_by(id: params[:user_id])
        @show = Show.find_by(id: params[:show_id])

        unless @user.shows.include?(@show)
            @user.shows << @show
            # Get a list of all shows names
            all_shows_list = get_shows_list()
            # Get a string of all shows that are preference of a user
            @user = User.find_by!(id: params[:user_id])
            user_shows_names, user_shows_list = get_user_shows(@user)
            # Save preferences
            update_preference(@user, "show", user_shows_names)

            render json: {}, status: :ok
        else
            render json: { error: 'This user already has this show in the preferences.' }, status: :not_acceptable
        end

        rescue StandardError => err
            render json: {error: err}, status: :bad_request
    end

    def connect_to_movie
        @user = User.find_by(id: params[:user_id])
        @movie = Movie.find_by(id: params[:movie_id])

        unless @user.movies.include?(@movie)
            @user.movies << @movie
            # Get a list of all movies names
            all_movies_list = get_movies_list()
            # Get a string of all movies that are preference of a user
            @user = User.find_by!(id: params[:user_id])
            user_movies_names, user_movies_list = get_user_movies(@user)
            # Save preferences
            update_preference(@user, "movie", user_movies_names)

            render json: {}, status: :ok
        else
            render json: { error: 'This user already has this movie in the preferences.' }, status: :not_acceptable
        end

        rescue StandardError => err
            render json: {error: err}, status: :bad_request
    end

    def get_users_by_preferences
        @user = User.find_by(id: params[:user_id])
        user_list = []
        User.all.each do |user|
            unless user == @user
                match_dict = Hash.new
                match_dict["id"] = user.id
                match_dict["name"] = user.name
                book_sim = String::Similarity.cosine user.preference.book, @user.preference.book
                movie_sim = String::Similarity.cosine user.preference.movie, @user.preference.movie
                show_sim = String::Similarity.cosine user.preference.show, @user.preference.show
                match_dict["match"] = (book_sim + movie_sim + show_sim)/3
                user_list.append(match_dict)
            end
        end

        render json: {users: user_list}, status: :ok

        rescue StandardError => err
            render json: {error: err}, status: :bad_request
    end

    private
        def user_params
            params.permit(:id, :name, :email, :password, :is_admin)
        end

        def get_books_list()
            all_books_list = []
            Book.all.each do |book|
                all_books_list.append(book.name)
            end

            return all_books_list
        end

        def get_movies_list()
            all_movies_list = []
            Movie.all.each do |movie|
                all_movies_list.append(movie.name)
            end

            return all_movies_list
        end

        def get_shows_list()
            all_shows_list = []
            Show.all.each do |show|
                all_shows_list.append(show.name)
            end

            return all_shows_list
        end

        def get_user_books(user)
            user_books_names = ""
            user_books_list = []
          
            user.books.each do |book|
              user_books_names += book.name + " " + book.author + " " + book.year.to_s + " "
              user_books_list << book.name
              book.tags.each do |tag|
                user_books_names += tag.name + " "
              end
            end
          
            return user_books_names, user_books_list
        end

        def get_user_movies(user)
            user_movies_names = ""
            user_movies_list = []
          
            user.movies.each do |movie|
              user_movies_names += movie.name + " " + movie.director + " " + movie.tags.name + " "+ movie.year.to_s + " "
              user_movies_list << movie.name
              movie.tags.each do |tag|
                user_movies_names += tag.name + " "
              end
            end
          
            return user_movies_names, user_movies_list
        end

        def get_user_shows(user)
            user_shows_names = ""
            user_shows_list = []
          
            user.shows.each do |show|
              user_shows_names += show.name + " " + show.director + " " + show.tags.name + " " + show.year.to_s + " "
              user_shows_list << show.name
              show.tags.each do |tag|
                user_shows_names += tag.name + " "
              end
            end
          
            return user_shows_names, user_shows_list
        end

        def update_preference(user, attribute_name, value)
            # Update the attributes of the associated Preference
            user.preference.update(attribute_name => value) 
        end
 
        def calculate_similarity(all_objects_list, user_objects_list, user_objects_names)
            # Calculate cosine similarity
            object_list = []
            all_objects_list.each do |object|
                unless user_objects_list.include?(object.name)
                    match_dict = Hash.new
                    match_dict["id"] = object.id
                    match_dict["name"] = object.name
                    match_dict["match"] = String::Similarity.cosine user_objects_names, object.name
                    object_list.append(match_dict)
                end
            end

            return object_list
        end
        
end

class ShortenedUrlsController < ApplicationController
  def show
    @url = Shortener::ShortenedUrl.find_by_unique_key(params[:unique_key])
    p "PARMAS"
    p params
    p "URLURL"
    p @url
    @url.use_count += 1
    redirect_to "http:/#{@url.url}.com" # param truncates after '.' so I hardcoded. Not able to do .org, etc.
  end

  def new
    unless params[:unique_key].include?(",")
      @url = Shortener::ShortenedUrl.generate(params[:unique_key])
      render json: @url
    else
      array_of_urls = params[:unique_key].split(",")
      new_array_of_urls = []
      array_of_urls.each do |url|
        @url = Shortener::ShortenedUrl.generate(url)
        new_array_of_urls << @url
      end
        render json: new_array_of_urls

    end

    # p "*" * 100
    # p params
  end


  def index
    @url = Shortener::ShortenedUrl.find_by_unique_key(params[:unique_key])
    render json: @url
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


end

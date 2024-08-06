class GenresController < ApplicationController
  before_action :set_genre, only: [:edit, :update]

  def index
    @genres = Genre.all.order(name_en: :ASC)
  end

  def edit
  end

  def update
    respond_to do |format|
      if @genre.update(genre_params)
        format.json { render json: @genre, status: :ok }
      else
        format.json { render json: @genre.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name_en, :name_hu)
  end

end

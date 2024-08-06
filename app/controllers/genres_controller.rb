class GenresController < ApplicationController
  before_action :set_genre, only: [:edit, :update]

  def index
    @genres = Genre.all.order(name_en: :DESC)
  end

  def edit
  end

  def update
    if @genre.update(genre_params)
      redirect_to genres_path, notice: 'Genre was successfully updated.'
    else
      render :edit
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

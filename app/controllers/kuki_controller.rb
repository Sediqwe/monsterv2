class KukiController < ApplicationController
  def index
    @kuki = Kuki.all
  end

  def new
    @kuki = Kuki.new
  end

  def create
    @kuki = Kuki.new(kuki_params)

    respond_to do |format|
      if @kuki.save
        format.html { redirect_to kuki_url(@kuki), notice: "List was successfully created." }
        format.json { render :show, status: :created, location: @kuki }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @kuki.errors, status: :unprocessable_entity }
      end
    end
  end
  private
  def kuki_params
  params.require(:kuki).permit(:desc)
end
end

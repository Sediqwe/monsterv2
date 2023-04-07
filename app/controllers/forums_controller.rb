class ForumsController < ApplicationController
  before_action :set_forum, only: %i[ show edit update destroy ]

  # GET /forums or /forums.json
  def index
    @q = Forum.where(forumtype: :false).order(updated_at: :ASC).ransack(params[:q])
    @forums = @q.result(distinct: true).page(params[:page]).per(10)
   end

  # GET /forums/1 or /forums/1.json
  def show
    @tip = Forum.find(params[:id])
    @q  = Forum.where(forumpoint: @tip).where(forumtype: true).ransack(params[:q])
    @forum1 = @q.result(distinct: true).order(updated_at: :DESC).page(params[:page]).per(10)
  end
  def messages
    @forum = Forum.find(params[:forumid])
    @foforum = Forum.find(@forum.forumpoint)
    @message = Uzenet.where(game_id: @forum.gameid).order(created_at: :DESC)
  end
  # GET /forums/new
  def new
    @forum = Forum.new
  end
  def controll
    game_ids = Uzenet.distinct.pluck(:game_id)
    game_ids.each do |game_id|
      adat = Uzenet.where(game_id: game_id).order(created_at: :ASC).last
      edit = Forum.where(gameid: game_id).first
      edit.update(updated_at: adat.created_at)      
    end
  end
  # GET /forums/1/edit
  def edit
  end
  # Feltölti a fórum üzenetei alapján magát a fórumot. #OFF
  def automata
    game_ids = Uzenet.distinct.pluck(:game_id)
    game_ids.each do |game_id|
      adat = Game.find(game_id)
      #Forum.find_or_create_by(desc: adat.name, title: adat.name, user: current_user,forumtype: true, olvashato: false, gameid: game_id, forumpoint: 3)
    end
  end

  # POST /forums or /forums.json
  def create
    @forum = Forum.new(forum_params)
    @forum.user_id = current_user.id
    respond_to do |format|
      if @forum.save
        format.html { redirect_to forum_url(@forum), notice: "Forum was successfully created." }
        format.json { render :show, status: :created, location: @forum }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forums/1 or /forums/1.json
  def update
    respond_to do |format|
      if @forum.update(forum_params)
        format.html { redirect_to forum_url(@forum), notice: "Forum was successfully updated." }
        format.json { render :show, status: :ok, location: @forum }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forums/1 or /forums/1.json
  def destroy
    @forum.destroy

    respond_to do |format|
      format.html { redirect_to forums_url, notice: "Forum was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forum
      @forum = Forum.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def forum_params
      params.require(:forum).permit(:title, :desc, :user_id, :active, :olvashato, :forumtype, :gameid, :forumpoint)
    end
end

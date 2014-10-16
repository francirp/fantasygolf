class LeaguesController < ApplicationController
  def new
    @league = League.new
    @league.build_commissioner(user_id: current_user.id)
  end

  # def edit
  #   @league = League.find(params[:id])
  # end

  def show
    @league = League.find(params[:id])
  end

  # def index
  #   @leagues = League.all
  # end

  def create
    @league = League.new(league_params)
    @league.commissioner.user_id = current_user.id

    if @league.save
      redirect_to @league, notice: "Your league has been successfully created!"
    else
      #do something
    end
  end

  # def update
  #   @league = League.find(params[:id])

  #   if @league.update_attributes(league_params)
  #     #do something
  #   else
  #     #do something
  #   end
  # end

  # def destroy
  #   @league = League.find(params[:id])
  #   @league.destroy
  #   #redirect_to somewhere
  # end

  private

    def league_params
      params.require(:league).permit(:name, :commissioner_attributes => [:league_id, :user_id, :role, :id, '_destroy'])
    end
end

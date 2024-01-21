class GamesController < ApplicationController

  def create
    @user = current_user
    @game = Game.create(user_id: @user.id)


    if @game.save
      redirect_to game_path(@game)
    else
      redirect_to root_path
    end
  end

  def show
    @game = Game.find(params[:id])
    @player = @game.user
    @items = Item.all

    @item = @items.sample
  end
end

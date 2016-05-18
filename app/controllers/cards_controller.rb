class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy, :like]
  before_filter :set_search
  before_action :authenticate_user!, except: :index

  load_and_authorize_resource

  def index
    @cards = @q.result.includes(:user).page params[:page]
  end

  def show
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = current_user.cards.new(card_params)
    @card.save
    respond_with(@card)
  end

  def update
    @card.update(card_params)
    respond_with(@card)
  end

  def destroy
    @card.destroy
    respond_with(@card)
  end

  def like
    return unless current_user
    @card.upvote_by current_user
  end

  private

  def set_card
    @card = Card.find(params[:id] || params[:card_id])
  end

  def card_params
    params.require(:card).permit(:name, :description)
  end

  def set_search
    @q = Card.ransack(params[:q])
    @q.sorts = 'created_at desc' if @q.sorts.empty?
  end
end

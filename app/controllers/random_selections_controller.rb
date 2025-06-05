# app/controllers/random_selections_controller.rb
class RandomSelectionsController < ApplicationController
  def create
    @selection = RandomSelection.new(name: params[:name], price: params[:price])

    if @selection.save
      render json: { status: "ok", selection: @selection }
    else
      render json: { status: "error", errors: @selection.errors.full_messages }, status: :unprocessable_entity
    end
  end
end

# frozen_string_literal: true

class CiclesController < ApplicationController
  before_action :set_cicle, only: [:show, :update, :destroy]

  # GET /cicles
  def index
    @cicles = Cicle.all

    render(json: @cicles)
  end

  # GET /cicles/1
  def show
    render(json: @cicle)
  end

  # POST /cicles
  def create
    @cicle = Cicle.new(cicle_params)

    if @cicle.save
      render(json: @cicle, status: :created, location: @cicle)
    else
      render(json: @cicle.errors, status: :unprocessable_entity)
    end
  end

  # PATCH/PUT /cicles/1
  def update
    if @cicle.update(cicle_params)
      render(json: @cicle)
    else
      render(json: @cicle.errors, status: :unprocessable_entity)
    end
  end

  # DELETE /cicles/1
  def destroy
    @cicle.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cicle
    @cicle = Cicle.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def cicle_params
    params.require(:cicle).permit(:month, :year)
  end
end

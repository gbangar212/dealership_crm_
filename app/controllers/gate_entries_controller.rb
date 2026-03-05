class GateEntriesController < ApplicationController
  before_action :set_gate_entry, only: %i[show edit update destroy]

  def index
    @gate_entries = GateEntry.order(arrived_at: :desc, created_at: :desc)
  end

  def show
  end

  def new
    @gate_entry = GateEntry.new(arrived_at: Time.zone.today, status: "received")
  end

  def create
    @gate_entry = GateEntry.new(gate_entry_params)

    if @gate_entry.save
      redirect_to @gate_entry, notice: "Gate entry was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @gate_entry.update(gate_entry_params)
      redirect_to @gate_entry, notice: "Gate entry was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gate_entry.destroy
    redirect_to gate_entries_path, notice: "Gate entry was successfully removed.", status: :see_other
  end

  private

  def set_gate_entry
    @gate_entry = GateEntry.find(params[:id])
  end

  def gate_entry_params
    params.require(:gate_entry).permit(
      :vin,
      :make,
      :model,
      :year,
      :color,
      :mileage,
      :arrived_at,
      :stock_number,
      :status,
      :notes
    )
  end
end

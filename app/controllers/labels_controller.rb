class LabelsController < ApplicationController
  before_action :set_label, only: [:show, :edit, :update, :destroy]

  # GET /labels
  def index
    @labels = current_user.labels
  end

  # GET /labels/1
  def show
  end

  # GET /labels/new
  def new
    @label = Label.new
  end

  # GET /labels/1/edit
  def edit
    current_user_required(@label.user)
  end

  # POST /labels
  def create
    @label = Label.new(label_params)
    @label.user = current_user

    if @label.save
      redirect_to labels_path, notice: 'Label creer avec succès.'
    else
      render :new
    end
  end

  # PATCH/PUT /labels/1
  def update
    if @label.update(label_params)
      redirect_to labels_path, notice: 'mise à jour avec succès l étiquète.'
    else
      render :edit
    end
  end

  # DELETE /labels/1
  def destroy
    @label.destroy
    redirect_to labels_url, notice: 'Label was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_label
      @label = Label.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def label_params
      params.require(:label).permit(:name)
    end
end

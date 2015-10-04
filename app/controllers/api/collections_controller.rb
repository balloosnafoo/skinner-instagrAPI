class Api::CollectionsController < ApplicationController
  def create
    @collection = Collection.get_or_create(collection_params)
    if @collection.id
      render :show
    elsif @collection.save
      @collection.populate
      render :show
    else
      render json: @collection.errors.full_messages, status: :unprocesssable_entity
    end
  end

  def show
    @collection = Collection.find(params[:id])
    @offset = params[:offset] ? params[:offset].to_i : 0
    @posts = @collection.posts.limit(20).offset(@offset)
    render :show
  end

  private
  def collection_params
    params.require(:collection)
      .permit(:tag, :begin_time, :end_time)
  end
end

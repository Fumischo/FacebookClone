class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  def index

    if current_user.present?
      @pictures = Picture.all
      new
    else
      redirect_to new_user_path, notice: "ログインしてください"
    end
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    if @picture.save
      redirect_to pictures_path, notice: "記事を投稿しました。"
    else
      render 'index'
    end
  end

  def show
  end

  def edit
    if @picture.user_id == session[:user_id]
      else
        redirect_to pictures_path, notice: "他のユーザーの記事は編集できません。"
    end
  end

  def update
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "記事を編集しました。"
    else
      render 'edit'
    end
  end

  def destroy
    if @picture.user_id == session[:user_id]
      @picture.destroy
      redirect_to pictures_path, notice:"記事を削除しました。 "
      else
        redirect_to pictures_path, notice: "他のユーザーの記事は削除できません。"
    end
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  private

  def picture_params
    params.require(:picture).permit(:image, :image_cache, :content)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end
end
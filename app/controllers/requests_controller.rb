class RequestsController < ApplicationController
  before_action :user_signed_in?

  def index
    @requests = current_user.requests.paginate page: params[:page]
  end

  def new
    @request = Request.new
  end

  def create
    @request = current_user.requests.new request_params.merge(status: 0)
    if @request.save
      flash[:success] = t "flash.request.success"
      redirect_to requests_path
    else
      flash[:error] = t "flash.request.fail"
      render :new
    end
  end

  def destroy
    if Request.find(params[:id]).destroy
      flash[:success] = t "flash.request.deleted"
      redirect_to requests_path
    else
      flash[:info] = t "flash.request.undelete"
      redirect_to request.referer
    end
  end

  private
  def request_params
    params.require(:request).permit :book_name, :author, :pulisher
  end
end

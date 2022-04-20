class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.all.order(created_at: :desc)
    @tag_list = Tag.all
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "プロフィールを更新しました。"
      redirect_to customer_path(@customer)
    else
      flash.now[:alert] = "フォームへ情報を入力してください。"
      render "edit"
    end
  end

  def unsubscribe
    @customer = Customer.find(params[:id])
  end

  def withdrawal
    @customer = Customer.find(params[:id])
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会しました。またのご利用お待ちしております。"
    redirect_to root_path
  end

  def search
    redirect_to request.referer if params[:keyword] == ""
    # split_keywords = params[:keyword].split(/[[:blank:]]+/)
    # @customers = Customer.where("login_name like ?","%#{keyword}%")
    @customer = Customer.search(params[:keyword])
  end



  private

  def customer_params
    params.require(:customer).permit(:name, :login_name, :introduction, :profile_image)
  end

end

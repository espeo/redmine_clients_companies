class CompaniesController < ApplicationController
  layout 'admin'

  before_filter :require_admin
  before_filter :find_company, :except => [:index, :new, :create]

  helper :custom_fields

  def index
    @companies = Company.sorted.all
    respond_to do |format|
      format.html {
        @user_count_by_company_id = user_count_by_company_id
      }
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new
    @company.safe_attributes = params[:company]

    respond_to do |format|
      if @company.save
        format.html {
          flash[:notice] = l(:notice_successful_create)
          redirect_to(params[:continue] ? new_company_path : @company)
        }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def edit
  end

  def update
    @company.safe_attributes = params[:company]

    respond_to do |format|
      if @company.save
        flash[:notice] = l(:notice_successful_update)
        format.html { redirect_to(@company) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @company.destroy

    respond_to do |format|
      format.html { redirect_to(companies_path) }
    end
  end

  def add_users
    @users = User.where(:id => (params[:user_id] || params[:user_ids])).all
    @company.users << @users if request.post?
    respond_to do |format|
      format.html { redirect_to edit_company_path(@company, :tab => 'users') }
      format.js
    end
  end

  def remove_user
    @company.users.delete(User.find(params[:user_id])) if request.delete?
    respond_to do |format|
      format.html { redirect_to edit_company_path(@company, :tab => 'users') }
      format.js
    end
  end

  def autocomplete_for_employee
    respond_to do |format|
      format.js
    end
  end

  def autocomplete_for_user
    respond_to do |format|
      format.js
    end
  end

  private

  def find_company
    @company = Company.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def user_count_by_company_id
    h = User.joins(:companies).group('group_id').count
    h.keys.each do |key|
      h[key.to_i] = h.delete(key)
    end
    h
  end
end

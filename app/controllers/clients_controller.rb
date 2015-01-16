class ClientsController < ApplicationController
  layout 'admin'

  before_filter :require_admin
  before_filter :find_client, :only => [:show, :edit, :update, :destroy]

  helper :sort
  include SortHelper
  helper :custom_fields
  include CustomFieldsHelper

  def index
    sort_init 'lastname', 'asc'
    sort_update %w(lastname)

    @limit = per_page_option

    scope = Client
    scope = scope.like(params[:name]) if params[:name].present?
    scope = scope.in_company(params[:company_id]) if params[:company_id].present?
    scope = scope.in_group(params[:group_id]) if params[:group_id].present?

    @client_count = scope.count
    @client_pages = Paginator.new @client_count, @limit, params['page']
    @offset ||= @client_pages.offset
    @clients =  scope.order(sort_clause).limit(@limit).offset(@offset).all

    respond_to do |format|
      format.html {
        @companies = Company.all.sort
        @groups = Group.all.sort
        render :layout => !request.xhr?
      }
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new
    @client.safe_attributes = params[:client]

    respond_to do |format|
      if @client.save
        format.html {
          flash[:notice] = l(:notice_successful_create)
          redirect_to(params[:continue] ? new_client_path : @client)
        }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def edit
  end

  def update
    @client.safe_attributes = params[:client]

    respond_to do |format|
      if @client.save
        flash[:notice] = l(:notice_successful_update)
        format.html { redirect_to(@client) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @client.destroy

    respond_to do |format|
      format.html { redirect_to(clients_path) }
    end
  end

  private

  def find_client
    @client = Client.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end

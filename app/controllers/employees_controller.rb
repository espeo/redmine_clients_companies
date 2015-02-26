class EmployeesController < ApplicationController
  layout 'admin'

  before_filter :require_admin
  before_filter :find_employee, :only => [:show, :edit, :update, :destroy]

  helper :sort
  include SortHelper
  helper :custom_fields
  include CustomFieldsHelper

  def index
    sort_init 'lastname', 'asc'
    sort_update %w(lastname)

    @limit = per_page_option

    scope = Employee
    scope = scope.like(params[:name]) if params[:name].present?
    scope = scope.in_company(params[:company_id]) if params[:company_id].present?
    scope = scope.in_group(params[:group_id]) if params[:group_id].present?

    @employee_count = scope.count
    @employee_pages = Paginator.new @employee_count, @limit, params['page']
    @offset ||= @employee_pages.offset
    @employees =  scope.order(sort_clause).limit(@limit).offset(@offset).all

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
    @employee = Employee.new
  end

  def create
    @employee = Employee.new
    @employee.safe_attributes = params[:employee]

    respond_to do |format|
      if @employee.save
        format.html {
          flash[:notice] = l(:notice_successful_create)
          redirect_to(params[:continue] ? new_employee_path : @employee)
        }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def edit
  end

  def update
    @employee.safe_attributes = params[:employee]

    respond_to do |format|
      if @employee.save
        flash[:notice] = l(:notice_successful_update)
        format.html { redirect_to(@employee) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @employee.destroy

    respond_to do |format|
      format.html { redirect_to(employees_path) }
    end
  end

  private

  def find_employee
    @employee = Employee.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end

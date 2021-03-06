class VacanciesController < ApplicationController
  before_filter :assign_vacancy, :except => [:index, :new, :create]
  before_filter :store_token, :except => [:index, :new, :create]
  
  respond_to :html
  respond_to :xml, :only => :index
  
  def index
    @vacancies = Vacancy.available.page(params[:page]).per(6)
    respond_with(@vacancies)
  end

  def new
    respond_with(@vacancy = Vacancy.new)
  end

  def create
    @vacancy = Vacancy.new(params[:vacancy])

    if @vacancy.save
      VacancyMailer.creation_notice(@vacancy).deliver
      flash[:success] = t("vacancies.create.success")
    end
    
    respond_with(@vacancy, :location => @vacancy.persisted? ?  root_url : nil)
  end

  def show
    if authorize!(:read, @vacancy)
      respond_with(@vacancy)
    else
      render(:file => 'public/404.html', :layout => false, :status => :not_found)
    end
  end

  def edit
    if authorize!(:edit, @vacancy)
      respond_with(@vacancy)
    else
      render(:file => 'public/404.html', :layout => false, :status => :not_found)
    end
  end

  def update
    if authorize!(:update, @vacancy)
      @vacancy.update_attributes(params[:vacancy]) and flash[:success] = t("vacancies.update.success")
      respond_with(@vacancy)
    else
      render(:file => 'public/404.html', :layout => false, :status => :not_found)
    end
  end

  def destroy
    if authorize!(:destroy, @vacancy)
      @vacancy.destroy and flash[:success] = t("vacancies.destroy.success")
      respond_with(@vacancy)
    else
      render(:file => 'public/404.html', :layout => false, :status => :not_found)
    end
  end
  
  def approve
    if authorize!(:approve, @vacancy)
      @vacancy.approve! and flash[:success] = t("vacancies.approve.success")
      VacancyMailer.approval_notice(@vacancy).deliver
      respond_with(@vacancy)
    else
      render(:file => 'public/404.html', :layout => false, :status => :not_found)
    end
  end

  private
  
  # TODO: Move authorization code to separete module
  def assign_vacancy
    @vacancy = Vacancy.find_by_id!(params[:id])
  end
  
  def authorize!(action, vacancy)
    case action
    when :read
      return vacancy.approved? || admin?(vacancy)
    when :edit, :update
      return (vacancy.approved? && owner?(vacancy)) || admin?(vacancy)
    when :destroy, :approve
      return admin?(vacancy)
    else
      raise StandartError
    end
  end
  
  def owner?(vacancy)
    tokens.include?(vacancy.owner_token)
  end
  helper_method :owner?

  def admin?(vacancy)
    tokens.include?(vacancy.admin_token)
  end
  helper_method :admin?

  def token
    params[:token]
  end

  def tokens
    session[:tokens] || []
  end

  def store_token
    session[:tokens] = tokens.push(token).uniq if token.present?
  end
end
